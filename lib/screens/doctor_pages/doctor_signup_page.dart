import 'dart:convert';


import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/doctor_pages/doctor_login_page.dart';

class DoctorSignupPage extends StatefulWidget {
  @override
  _DoctorSignupPageState createState() => _DoctorSignupPageState();
}

class _DoctorSignupPageState extends State<DoctorSignupPage> {

  final TextEditingController  bmdcid = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController  first_name = TextEditingController();
  final TextEditingController last_name = TextEditingController();
  bool _passwordhide=true;
  final _formKey = GlobalKey<FormState>();
  Future singup() async{
    var singupUrl="https://remote-doctor-api.herokuapp.com/api/v1/auth/signup";
    var response= await http.post(singupUrl,body:jsonEncode({
      "bmdcId":bmdcid.text,
      "password":password.text,
      "firstName": first_name.text,
      "lastName": last_name.text,
      "role":"doctor",
    }),headers: {"content-type":"application/json"} );
    if(response.statusCode==200){
      print(response.body);
      var singupData =jsonDecode(response.body);
      var status=singupData["status"];
      var DoctorID=singupData["_id"];

      if(status=="ok"){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DoctorLoginPage()));
        Fluttertoast.showToast(
            msg: "Your Account Create Succesfully. Please Login",backgroundColor: BasedBlueColor, fontSize: 18
        );
      }
      else{
        Fluttertoast.showToast(msg: "Password must be 8 to 30 and 1 upper case 1 lower case 1 symbol!",backgroundColor: Colors.red,fontSize: 18);
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
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
                            "Signup As A Doctor",
                            style:PagesAppBarText),
                        SizedBox(
                          height: displayHeight(context)*.1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 10),
                          child: TextFormField(
                            controller:bmdcid,
                            keyboardType: TextInputType.number,
                                             validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter phone number';
              }
              return null;
            },
                            decoration: InputDecoration(

                                labelText: 'Enter BDMC Number',
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
                            controller:first_name,
                                             validator: (value) {
              if (value.isEmpty) {
               
                return 'Please enter first name';
              }
              return null;
            },
                
                            decoration: InputDecoration(

                                labelText: 'First Name',
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
                          padding: const EdgeInsets.only(left:30.0,right: 30,bottom: 20),
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
                          padding: const EdgeInsets.only(left:30.0,right: 30),
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
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _passwordhide=!_passwordhide;
                                  });
                                },
                                icon: Icon(_passwordhide?FeatherIcons.eyeOff:FeatherIcons.eye),
                              ),
                                labelText: "Enter Password",
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
                    const Text('Singup',  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Poppins'),),
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
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have account?",
                                  style: TextStyle(
                                      color: Colors.black, fontWeight: FontWeight.normal,fontSize: 16),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => DoctorLoginPage()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:4.0),
                                    child: Text(
                                      "Login",
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
