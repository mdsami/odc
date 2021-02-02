import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_screen.dart';
import 'package:provider/provider.dart';

import '../../constants/constant.dart';

class PaymnetWithBkash extends StatefulWidget {
  String doctorid;
  PaymnetWithBkash(this.doctorid);
  @override
  _PaymnetWithBkashState createState() => _PaymnetWithBkashState();
}

class _PaymnetWithBkashState extends State<PaymnetWithBkash> {
  final storage = FlutterSecureStorage();
  var patientId;
  var userToken;
  getIdAndToken() async {
    var p = await storage.read(key: "userid");
    var u = await storage.read(key: "usertoken");
    setState(() {
      patientId = p;
      userToken = u;
    });
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url == "https://odc-pgw.herokuapp.com/success.html") {
        Fluttertoast.showToast(
            msg: " Your Appointment Created",
            fontSize: 18,
            backgroundColor: BasedBlueColor);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientHomeScreenPage()));
      }
      if (url == "https://odc-pgw.herokuapp.com/error.html") {
        Fluttertoast.showToast(
            msg: "Payment not succesfull",
            fontSize: 18,
            backgroundColor: Colors.red);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientHomeScreenPage()));
      }
    });
    print(patientId);
    print(userToken);
    print(widget.doctorid);
  }

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  void checkUrl() {
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url == "https://bkash-icddrb.netlify.app/success.html") {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => PatientHomeScreenPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var doctorId = widget.doctorid;
    return Scaffold(
      body: FutureProvider(
        create: (_) => getIdAndToken(),
        lazy: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child:patientId==null?Container(
              color: Color(0xfff50057),
              child: const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )),
            )
          : WebviewScaffold(
            url:
                "https://odc-pgw.herokuapp.com/index.html?did=$doctorId&pid=$patientId&token=$userToken",
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Color(0xfff50057),
              child: const Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              )),
            ),
          ),
        ),
      ),
    );
  }
}
