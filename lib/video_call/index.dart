import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/models/doctor_profile_response_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import './call.dart';
class IndexPage extends StatefulWidget {
  final Appoinment _appoinment;
  IndexPage(this._appoinment);
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<IndexPage> {
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
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //         child: TextField(
                //           controller: _channelController,
                //           decoration: InputDecoration(
                //             errorText:
                //             _validateError ? 'Channel name is mandatory' : null,
                //             border: UnderlineInputBorder(
                //               borderSide: BorderSide(width: 1),
                //             ),
                //             hintText: 'Channel name',
                //           ),
                //         ))
                //   ],
                // ),
                // Column(
                //   children: [
                //     ListTile(
                //       title: Text(ClientRole.Broadcaster.toString()),
                //       leading: Radio(
                //         value: ClientRole.Broadcaster,
                //         groupValue: _role,
                //         onChanged: (ClientRole value) {
                //           setState(() {
                //             _role = value;
                //           });
                //         },
                //       ),
                //     ),
                //     ListTile(
                //       title: Text(ClientRole.Audience.toString()),
                //       leading: Radio(
                //         value: ClientRole.Audience,
                //         groupValue: _role,
                //         onChanged: (ClientRole value) {
                //           setState(() {
                //             _role = value;
                //           });
                //         },
                //       ),
                //     )
                //   ],
                // ),

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
