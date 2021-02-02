import 'dart:convert';
import 'dart:ffi';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/prescription_view_model.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/screens/doctor_pages/doctor_home_screen_page.dart';
import 'package:provider/provider.dart';

class CreateMedicen extends StatefulWidget {
  String prescriptionId;
  String patientId;
  String appiontmentId;
  CreateMedicen(this.prescriptionId, this.patientId, this.appiontmentId);
  @override
  _CreateMedicenState createState() => _CreateMedicenState();
}

class _CreateMedicenState extends State<CreateMedicen> {
  final _medicneform = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();
  TextEditingController _medichinename = TextEditingController();
  final _numberofdays = TextEditingController();
  final _takemorning = TextEditingController();
  final _takelunch = TextEditingController();
  final _takedinner = TextEditingController();
  bool moringvalue = false;
  bool lunchvalue = false;
  bool dinnervalue = false;
  bool consult = true;
  var _isLoading = false;
  var medicinestatus;
  Future CreateMedicine() async {
    var prescriptionId = widget.prescriptionId;
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var createMedicenUrl =
        "https://remote-doctor-api.herokuapp.com/api/v1/medicine/create/$doctorid/$prescriptionId";
    var response = await http.post(createMedicenUrl,
        body: jsonEncode({
          "medicine": {
            "name": _medichinename.text,
            "company": "a",
          },
          "suggest": {
            "morning": moringvalue,
            "takeAtMorning":
                _takemorning == null ? 0 : int.parse(_takemorning.text),
            "lunch": lunchvalue,
            "takeAtLunch": _takelunch == null ? 0 : int.parse(_takelunch.text),
            "dinner": lunchvalue,
            "takeAtDinner":
                _takedinner == null ? 0 : int.parse(_takedinner.text),
            "numberOfDays":
                _numberofdays == null ? 0 : int.parse(_numberofdays.text),
          }
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        }).then((value) {
      print(value.body);
      var decode = jsonDecode(value.body);
      var status = decode["status"];
      setState(() {
        medicinestatus = status;
      });
    }).then((value) {
      _medichinename.clear();
      _numberofdays.clear();
      _takemorning.clear();
      _takelunch.clear();
      _takedinner.clear();
    });
  }

  Future ConsultComplete() async {
    String token = await storage.read(key: "key");
    var patientID = widget.patientId;
    var appiontmentID = widget.appiontmentId;
    var url =
        "https://remote-doctor-api.herokuapp.com/api/v1/appoinment/modify/$patientID/$appiontmentID";
    var response = await http.patch(url,
        body: jsonEncode({
          "doctorConsent": false,
          "patientConsent": false,
          "isComplete": consult
        }),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        });
    var decode = jsonDecode(response.body);
    var status = decode["status"];
    if (status == "ok") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DoctorHomeScreen()));
    }
  }

  Future<PrescriptionViewModel> AllPrecriptionView() async {
    var token = await storage.read(key: "key");
    var prescriptionID = widget.prescriptionId;
    var url =
        "https://remote-doctor-api.herokuapp.com/api/v1/prescription/$prescriptionID";
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $token",
    });
    PrescriptionViewModel prescriptionViewModel =
        PrescriptionViewModel.fromJson(jsonDecode(response.body));
    print(prescriptionViewModel
        .data.newPrescription.medicinesSuggested[0].medicine.name);
    return prescriptionViewModel;
  }

  Future<Void> deleteMedicine(String mId) async {
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var deleteURL =
        "https://remote-doctor-api.herokuapp.com/api/v1/medicine/remove/$doctorid/$mId";
    var response = await http.delete(deleteURL, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $token",
    });
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: BasedBlueColor,
          title: Text(
            "Medicine",
          )),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, top: 8),
                    child: medicinestatus == null
                        ? FlatButton.icon(
                            onPressed: null,
                            label: Text(
                              "Done",
                              style: TextStyle(fontSize: 20),
                            ),
                            icon: Icon(
                              FeatherIcons.checkCircle,
                              size: 22,
                            ),
                          )
                        : FlatButton.icon(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            onPressed: () {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.SUCCES,
                                  headerAnimationLoop: true,
                                  animType: AnimType.TOPSLIDE,
                                  title: 'Consulted is Complete?',
                                  desc: " ",
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () {
                                    ConsultComplete();
                                  }).show();
                            },
                            label: Text(
                              "Done",
                              style: TextStyle(fontSize: 20),
                            ),
                            icon: Icon(
                              FeatherIcons.checkCircle,
                              size: 22,
                            ),
                            color: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            textColor: Colors.white,
                          ),
                  ),
                ],
              ),
              Container(
                child: Form(
                  key: _medicneform,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 10),
                        child: TextField(
                          controller: _medichinename,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: "Medicine Name",
                            hintText: "Napa",
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 10),
                        child: TextField(
                          controller: _numberofdays,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Number of days",
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * .02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 190.0, bottom: 10, top: 15),
                        child: Text(
                          "Medicine taking time",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9.0, right: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: displayHeight(context) * .12,
                              width: displayWidth(context) * .31,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _takemorning,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Breakfast",
                                      border: const OutlineInputBorder(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: displayHeight(context) * .12,
                              width: displayWidth(context) * .31,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  TextField(
                                    controller: _takelunch,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: "Lunch",
                                      border: const OutlineInputBorder(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: displayHeight(context) * .12,
                              width: displayWidth(context) * .31,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 9.0),
                                    child: TextField(
                                      controller: _takedinner,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        labelText: "Dinner",
                                        border: const OutlineInputBorder(),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      RaisedButton.icon(
                        padding: EdgeInsets.only(
                            left: 30, right: 30, top: 15, bottom: 15),
                        onPressed: () {
                          CreateMedicine();
                        },
                        label: Text(
                          "Add Medicine",
                          style: TextStyle(fontSize: 20),
                        ),
                        icon: Icon(
                          FeatherIcons.plusCircle,
                          size: 22,
                        ),
                        color: BasedBlueColor,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Text("List Of Medicine",style: AppionCardTextBold,),
                  ],
                ),
              ),
              FutureBuilder<PrescriptionViewModel>(
                future: AllPrecriptionView(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Text(
                          "No medicine added",
                          style: NormalText,
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      color: Colors.white,
                      height: displayHeight(context) * 0.3,
                      child: ListView.builder(
                          itemCount: snapshot.data.data.newPrescription
                              .medicinesSuggested.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Icon(
                                      FeatherIcons.arrowRight,
                                      color: Colors.orange,
                                    ),
                                  ),
                                  SizedBox(
                                    width: displayWidth(context) * .35,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 30.0),
                                      child: Text(
                                        snapshot
                                            .data
                                            .data
                                            .newPrescription
                                            .medicinesSuggested[index]
                                            .medicine
                                            .name,
                                        style: ProfileInfoText,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot
                                            .data
                                            .data
                                            .newPrescription
                                            .medicinesSuggested[index]
                                            .takeAtMorning
                                            .toString() +
                                        "-",
                                    style: NormalText,
                                  ),
                                  Text(
                                    snapshot
                                            .data
                                            .data
                                            .newPrescription
                                            .medicinesSuggested[index]
                                            .takeAtLunch
                                            .toString() +
                                        "-",
                                    style: NormalText,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      snapshot
                                          .data
                                          .data
                                          .newPrescription
                                          .medicinesSuggested[index]
                                          .takeAtDinner
                                          .toString(),
                                      style: NormalText,
                                    ),
                                  ),
                                  Text(
                                      snapshot
                                              .data
                                              .data
                                              .newPrescription
                                              .medicinesSuggested[index]
                                              .numberOfDays
                                              .toString() +
                                          " " +
                                          "Days",
                                      style: NormalText),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5.0, bottom: 4),
                                    child: IconButton(
                                      icon: Icon(FeatherIcons.trash),
                                      onPressed: () {
                                        var mId = snapshot
                                            .data
                                            .data
                                            .newPrescription
                                            .medicinesSuggested[index]
                                            .id;
                                        AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.ERROR,
                                            headerAnimationLoop: true,
                                            animType: AnimType.SCALE,
                                            title: 'Delete Medicine',
                                            desc: 'Are you sure?',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              deleteMedicine(mId);
                                            }).show();
                                      },
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
