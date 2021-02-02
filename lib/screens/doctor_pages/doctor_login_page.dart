import 'dart:convert';


import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/doctor_login_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/doctor_pages/doctor_signup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'doctor_home_screen_page.dart';
class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  final storage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  TextEditingController bmdcid = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<DoctorLoginResponseModel> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var loginUrl = "https://remote-doctor-api.herokuapp.com/api/v1/auth/signin";
    var response= await http.post(loginUrl,body:jsonEncode({
      "bmdcId":bmdcid.text,
      "password":password.text,
      "role":"doctor",
    }),headers: {"Content-Type":"application/json"} );

    print(response.body);
    var decode= jsonDecode(response.body);
    var check=decode["status"];
    if(check=="failed"){
      Fluttertoast.showToast(msg: "Log in Failed !! Invalid Credential ",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
    }
    else{
      DoctorLoginResponseModel doctorLoginResponseModel=DoctorLoginResponseModel.fromJson(jsonDecode(response.body));
      var status =doctorLoginResponseModel.status;
      var token =doctorLoginResponseModel.token;
      var doctor_id = doctorLoginResponseModel.data.id;
      await storage.write(key:"doctor_id", value: doctor_id);
      await storage.write(key:"key", value: token);
      await prefs.setString('jwtd', token);
      if (status=="ok") {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                     DoctorHomeScreen()), (Route<dynamic> route) => false);
        Fluttertoast.showToast(msg: "Log in Successfull",fontSize: 20,backgroundColor: BasedBlueColor,textColor: Colors.white);
      }
      else{
        Fluttertoast.showToast(msg: "Log in Falied! Invalid Credantial ",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
      }
      //return doctorLoginModel;
    }
  }
  bool _passwordhide=true;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Stack(
          children: [
            Positioned(
                top: 0,
                child: SvgPicture.asset(
                  'images/loginsvg.svg',
                  width: 400,
                  height: 150,
                  color:Color(0xff1A73E9),
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
                        "Login As A Doctor",style: PagesAppBarText,),
                      SizedBox(
                        height: displayHeight(context)*.1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 20),
                        child: TextFormField(
                          controller: bmdcid,
                                       validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter BMDC number';
              }
              return null;
            },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: 'BMDC ID',
                    
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
                        padding: const EdgeInsets.only(left:30.0,right: 30),
                        child: TextFormField(
                          controller: password,
                          obscureText: _passwordhide,
                                          validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter password';
              }
              return null;
            },
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(_passwordhide?FeatherIcons.eyeOff:FeatherIcons.eye),
                              onPressed: (){
                                setState(() {
                                  _passwordhide=!_passwordhide;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(),
                        ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: Container(
                          height: displayHeight(context)*.06,
                          width: displayWidth(context)*.8,
                          child: ProgressButton(
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
                      const Duration(seconds: 6));
                     
                }},
              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:36.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "I don't have any account",
                              style: TextStyle(
                                  color: Colors.black, fontWeight: FontWeight.w400,fontSize: 16),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) => DoctorSignupPage()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Text(
                                    "Signup",
                                    style:AccountSwitchBotton ,
                                  ),
                                )),
                          ],
                        ),
                      )
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
