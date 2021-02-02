import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/models/patient_profile_get_respnse_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';


import './call.dart';
class IndexPages extends StatefulWidget {
  Appoinment _appoinment;
  IndexPages(this._appoinment);

  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPages> {
  /// create a channelController to retrieve text value
  final _channelController = TextEditingController();

  /// if channel textField is validated to have error
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    // dispose input controller
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 400,
          child: Provider(
            create: (context) => onJoin(),
            lazy: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              ],
            ),
          ),
        ),
      ),

    );
  }

  Future<void> onJoin() async {
    // update input validation

    await _handleCameraAndMic();
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
          channelName: widget._appoinment.id.toString(),
          role:_role ,
        ),
      ),
    );
  }

  Future<void> _handleCameraAndMic() async {

    await PermissionHandler().requestPermissions(
      [PermissionGroup.camera, PermissionGroup.microphone],
    );
  }
}
