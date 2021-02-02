import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/schedule_response_model.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:provider/provider.dart';

import 'doctor_home_screen_page.dart';


class TimeSlot extends StatefulWidget {
  final String dayName;
  const TimeSlot(this.dayName);
  @override
  _TimeSlotState createState() => _TimeSlotState();
}
class _TimeSlotState extends State<TimeSlot> {
  @override
  final storage = FlutterSecureStorage();
  int _personvalue;
  String _startTime;
  String _endTime;
  Future CreateShedule(String dayofweek)async{
    String doctorid = await storage.read(key: "doctor_id");
    String token =await storage.read(key: "key");
    final create_shedule_url="https://remote-doctor-api.herokuapp.com/api/v1/appoinment/schedule/create/$doctorid";

    var response = await http.post(create_shedule_url,body: jsonEncode(
        {
          "maxNumberOfPatient": _personvalue,
          "dayOfWeek":dayofweek,
          "startAt": _startTime,
          "endAt": _endTime,
        }
    ),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        });
    if(response.statusCode==200){
      SheduleResponseModel sheduleResponseModel =SheduleResponseModel.fromJson(jsonDecode(response.body));
      var status =sheduleResponseModel.status;
      if(status=="ok"){
        Fluttertoast.showToast(msg: "Your Shedule Crated ",fontSize: 20,backgroundColor:BasedBlueColor,textColor: Colors.white);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>DoctorHomeScreen()));
      }
    }

  }

  timePicker() async {
    TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now()
    );
    print(picked);
  }
  @override
  Widget build(BuildContext context) {
    var day =widget.dayName;
    var snapshot=Provider.of<DoctorInfo>(context).doctorProfile;
    return Scaffold(
      appBar: AppBar(title:Text("Set Your ${widget.dayName} Slot",) ,),
      body:snapshot.data.degree==null?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("Update your Profile Before Creating Schedule",style: NormalText,textAlign: TextAlign.center,),
        ],
      ): Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: displayHeight(context)*0.1,
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text("Maximum patient of a day:",style: TextStyle(fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton(
                      value: _personvalue,
                      items: [
                        DropdownMenuItem(
                          child: Text("1"),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text("2"),
                          value: 2,
                        ),
                        DropdownMenuItem(
                            child: Text("3"),
                            value: 3
                        ),
                        DropdownMenuItem(
                            child: Text("5"),
                            value: 5
                        ),
                        DropdownMenuItem(
                            child: Text("6"),
                            value: 6
                        ),
                        DropdownMenuItem(
                            child: Text("7"),
                            value: 7
                        ),
                        DropdownMenuItem(
                            child: Text("8"),
                            value: 8
                        ),
                        DropdownMenuItem(
                            child: Text("9"),
                            value: 9
                        ),
                        DropdownMenuItem(
                            child: Text("10"),
                            value: 10
                        ),
                        DropdownMenuItem(
                            child: Text("11"),
                            value: 11
                        ),
                        DropdownMenuItem(
                            child: Text("12"),
                            value: 13
                        ),
                        DropdownMenuItem(
                            child: Text("14"),
                            value: 14
                        ),
                        DropdownMenuItem(
                            child: Text("15"),
                            value: 15
                        ),
                        DropdownMenuItem(
                            child: Text("16"),
                            value: 16
                        ),
                        DropdownMenuItem(
                            child: Text("17"),
                            value: 17
                        ),
                        DropdownMenuItem(
                            child: Text("18"),
                            value: 18
                        ),
                        DropdownMenuItem(
                            child: Text("19"),
                            value: 19
                        ),
                        DropdownMenuItem(
                            child: Text("20"),
                            value: 20
                        ),
                        DropdownMenuItem(
                            child: Text("21"),
                            value: 21
                        ),
                        DropdownMenuItem(
                            child: Text("22"),
                            value: 22
                        ),
                        DropdownMenuItem(
                            child: Text("23"),
                            value: 23
                        ),
                        DropdownMenuItem(
                            child: Text("24"),
                            value: 24
                        ),
                        DropdownMenuItem(
                            child: Text("25"),
                            value: 25
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _personvalue = value;
                        });
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:12.0,right: 105),
                  child: Text("Start Time:",style: TextStyle(fontSize: 18),),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton(
                      value: _startTime,
                      items: [
                        DropdownMenuItem(
                          child: Text("6 AM"),
                          value: "06.00.00 AM",
                        ),
                        DropdownMenuItem(
                          child: Text("7 AM"),
                          value: "07.00.00 AM",
                        ),
                        DropdownMenuItem(
                            child: Text("8 AM"),
                            value: "08.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("9 AM"),
                            value: "09.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("10 AM"),
                            value: "10.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("11 AM"),
                            value: "11.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("12 PM"),
                            value: "12.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("1 PM"),
                            value: "01.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("2 PM"),
                            value: "02.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("3 PM"),
                            value: "03.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("4 PM"),
                            value: "04.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("5 PM"),
                            value: "05.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("6 PM"),
                            value: "06.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("7 PM"),
                            value: "07.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("8 PM"),
                            value: "08.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("9 PM"),
                            value: "09.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("10 PM"),
                            value: "10.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("11 PM"),
                            value: "11.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("12 AM"),
                            value: "12.00.00 AM"
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _startTime = value;
                        });
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:20.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:12.0,right: 120),
                  child: Text("End Time:",style: TextStyle(fontSize: 16),),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: DropdownButton(
                      value: _endTime,
                      items: [
                        DropdownMenuItem(
                          child: Text("6 AM"),
                          value: "06.00.00 AM",
                        ),
                        DropdownMenuItem(
                          child: Text("7 AM"),
                          value: "07.00.00 AM",
                        ),
                        DropdownMenuItem(
                            child: Text("8 AM"),
                            value: "08.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("9 AM"),
                            value: "09.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("10 AM"),
                            value: "10.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("11 AM"),
                            value: "11.00.00 AM"
                        ),
                        DropdownMenuItem(
                            child: Text("12 PM"),
                            value: "12.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("1 PM"),
                            value: "01.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("2 PM"),
                            value: "02.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("3 PM"),
                            value: "03.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("4 PM"),
                            value: "04.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("5 PM"),
                            value: "05.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("6 PM"),
                            value: "06.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("7 PM"),
                            value: "07.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("8 PM"),
                            value: "08.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("9 PM"),
                            value: "09.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("10 PM"),
                            value: "10.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("11 PM"),
                            value: "11.00.00 PM"
                        ),
                        DropdownMenuItem(
                            child: Text("12 AM"),
                            value: "12.00.00 AM"
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _endTime = value;
                        });
                      }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: displayHeight(context)*0.1,
          ),
          RaisedButton(
            padding: EdgeInsets.fromLTRB(40, 15, 40, 15),
            onPressed: () {
              if(_personvalue==null||_startTime==null||_endTime==null){
               Fluttertoast.showToast(msg: "Select Field's",fontSize: 20,backgroundColor:Colors.red,textColor: Colors.white,gravity: ToastGravity.CENTER);
              }
              else{
                CreateShedule(day);
              }
            },
            child: Text(
              " Save",
              style: TextStyle(fontSize: 18,color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.blueGrey,)),
            color: BasedBlueColor,
          ),
        ],
      ),
    );
  }
}
