import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/search.dart';
import 'package:online_doctor_chember/screens/patient_pages/single_doctor_info_and_appiontment_taken.dart';
import 'package:provider/provider.dart';
import 'package:overlay_support/overlay_support.dart';

class PatientHomePage extends StatefulWidget {
  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  var _isLoading = false;
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<PatientInfo>(context, listen: false)
        .DoctorList( context )
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        showOverlayNotification((context) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                        child: Container(
                      color: Colors.black,
                    ))),
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));

        print(message['notification']['title']);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    final snapshot = Provider.of<PatientInfo>(context).getDoctorIngo;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 30,
            ),
            color: BasedBlueColor,
            onPressed: () {
              showSearch(context: context, delegate:SearchDoctor());
            },
            padding: EdgeInsets.only(right: 30),
          ),
        ],
        title: Text(
          " Find your consultant",
        ),
        backgroundColor:BasedBlueColor,
      ),
      drawer: Drawer(),
      body: _isLoading
          ? Container(
        color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Wait a moment",style: TextStyle(fontSize: 18,color: BasedBlueColor),),
              Image.asset("images/watting.gif"),
            ],
          ))
          :snapshot.data.length==0?Center(child:Text(" No Doctor Avaliable",style: TextStyle(fontSize: 18,color: BasedBlueColor,fontFamily: "Poppins",fontWeight: FontWeight.w400),)):
          ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
            return Padding(
            padding: const EdgeInsets.only(left:16.0,top: 5,right: 16),
            child: GestureDetector(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    DoctorInfoAndAppiontmentTaken(
                      snapshot.data[index]," "
                    )));
              },
              child: Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                       snapshot.data[index].user.avatarPath==null?CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: ClipOval(child: Image.asset("images/doctor.png",height: 100,width: 100,fit: BoxFit.cover,)),
                        ): CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: ClipOval(child: Image.network(snapshot.data[index].user.avatarPath,height: 100,width: 100,fit: BoxFit.cover,)),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.only(top:12.0),
                              child: Row(
                                children: [
                                  Text(
                                    snapshot.data[index].user.firstName,
                                    style: DoctorNameText,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    snapshot.data[index].user.lastName,
                                    style: DoctorNameText,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: SizedBox(
                                width: displayWidth(context)*0.4,
                                child: Text(
                                  snapshot.data[index].degree,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: DoctorDescriptionText,),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom:12.0),
                              child: SizedBox(
                                 width: displayWidth(context)*0.3,
                                child: Text(
                                  snapshot.data[index].specialization.name,
                                   maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                  style: DoctorDescriptionText,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                elevation: 4,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          );
          }
        
      ),
    );
  }
}
