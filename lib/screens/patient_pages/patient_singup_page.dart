import 'dart:convert';


import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_login_page.dart';
import 'package:http/http.dart'as http;

class PatientSignupPage extends StatefulWidget {
  @override
  _PatientSignupPageState createState() => _PatientSignupPageState();
}

class _PatientSignupPageState extends State<PatientSignupPage> {
  final TextEditingController  phoneNumber = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController  first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  @override
  Future singup() async{
    var singupUrl="https://remote-doctor-api.herokuapp.com/api/v1/auth/signup";
    var device_token= await firebaseMessaging.getToken();
    print("Before post"+device_token);
    var response= await http.post(singupUrl,body:jsonEncode({
      "contact":phoneNumber.text,
      "password":password.text,
      "firstName":first_name.text,
      "lastName":last_name.text,
      "role":"patient",
      "deviceId":device_token.toString(),
    }),headers: {"content-type":"application/json"} );
    print(response.body);
    if(response.statusCode==200){
      var singupData =jsonDecode(response.body);
      var status=singupData["status"];
      var message=singupData["message"];
      if(status=="ok"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientLoginPage()));
        Fluttertoast.showToast(
            msg: "Your Account Create Succesfully. Please Login",backgroundColor: BasedBlueColor, fontSize: 18
        );
      }
      else{
        Fluttertoast.showToast(msg: message,backgroundColor: Colors.red,fontSize: 18,);
      }
    }
  }
  bool _passwordhide=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            "Signup As A Patient",
                            style: PagesAppBarText),
                        SizedBox(
                          height: displayHeight(context)*.04,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10,top: 10),
                          child: TextFormField(
                            controller:phoneNumber,
                            keyboardType: TextInputType.phone,
                             validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter phone number';
              }
              return null;
            },
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
                          padding: const EdgeInsets.only(left:30.0,right: 30,top:10),
                          child: TextFormField(
                            controller: first_name,
                            obscureText: false,
                             validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter first name';
              }
              return null;
            },
                            decoration: InputDecoration(
                                labelText: " First name",
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
                          padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10,top: 20),
                          child: TextFormField(
                            controller:last_name,
                             validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter last name';
              }
              return null;
            },
                            decoration: InputDecoration(

                                labelText: 'Last Name',
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
                          padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 20,top: 10),
                          child: TextFormField(
                            controller: password,
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
                          padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                          child: Container(
                            height: displayHeight(context)*.06,
                            width: displayWidth(context)*.8,
                            child: ProgressButton(
                   defaultWidget:
                    const Text('Signup',  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Poppins'),),
                progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    borderRadius: 8,
                color:BasedBlueColor,
                type: ProgressButtonType.Flat,
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                   singup();
                  await Future.delayed(
                      const Duration(milliseconds: 8000), () =>0);   
                }},
              ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have Account ? ",
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => PatientLoginPage()));
                                  },
                                  child: Text(
                                    "Login",
                                    style: AccountSwitchBotton,
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
