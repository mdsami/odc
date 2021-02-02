import 'dart:convert';

import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/all_doctor_info_get_model.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/models/patient_profile_get_respnse_model.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/payment.dart';
import 'package:provider/provider.dart';

class DoctorInfoAndAppiontmentTaken extends StatefulWidget {
  final Datum single_doctor_list;
  final String fee;
  const DoctorInfoAndAppiontmentTaken(this.single_doctor_list, this.fee);
  @override
  _DoctorInfoAndAppiontmentTakenState createState() =>
      _DoctorInfoAndAppiontmentTakenState();
}

class _DoctorInfoAndAppiontmentTakenState
    extends State<DoctorInfoAndAppiontmentTaken> {
  final storage = FlutterSecureStorage();
  Future TakingAppointment() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String AppointDate = formatter.format(now);

    var patient_id = await storage.read(key: "userid");
    var usertoken = await storage.read(key: "usertoken");
    var appionment_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/appoinment/create/$patient_id";
    var response = await http.post(appionment_url,
        body: jsonEncode(
            {"date": AppointDate, "doctorid": widget.single_doctor_list.id}),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": " Bearer $usertoken",
        });
    var decode = jsonDecode(response.body);
    var status = decode["status"];
    if (status == "failed") {
      Fluttertoast.showToast(
          msg: "Update Your Profile First",
          fontSize: 17,
          backgroundColor: Colors.red);
    } else {
      Fluttertoast.showToast(
          msg: " Your Appointment Created",
          fontSize: 17,
          backgroundColor: Colors.green);
    }
  }

  Future<PatientProfileResponseModel> GetPatinetProfileInfo() async {
    String userId = await storage.read(key: "userid");
    String usertoken = await storage.read(key: "usertoken");

    var patient_profile_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/patient/profile/$userId";

    var response = await http.get(patient_profile_url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $usertoken",
    });
    print(response.body);
    if (response.statusCode == 200) {
      PatientProfileResponseModel patientProfileResponseModel =
          PatientProfileResponseModel.fromJson(jsonDecode(response.body));
      return patientProfileResponseModel;
    }
  }

  bool sceandtime;
  Future Slot() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('MM-dd-yyyy');
    final String AppointDate = formatter.format(now);
    String doctorId = widget.single_doctor_list.id;
    String patientId = await storage.read(key: "userid");
    String usertoken = await storage.read(key: "usertoken");
    var statusUrl =
        "https://remote-doctor-api.herokuapp.com/api/v1/verify/slotavailable/$patientId";

    var response = await http.post(statusUrl,
        body: jsonEncode({"date": AppointDate, "doctorid": doctorId}),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": " Bearer $usertoken",
        });
    var decode = jsonDecode(response.body);
    print(decode["message"]);
    setState(() {
      sceandtime = decode["message"];
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var doctorid = widget.single_doctor_list.id;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Online Doctor"),
      ),
      body: FutureProvider(
        create: (ctx) async => Slot(),
        lazy: false,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            height: displayHeight(context),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    widget.single_doctor_list.user.avatarPath == null
                        ? Text("No Image")
                        : Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(widget
                                        .single_doctor_list.user.avatarPath)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                    SizedBox(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.single_doctor_list.user.firstName,
                                style: DoctorBoldName,
                              ),
                              SizedBox(width: 5),
                              Text(
                                widget.single_doctor_list.user.lastName,
                                style: DoctorBoldName,
                              )
                            ],
                          ),
                          Text(
                            widget.single_doctor_list.degree,
                            style: DoctorInfoNormal,
                          ),
                          widget.single_doctor_list.designation == null
                              ? Text("")
                              : Text(
                                  widget.single_doctor_list.designation
                                      .designation,
                                  style: DoctorInfoNormal,
                                ),
                          Text(
                            widget.single_doctor_list.specialization.name,
                            style: DoctorInfoNormal,
                          ),
                          Text(
                            widget.single_doctor_list.user.contact,
                            style: DoctorInfoNormal,
                          ),
                          Text(
                            widget.single_doctor_list.hospitals[0].name,
                            style: DoctorInfoNormal,
                          ),
                          Text(
                            widget.single_doctor_list.hospitals[0].location,
                            style: DoctorInfoNormal,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 12.0, right: 12, top: 12),
                  child: Text(
                    widget.single_doctor_list.specialization.description,
                    style: DoctorInfoNormal,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  height: displayHeight(context) * .48,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                        itemCount: widget.single_doctor_list.schedules.length,
                        itemBuilder: (context, index) {
                          var dd = widget
                              .single_doctor_list.schedules[index].startAt;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Schedule",
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right:4.0),
                                      child: Text("Pay the fee with bkash",style: NormalText,),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    FeatherIcons.calendar,
                                                    color: IconColorPad,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        displayWidth(context) *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    widget
                                                        .single_doctor_list
                                                        .schedules[index]
                                                        .dayOfWeek,
                                                    style: AppionCardTextBold,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    FeatherIcons.clock,
                                                    color: IconColorPad,
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        displayWidth(context) *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    widget
                                                        .single_doctor_list
                                                        .schedules[index]
                                                        .startAt
                                                        .toString()
                                                        .replaceAll(".00", ""),
                                                    style: Appion15font,
                                                  ),
                                                  Text("-"),
                                                  Text(
                                                    widget.single_doctor_list
                                                        .schedules[index].endAt
                                                        .replaceAll(".00", ""),
                                                    style: Appion15font,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        sceandtime == false
                                            ? FlatButton(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 25, 10, 25),
                                                color: Colors.grey,
                                                onPressed: () {},
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                child: Text(
                                                  "No Slot Available ",
                                                  style: PagesBottonText,
                                                ))
                                            : sceandtime == true
                                                ? FlatButton(
                                                    padding: EdgeInsets.fromLTRB(
                                                        queryData.size.width *
                                                            0.03,
                                                        queryData.size.height *
                                                            0.035,
                                                        queryData.size.width *
                                                            0.03,
                                                        queryData.size.height *
                                                            0.035),
                                                    onPressed: () {
                                                     
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PaymnetWithBkash(
                                                                      doctorid)));
                                                    },
                                                    color: BasedBlueColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0)),
                                                    child: Text(
                                                      "Take Appiontment",
                                                      style: PagesBottonText,
                                                    ))
                                                : Text(""),
                                      ],
                                    ),
                                  ),
                                  color: Colors.white,
                                  margin: EdgeInsets.all(4),
                                  elevation: 4,
                                  shadowColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                              ),
                            ],
                          );
                        }),
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
