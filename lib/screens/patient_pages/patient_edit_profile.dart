import 'dart:convert';
import 'dart:io';

import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:http/http.dart' as http;
import 'package:imgur/imgur.dart' as imgur;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_screen.dart';
import 'package:provider/provider.dart';

class PatientEditProfilePage extends StatefulWidget {
  @override
  _PatientEditProfilePageState createState() => _PatientEditProfilePageState();
}

class _PatientEditProfilePageState extends State<PatientEditProfilePage> {
  String _character;
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController nationalId = TextEditingController();
  String _bloodgroup;
  File _image;
  String imagelink;
  final storage = FlutterSecureStorage();
  FocusNode focusNode = new FocusNode();

  Future updateUserProfile() async {
    final client = imgur.Imgur(imgur.Authentication.fromToken(
        'e26d437630366edeaf39b8847bebcfded2c4fac0'));

    /// Upload an image from path
    _image == null
        ? Text(" ")
        : await client.image
            .uploadImage(
                imagePath: _image.path,
                title: 'profile pic',
                description: 'A description')
            .then((image) {
            setState(() {
              imagelink = image.link;
            });
          });
    String userId = await storage.read(key: "userid");
    String usertoken = await storage.read(key: "usertoken");
    final doctorProfileUpdateUrl =
        "https://remote-doctor-api.herokuapp.com/api/v1/patient/profile/$userId";

    Object patientObject = {
      "user": {
        "firstName": first_name.text,
        "lastName": last_name.text,
        "gender": _character,
        "address": address.text,
        "avatarPath": imagelink,
      },
      "patient": {
        "bloodGroup": _bloodgroup,
        "nationalId": nationalId.text,
      }
    };

    var response = await http.patch(doctorProfileUpdateUrl,
        body: jsonEncode({
          "user": {
            "firstName": first_name.text,
            "lastName": last_name.text,
            "gender": _character,
            "address": address.text,
            "avatarPath": imagelink,
          },
          "patient": {
            "bloodGroup": _bloodgroup,
            "nationalId": nationalId.text,
          }
        }),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": " Bearer $usertoken",
        });
    if (response.statusCode == 200) {
      var updateResponse = jsonDecode(response.body);
      var status = updateResponse["status"];
      print(response.body);
      if (status == "ok") {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => PatientHomeScreenPage()));
        Fluttertoast.showToast(
            msg: "Profile Update Successfull",
            fontSize: 20,
            backgroundColor: BasedBlueColor,
            textColor: Colors.white);
      } else {
        Fluttertoast.showToast(
            msg: "Profile Update Not Successful All Info Requierd",
            fontSize: 20,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: Icon(Icons.photo_library),
                      title: Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: Icon(Icons.photo_camera),
                    title: Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var snapshot =
          Provider.of<PatientInfo>(context, listen: false).getPatientInfo;
      first_name.text = snapshot.data.patient.firstName;
      last_name.text = snapshot.data.patient.lastName;
      address.text = snapshot.data.patient.address;
      nationalId.text = snapshot.data.nationalId;
      setState(() {
         snapshot.data.patient.gender == null
        ? _character = _character
        : _character = snapshot.data.patient.gender;
        snapshot.data.bloodGroup == null
        ? _bloodgroup = _bloodgroup
        : _bloodgroup = snapshot.data.bloodGroup;
    snapshot.data.patient.avatarPath == null
        ? imagelink
        : imagelink = snapshot.data.patient.avatarPath;
      });
         
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: displayHeight(context) * 0.05,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    _showPicker(context);
                  },
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: _image != null
                        ? ClipOval(
                            // borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 110,
                              height: 110,
                              fit: BoxFit.cover,
                            ),
                          )
                        : imagelink == null
                            ? Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(50)),
                                width: 110,
                                height: 110,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.grey[800],
                                ),
                              )
                            : ClipOval(
                                                          child: Image.network(
                                  imagelink,
                                  width: 110,
                                  height: 110,
                                  fit: BoxFit.cover,
                                  
                                ),
                            ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 20, left: 20, bottom: 10),
                child: TextFormField(
                  controller: first_name,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 20, left: 20, bottom: 10),
                child: TextFormField(
                  controller: last_name,
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 20, left: 20, bottom: 10),
                child: TextFormField(
                  controller: address,
                  decoration: InputDecoration(
                    labelText: "Address",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "Gender:",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Radio(
                        value: "Male",
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                          print(value);
                        },
                      ),
                      Text('Male'),
                      Radio(
                        value: "Female",
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                          });
                           print(value);
                        },
                      ),
                      Text('Female'),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 10.0, right: 20, left: 20, bottom: 10),
                child: TextFormField(
                  controller: nationalId,
                  decoration: InputDecoration(
                    labelText: "National ID Number(NID)",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child:
                        Text("Select your blood group:", style: Appion15font),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButton(
                        value: _bloodgroup,
                        items: [
                          DropdownMenuItem(
                            child: Text("A+"),
                            value: "A+",
                          ),
                          DropdownMenuItem(
                            child: Text("B+"),
                            value: "B+",
                          ),
                          DropdownMenuItem(child: Text("A-"), value: "A-"),
                          DropdownMenuItem(child: Text("B-"), value: "B-"),
                          DropdownMenuItem(child: Text("O+"), value: "O+"),
                          DropdownMenuItem(child: Text("O-"), value: "O-"),
                          DropdownMenuItem(child: Text("AB+"), value: "AB+"),
                          DropdownMenuItem(child: Text("AB-"), value: "AB-"),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _bloodgroup = value;
                          });
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: displayHeight(context) * 0.02,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
                child: Container(
                  height: displayHeight(context) * .075,
                  width: displayWidth(context) * .49,
                  child: ProgressButton(
                    defaultWidget: const Text(
                      'Update Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    ),
                    progressWidget: const CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white)),
                    borderRadius: 8,
                    color: BasedBlueColor,
                    type: ProgressButtonType.Flat,
                    onPressed: () async {
                      updateUserProfile();
                      await Future.delayed(
                          const Duration(seconds: 10), () => 0);
                      
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
