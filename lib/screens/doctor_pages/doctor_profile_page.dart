import 'dart:ui';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/doctor_pages/doctor_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constant.dart';
import 'doctor_edit_profile.dart';

class DoctorProfilePage extends StatefulWidget {
  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  var _isLoading = false;
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<DoctorInfo>(context, listen: false)
        .GetDoctorProfile(context)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DoctorInfo>(context).doctorProfile;
    return Scaffold(
      body: Container(
        height: displayHeight(context) * 1,
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: displayHeight(context) * 0.042,
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          FeatherIcons.edit,
                          color:BasedBlueColor,
                        ),
                        onPressed: () {Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoctorProfileEditPage()),
                        );


                        }),
// Text("Edit Profile"),
                  ],
                ),
                SizedBox(width:15 ,),
                Column(
                  children: [
                    IconButton(
                        icon: Icon(
                          FeatherIcons.logOut,
                          color: Colors.red,
                        ),
                        onPressed: ()async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.remove("jwtd"); 
                          AwesomeDialog(
                              context: context,
                              dialogType: DialogType.QUESTION,
                            
                              headerAnimationLoop: true,
                              animType: AnimType.TOPSLIDE,
                              title: 'Warning',
                              desc:
                              'Do you want to Log Out?',
                             
                              btnCancelOnPress: () {},
                              btnOkColor: BasedBlueColor,
                              btnOkOnPress: ()async {
                                final pref = await SharedPreferences.getInstance();
                                            await pref.remove("jwtd");
                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      DoctorLoginPage()), (Route<dynamic> route) => false);}).show();

                        }),
// Text("Log Out"),
                  ],
                ),
              ],
            ),
          ),

          _isLoading
              ? Container(color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Wait a moment",style: TextStyle(fontSize: 20,color: BasedBlueColor),),
                  Image.asset("images/watting.gif")
                ],
              ))
              :Container(
            //height: displayHeight(context)*1,
            color: Colors.white,
            child: Column(
              children: [
                snapshot.data.doctor.avatarPath == null
                    ? Text("")
                    : CircleAvatar(
                  child: ClipOval(
                      child: Image.network(
                        snapshot.data.doctor.avatarPath,
                        height: displayHeight(context) * 0.3,
                        width: displayWidth(context) * 0.3,
                        fit: BoxFit.cover,
                      )),
                  radius: 50,
                  backgroundColor: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Bmdc ID:", style: ProfileInfoText),
                    Text(snapshot.data.bmdcId, style: ProfileInfoText),
                  ],
                ),
               SizedBox(height: displayHeight(context)*0.011,),
                Row(
                  children: [
                    Container(
                      width: displayWidth(context) * 0.5,
                      height: displayHeight(context) * 0.33,
                      child: Padding(
                        padding: const EdgeInsets.only(left:30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Name:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Gender:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Contact:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Degrees:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Designation:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Specialization:",
                              style: ProfileInfoText,
                            ),
                            Text(
                              "Hospital:",
                              style: ProfileInfoText,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: displayWidth(context) * 0.5,
                      height: displayHeight(context) * 0.33,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data.doctor.firstName,
                                style: NormalText,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  snapshot.data.doctor.lastName,
                                  style: NormalText,
                                ),
                              ),
                            ],
                          ),
                          snapshot.data.doctor.gender==null?Text(""):
                          Text(
                            snapshot.data.doctor.gender,
                            style: NormalText,
                          ),
                          snapshot.data.doctor.contact==null?Text(""):
                          Text(
                            snapshot.data.doctor.contact,
                            style: NormalText,
                          ),
                          snapshot.data.degree==null?Text(""):
                          Text(
                            snapshot.data.degree,
                            style: NormalText,
                          ),
                          snapshot.data.designation==null?Text(""):
                          Text(
                            snapshot.data.designation.designation,
                            style: NormalText,
                          ),
                          snapshot.data.specialization==null?Text(""):
                          SizedBox(
                            width: displayWidth(context)*0.5,
                            child: Text(
                              snapshot.data.specialization.name,
                               maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                              style: NormalText,
                            ),
                          ),
                          snapshot.data.hospitals==null?Text(""):Container(
                            height: 25,
                            color: Colors.white,
                            child: ListView.builder(
                              padding: EdgeInsets.only(bottom: 6,top: 2),
                              itemCount: snapshot.data.hospitals.length,
                                itemBuilder: (context,index){
                              return Text(snapshot.data.hospitals[snapshot.data.hospitals.length-1].name,
                                style: NormalText,);
                            }),
                          )
                         
                        
                        ],
                      ),
                    )
                  ],
                ),
                snapshot.data.schedules.isEmpty
                    ? Text("No schedule available",style: NormalText,)
                    : Container(
                  height: displayHeight(context) * .274,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: snapshot.data.schedules.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 6.0, left: 25, right: 25),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 12.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data.schedules[index]
                                                .dayOfWeek,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueAccent),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text("Start at: "),
                                          Text(snapshot
                                              .data.schedules[index].startAt
                                              .replaceAll(".00", "")),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text("End at: "),
                                          Text(snapshot
                                              .data.schedules[index].endAt
                                              .replaceAll(".00", "")),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Total Slots"),
                                      Text(
                                        snapshot.data.schedules[index]
                                            .maxNumberOfPatient
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[400],
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                          ),
                        );
                      }),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
