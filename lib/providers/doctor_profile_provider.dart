import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/doctor_profile_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:online_doctor_chember/models/dropdown_info_get_model.dart';
import 'package:online_doctor_chember/models/visited_patient_list_model.dart';
import 'package:imgur/imgur.dart'as imgur;
import 'package:online_doctor_chember/screens/doctor_pages/doctor_login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DoctorInfo with ChangeNotifier{
  final storage = FlutterSecureStorage();
  DoctorProfileInfoGetModel _doctorProfile =null;
  DropDownModel _downModel =null;
  VisitedPatientCompelteListModel _compelteListModel= null;

  VisitedPatientCompelteListModel get compeletList{
    if(_compelteListModel!=null){
      return _compelteListModel;
    }
  }



  DropDownModel get dropDownInfo{
    if(_downModel != null){
      return _downModel;
    }
  }

  DoctorProfileInfoGetModel get doctorProfile{
    if(_doctorProfile !=null){
      return _doctorProfile;
    }
  }

  Future<void>GetCompeleteList(BuildContext context)async{
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");
    var url="https://remote-doctor-api.herokuapp.com/api/v1/appoinment/complete/$doctorid";
    var respone=await http.get(url,headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var decode  =jsonDecode(respone.body);
    var status= decode["status"];
    var message=decode["message"];
    if(status=="ok"){
    VisitedPatientCompelteListModel visitedPatientCompelteListModel=VisitedPatientCompelteListModel.fromJson(jsonDecode(respone.body));
    _compelteListModel=visitedPatientCompelteListModel;
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
                                        await prefs.remove("jwtd"); 
                                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      DoctorLoginPage()), (Route<dynamic> route) => false);
                            }).show();
    }
  }

  Future <void> getDropDownInfo()async{
    String token = await storage.read(key: "key");
    String url = 'https://remote-doctor-api.herokuapp.com/api/v1/doctor/dropdowninfo';
    final response =
    await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $token",
    }).then((value) { DropDownModel dropDownModel =
    DropDownModel.fromJson(jsonDecode(value.body));
    _downModel =dropDownModel;
    notifyListeners();
    });

  }
  var imageLink;
  Future<String> updateDoctorProfile ( first_name, last_name,  contact,designations,_character,_image,_chosenValueHospital,_chosenValueSpecilizations) async {
    // json encode that doctorObject here
    // patch to the api
    // if success return "success"
    // else return "failed"
    final client = imgur.Imgur(imgur.Authentication.fromToken('e26d437630366edeaf39b8847bebcfded2c4fac0'));

    /// Upload an image from path
    await client.image
        .uploadImage(
        imagePath: _image.path,
        title: 'profile pic',
        description: 'A description')
        .then((image) {
          imageLink=image.link;
    });
    String doctorid = await storage.read(key: "doctor_id");
    String token = await storage.read(key: "key");
    final doctor_profile_update_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/doctor/profile/$doctorid";

    var response = await http.patch(doctor_profile_update_url,
        body: jsonEncode({
          "user": {
            "firstName": first_name.text,
            "lastName": last_name.text,
            "gender": _character,
            "contact": contact.text,
            "avatarPath":imageLink ,
          },
          "designation":designations.text,
          "hospitalid": _chosenValueHospital,
          "specializeid": _chosenValueSpecilizations,
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": " Bearer $token",
        });
    if (response.statusCode == 200) {
      DoctorProfileInfoGetModel doctorProfileInfoGetModel=DoctorProfileInfoGetModel.fromJson(jsonDecode(response.body));

      var status=doctorProfileInfoGetModel.status;
      if (status=="ok"){
         // Navigator.push(context, MaterialPageRoute(
         //     builder: (context) => DoctorHomeScreen()));
        Fluttertoast.showToast(msg: "Profile Update Successfull",fontSize: 20,backgroundColor: Colors.green,textColor: Colors.white);
      }
      else{
        Fluttertoast.showToast(msg: "Profile Update Not Successful",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
      }
    }
  }
  Future<void> GetDoctorProfile(BuildContext context) async {
    String token = await storage.read(key: "key");
    String doctorid = await storage.read(key: "doctor_id");

    final doctor_profile_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/doctor/profile/$doctorid";

    var response =await http.get(doctor_profile_url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    var decode=jsonDecode(response.body);
    var status =decode["status"];
    var message=decode["message"];
    if(status=="ok"){
    DoctorProfileInfoGetModel doctorProfileInfoGetModel=DoctorProfileInfoGetModel.fromJson(jsonDecode(response.body));
      _doctorProfile=doctorProfileInfoGetModel;
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
                                        await prefs.remove("jwtd"); 
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      DoctorLoginPage()), (Route<dynamic> route) => false);}).show();
    }
  }

}