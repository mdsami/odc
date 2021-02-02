import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:online_doctor_chember/models/prescription_view_model.dart';

class Prescription with ChangeNotifier{
  final storage = FlutterSecureStorage();
PrescriptionViewModel _prescriptionViewModel=null;

PrescriptionViewModel get prescription{
  if(_prescriptionViewModel!= null){
    return _prescriptionViewModel;
  }

}

Future<void> GetPrescription(String prescriptionID) async {
  var token = await storage.read(key: "usertoken");
  var url =
      "https://remote-doctor-api.herokuapp.com/api/v1/prescription/$prescriptionID";
  var response = await http.get(url,  headers: {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": " Bearer $token",
  });
  PrescriptionViewModel prescriptionViewModel =
  PrescriptionViewModel.fromJson(jsonDecode(response.body));
  _prescriptionViewModel =prescriptionViewModel;
  notifyListeners();
}
  Future<void> AllPrecriptionView(String prescriptionID) async {
    var token = await storage.read(key: "key");
    var url =
        "https://remote-doctor-api.herokuapp.com/api/v1/prescription/$prescriptionID";
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $token",
    });
    PrescriptionViewModel prescriptionViewModel =
    PrescriptionViewModel.fromJson(jsonDecode(response.body));
    _prescriptionViewModel =prescriptionViewModel;
    notifyListeners();
  }
}