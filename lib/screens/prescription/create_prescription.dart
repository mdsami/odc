import 'dart:convert';
import 'dart:core';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'as http;
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/doctor_profile_response_model.dart';
import 'package:online_doctor_chember/models/prescription_response_model.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/prescription/create_medichine.dart';
import 'package:provider/provider.dart';

class Info{
  String patientID;
  String appiontmentID;
  String prescriptionId;

  Info({this.patientID,this.prescriptionId,this.appiontmentID});
}
class PerscriptionCreate extends StatefulWidget {
  final Appoinment _appoinment;
  PerscriptionCreate(this._appoinment);

  @override
  _PerscriptionCreateState createState() => _PerscriptionCreateState();
}

class _PerscriptionCreateState extends State<PerscriptionCreate> {

  final storage = FlutterSecureStorage();
  TextEditingController _feelslike =TextEditingController();
  TextEditingController _testname =TextEditingController();
  var  prescriptionId;
  var statusoftest;
  Future<PrescriptionResponseModel> CreatePrescription()async{
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var ff=widget._appoinment.patient.id;

    var createPrescriptionUrl="https://remote-doctor-api.herokuapp.com/api/v1/prescription/create/$doctorid";

    var response = await http.post(createPrescriptionUrl,body: jsonEncode({
      "appointment":widget._appoinment.id,
      "patient":widget._appoinment.patient.id,
    }),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    PrescriptionResponseModel  prescriptionResponseModel=PrescriptionResponseModel.fromJson(jsonDecode(response.body));
    setState(() {
      prescriptionId=prescriptionResponseModel.data.id;
    });
  }
  Future CreateSymthom()async{
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var createSymthomUrl="https://remote-doctor-api.herokuapp.com/api/v1/symptom/create/$doctorid/$prescriptionId";
    var response = await http.post(createSymthomUrl,body: jsonEncode({
      "feelsLike": _feelslike.text,
      "bodyPart": "a",
    }
    ),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    // var decode =jsonDecode(response.body);
    // var status=decode["status"];
    //
    // //return symthomStatus=status;

  }
  Future CreateTests()async{
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var createSymthomUrl="https://remote-doctor-api.herokuapp.com/api/v1/test/create/$doctorid/$prescriptionId";
    var response = await http.post(createSymthomUrl,body: jsonEncode({
      "testName": _testname.text,
    }
    ),headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print(response.body);
    var decode =jsonDecode(response.body);
      statusoftest=decode["status"];


  }
  @override
  Widget build(BuildContext context) {
    var patientId=widget._appoinment.patient.id;
    var appiontmentId=widget._appoinment.id;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        backgroundColor: BasedBlueColor,
        title: Text('Prescription',),
      ),
      body: (
          Container(
            height: displayHeight(context)*1,
            color: Colors.white,
            child: Column(
              children: [
                FutureProvider(
                  create: (_)async=>CreatePrescription(),
                  lazy: false,

                  child:  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        prescriptionId==null?FlatButton(onPressed: (){CreatePrescription();}, child: Center(child: Text(""))):
                       Text("")
                      ],
                    ),
                  ),
                ),
                Column(children: [
                 Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0,right: 20,top: 5),
                        child: TextField(
                          controller: _feelslike,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration(
                            labelText: "Problems",
                            hintText: "Pain",
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context) * .01,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:20.0,right: 20,top: 5),
                            child: TextField(
                              controller: _testname,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: InputDecoration(

                                labelText: "Test Name",
                                hintText: "blood test",
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: displayHeight(context) * .01,
                          ),


                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * .05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:20.0),
                            child: RaisedButton(
                              padding:EdgeInsets.only(left: 30,right: 30,top: 15,bottom: 15),
                              onPressed: (){
                                CreateSymthom();
                                CreateTests();
                                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>CreateMedicen(prescriptionId,patientId,appiontmentId)));
                              },child: Text("Next"),color: BasedBlueColor,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),textColor: Colors.white,),),
                        ],
                      ),

                    ],
                  )


                ],)
              ],
            ),
          )
      ),
    );
  }
}

