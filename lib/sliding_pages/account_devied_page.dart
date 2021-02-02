import 'package:flutter/material.dart';
import 'package:online_doctor_chember/animations/fade_animation.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/doctor_pages/doctor_login_page.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_login_page.dart';





class AccountType extends StatefulWidget {
  @override
  _AccountTypeState createState() => _AccountTypeState();
}

class _AccountTypeState extends State<AccountType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeAnimation(
          .5,
          Container(
            width: displayWidth(context)*1.0,
            height: displayHeight(context)*1.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: displayHeight(context)*.2,
                ),
                Text("Select your account",style:PagesAppBarText),
                SizedBox(
                  height: displayHeight(context)*.2,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:25.0,right: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonTheme(
                        buttonColor: Colors.white,
                        minWidth:displayWidth(context)*.03,
                        height:displayHeight(context)*.18,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>PatientLoginPage() ),
                            );
                          },
                          child:Container(
                            color: Colors.white,
                            height:displayHeight(context)*.25,
                            width: displayWidth(context)*.27,
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('images/patient.png'),
                                ),
                                SizedBox(
                                  height: displayHeight(context)*0.02,
                                ),
                                Text("Patient",style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: BasedBlueColor)
                          ),
                        ),
                      ),
                      Text("or",style: NormalText,),
                      ButtonTheme(
                        buttonColor: Colors.white,
                        minWidth:displayWidth(context)*.03,
                        height:displayHeight(context)*.17,
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DoctorLoginPage()),
                            );
                          },
                          child:Container(
                            color: Colors.white,
                            height:displayHeight(context)*.25,
                            width: displayWidth(context)*.27,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset('images/doctor.png',),
                                ),
                                SizedBox(
                                  height: displayHeight(context)*0.02,
                                ),
                                Text("Doctor",style: TextStyle(fontSize: 16),)
                              ],
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            side: BorderSide(color: BasedBlueColor)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
