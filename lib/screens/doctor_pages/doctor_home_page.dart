import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/prescription/create_prescription.dart';
import 'package:online_doctor_chember/video_call/index.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:badges/badges.dart';

import '../../screen_size_helper/sized_helper.dart';
import '../../screen_size_helper/sized_helper.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  final String serverToken =
      'AAAAzoPSv_E:APA91bEysQUT6oZOWtGRkKPots44p9oK_0ge_SvtpmSRTxrepcasmupbykXacnp6QgZhhsfDjLJz3VJeom-v5-HbeJJJMsBrnoUa5Kb1RP92OKDvmqEBpE-e2T6gOJFEQJ9CCm86KbmR';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  var _isLoading = false;
  var msgReciver;
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

  Future<Map<String, dynamic>> sendMessage(msg_recever) async {
    var data = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'Doctor wants to talk with you join the call',
            'title': 'Online Doctor Chamber'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done'
          },
          'to': msg_recever,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<DoctorInfo>(context).doctorProfile;
    
    return Scaffold(
        body: _isLoading
            ? Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fetching Data",
                      style: TextStyle(fontSize: 20, color: BasedBlueColor),
                    ),
                    Image.asset("images/watting.gif")
                  ],
                ))
            : Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: displayHeight(context) * .28,
                          width: displayWidth(context) * 0.05,
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                              child: snapshot.data.doctor.avatarPath == null
                                  ?Image.asset(
                                      "images/doctor.png",
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      snapshot.data.doctor.avatarPath,
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        SizedBox(
                          width: displayWidth(context) * .07,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: displayWidth(context)*0.4,
                              child: Row(
                                children: [
                                  Text(
                                    snapshot.data.doctor.firstName +
                                        " " +
                                        snapshot.data.doctor.lastName,
                                    style: ProfileInfoText,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: snapshot.data.degree == null
                                  ? Text("")
                                  : Text(snapshot.data.degree,
                                      style: NormalText),
                              width: displayWidth(context) * 0.48,
                            ),
                            snapshot.data.designation == null
                                ? Text("")
                                : Text(
                                    snapshot.data.designation.designation,
                                    style: NormalText,
                                  ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Patient list",
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                   
                    Container(
                      height: displayHeight(context) * .5,
                      child: snapshot.data.appoinments.length==0?Center(child: Text("No Appiontments",style: NormalText,)): ListView.builder(
                        itemBuilder: (context, index) {
                          if (snapshot.data.appoinments[index].isComplete ==
                              false) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 12.0, right: 12,bottom: 12),
                              child: Container(
                                height: displayHeight(context) * .16,
                              
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: displayWidth(context)*0.45,
                                            child: Row(
                                              children: [
                                                snapshot
                                                            .data
                                                            .appoinments[index]
                                                            .patient
                                                            .firstName ==
                                                        null
                                                    ? Text("")
                                                    : SizedBox(
                                                        width: displayWidth(context)*0.45,
                                                        child: Text(
                                                          snapshot
                                                                  .data
                                                                  .appoinments[
                                                                      index]
                                                                  .patient
                                                                  .firstName +
                                                              " " +
                                                              snapshot
                                                                  .data
                                                                  .appoinments[
                                                                      index]
                                                                  .patient
                                                                  .lastName,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20.0),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.watch_later_outlined),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  snapshot.data
                                                      .appoinments[index].time,
                                                  style: NormalText,
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 0.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Serial No:",
                                                  style: NormalText,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    snapshot
                                                        .data
                                                        .appoinments[index]
                                                        .serialNum
                                                        .toString(),
                                                    style: NormalText,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      snapshot.data.appoinments[index]
                                                  .isSecondTime ==
                                              false
                                          ? Text(
                                              "          ",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )
                                          : Badge(
                                              toAnimate: true,
                                              shape: BadgeShape.square,
                                              badgeColor:BasedBlueColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              badgeContent: Text('Old',
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                      IconButton(
                                          icon: new Icon(
                                            FeatherIcons.clipboard,
                                            color: IconColorPad,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        PerscriptionCreate(
                                                            snapshot.data
                                                                    .appoinments[
                                                                index])));
                                          }),
                                      IconButton(
                                        icon: Icon(
                                          FeatherIcons.video,
                                          color: IconColorVideo,
                                        ),
                                        onPressed: () {
                                          
                                          var msg_recever = snapshot
                                              .data
                                              .appoinments[index]
                                              .patient
                                              .deviceId;
                                          sendMessage(msg_recever);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => IndexPage(
                                                    snapshot.data
                                                        .appoinments[index])),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                              ),
                            );
                          } else {
                            return Text("");
                          }
                        },
                        itemCount: snapshot.data.appoinments.length,
                      ),
                    )
                  ],
                ),
              ));
  }
}