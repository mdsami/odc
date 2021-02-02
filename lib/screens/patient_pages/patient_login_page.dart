import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/patient_login_response_model.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_screen.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_singup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class PatientLoginPage extends StatefulWidget {
  @override
  _PatientLoginPageState createState() => _PatientLoginPageState();
}

class _PatientLoginPageState extends State<PatientLoginPage> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController Password = TextEditingController();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  Future<PatientLoginResponseModel> login() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     var device_token= await firebaseMessaging.getToken();
    var loginUrl = "https://remote-doctor-api.herokuapp.com/api/v1/auth/signin";
    var response= await http.post(loginUrl,body:jsonEncode({
      "contact":phoneNumber.text,
      "password":Password.text,
      "role":"patient",
      "deviceId":device_token.toString(),
    }),headers: {"Content-Type":"application/json"} );
    print(response.body);
    var decode= jsonDecode(response.body);
    var check=decode["status"];
    if(check=="failed"){
      Fluttertoast.showToast(msg: "Log in Falied! Invalid Credantial ",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
    }else{
      PatientLoginResponseModel patientLoginResponseModel= PatientLoginResponseModel.fromJson(jsonDecode(response.body));
      var status=patientLoginResponseModel.status;
      var token= patientLoginResponseModel.token;
      var userId=patientLoginResponseModel.data.id;
      if (status=="ok") {
        await storage.write(key:"usertoken", value: token);
        await storage.write(key:"userid", value: userId);
        await prefs.setString('jwtp', token);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      PatientHomeScreenPage()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: "Log in Successfull",fontSize: 20,backgroundColor:BasedBlueColor,textColor: Colors.white,);
      }
      else{
        print(response.body);
        Fluttertoast.showToast(msg: "Log in Falied! Incorrect crediantial.",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
      }
      return patientLoginResponseModel;
    }
  }
  bool _passwordhide=true;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body:  Stack(
          children: [
            Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'images/loginsvg.svg',
                  width: 400,
                  height: 150,
                  color: BasedBlueColor,
                )),
            SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: displayHeight(context)*.2,
                      ),
                      Text(
                        "Login As A Patient",
                        style: PagesAppBarText,
                      ),
                      SizedBox(
                        height: displayHeight(context)*.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 20,top: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter phone number';
              }
              return null;
            },
                          controller: phoneNumber,
                          decoration: InputDecoration(
                              labelText: 'Enter Phone Number',
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 20,top: 20),
                        child: TextFormField(
                          controller: Password,
                          validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter password';
              }
              return null;
            },
                          obscureText: _passwordhide,
                          decoration: InputDecoration(
                              labelText: 'Enter Password',
                              suffixIcon: IconButton(
                                icon: Icon(_passwordhide?FeatherIcons.eyeOff:FeatherIcons.eye),
                                onPressed: (){
                                  setState(() {
                                    _passwordhide=!_passwordhide;
                                  });
                                },
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.blue)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  borderSide: BorderSide(color: Colors.red))),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 25, 16, 0),
                        child: Container(
                          height: displayHeight(context)*.06,
                          width: displayWidth(context)*.8,
                          child:ProgressButton(
                   defaultWidget:
                    const Text('Login',  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Poppins'),),
                progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    borderRadius: 8,
                color:BasedBlueColor,
                type: ProgressButtonType.Flat,
                onPressed: () async {
                   if(_formKey.currentState.validate()){
                    login();
                  await Future.delayed(
                      const Duration(seconds: 6), () =>0);
                }},
              ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "I don't have any account",
                                style: TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => PatientSignupPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left:4.0),
                                  child: Text(
                                    "Signup",
                                    style: AccountSwitchBotton,
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}
