
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/all_doctor_info_get_model.dart';
import 'package:online_doctor_chember/models/patient_profile_get_respnse_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/patient_pages/patient_login_page.dart';
import '../screens/patient_pages/patient_login_page.dart';
import '../screens/patient_pages/patient_login_page.dart';
import '../screens/patient_pages/patient_login_page.dart';

class PatientInfo with ChangeNotifier {
  final storage = FlutterSecureStorage();
  

  GetDoctorInfoModel _getDoctorInfoModel=null;
  PatientProfileResponseModel _patientProfileResponseModel= null;

  PatientProfileResponseModel get getPatientInfo{
    if(_patientProfileResponseModel != null){
      return _patientProfileResponseModel;
    }
  }

  GetDoctorInfoModel get getDoctorIngo{
    if (_getDoctorInfoModel !=null){
      return _getDoctorInfoModel;
    }
  }

 
  Future<void> DoctorList(BuildContext context) async {
    var token = await storage.read(key: "usertoken");
    final doctor_list_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/doctor/list";
    final response = await http.get(doctor_list_url,headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $token",
    });
    var decode =jsonDecode(response.body);
    var status=decode["status"];
    var message=decode["message"];
    //var context;
    if (status == "ok") {
      print(status);
      GetDoctorInfoModel doctorInfoModel=GetDoctorInfoModel.fromJson(jsonDecode(response.body));
      _getDoctorInfoModel=doctorInfoModel;
      
      notifyListeners();
    } else {
      
      print(status);
      AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            headerAnimationLoop: true,
                            animType: AnimType.SCALE,
                            title: 'Log Out',
                            desc:message,
                            btnCancelOnPress: () {},
                            btnOkColor: BasedBlueColor,
                            btnOkOnPress: ()async { 
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.remove("jwtp");
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      PatientLoginPage()), (Route<dynamic> route) => false);}).show();
    }
  }
  Future<void> GetPatinetProfileInfo(BuildContext context) async {
    String userId = await storage.read(key: "userid");
    String usertoken = await storage.read(key: "usertoken");

    var patient_profile_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/patient/profile/$userId";

    var response = await http.get(patient_profile_url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $usertoken",
    });
    var decode =jsonDecode(response.body);
    var status=decode["status"];
    var message=decode["message"];
    if(status =="ok"){
      print(status);
      PatientProfileResponseModel patientProfileResponseModel =
      PatientProfileResponseModel.fromJson(jsonDecode(response.body));
      _patientProfileResponseModel=patientProfileResponseModel;
      notifyListeners();
     }
     else{
 AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            headerAnimationLoop: true,
                            animType: AnimType.SCALE,
                            title: 'Log Out',
                            desc:message,
                            btnCancelOnPress: () {},
                            btnOkColor: BasedBlueColor,
                            btnOkOnPress: ()async { 
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.remove("jwtp");
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      PatientLoginPage()), (Route<dynamic> route) => false);}).show();
      
           }
          }
      
        Future<String> updatePatientProfile(Object patientObject) async {
          // json encode that doctorObject here
          // patch to the api
          // if success return "success"
          // else return "failed"
        }
      }
    
    