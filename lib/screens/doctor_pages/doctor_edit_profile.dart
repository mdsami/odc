import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/doctor_profile_response_model.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart'as http;
import 'package:imgur/imgur.dart'as imgur;

import '../../screen_size_helper/sized_helper.dart';
import 'doctor_home_screen_page.dart';
class DoctorProfileEditPage extends StatefulWidget {
  @override
  _DoctorProfileEditPageState createState() => _DoctorProfileEditPageState();
}

class _DoctorProfileEditPageState extends State<DoctorProfileEditPage> {
  var _isLoading = false;
  var _character;
  File _image;
  String imagelink;
  final storage = FlutterSecureStorage();

  var _chosenValueHospital;
  var _chosenValueSpecilizations;
  var _designation;
  TextEditingController first_name = TextEditingController();
  TextEditingController last_name = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController degree = TextEditingController();

  Future<DoctorProfileInfoGetModel> updateDoctorProfile() async {

    final client = imgur.Imgur(imgur.Authentication.fromToken('e26d437630366edeaf39b8847bebcfded2c4fac0'));

    /// Upload an image from path
    _image==null? Text(" ")
        :await client.image
        .uploadImage(
        imagePath: _image.path,
        title: 'profile pic',
        description: 'A description')
        .then((image) {
      setState(() {
        imagelink=image.link;
      });
    });

    String doctorid = await storage.read(key: "doctor_id");
    String token = await storage.read(key: "key");
    final doctor_profile_update_url =
        "https://remote-doctor-api.herokuapp.com/api/v1/doctor/profile/$doctorid";


    var response =
    await http.patch(doctor_profile_update_url,
        body: jsonEncode({
          "user": {
            "firstName": first_name.text,
            "lastName": last_name.text,
            "gender": _character,
            "contact": contact.text,
            "avatarPath": imagelink,
          },
          "degree":degree.text,
          "hospitalid": _chosenValueHospital,
          "specializeid": _chosenValueSpecilizations,
          "designationid": _designation,
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
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => DoctorHomeScreen()));
        Fluttertoast.showToast(msg: "Profile Update Successfull",fontSize: 20,backgroundColor:BasedBlueColor,textColor: Colors.white);
      }
      else{
        Fluttertoast.showToast(msg: "Profile Update Not Successful All Info Requierd",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white);
      }
    }
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

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
              child:  Wrap(
                children: <Widget>[
                  ListTile(
                      leading:  Icon(Icons.photo_library),
                      title:  Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading:  Icon(Icons.photo_camera),
                    title:  Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  void initState() {
    super.initState();
        _isLoading = true;
    Provider.of<DoctorInfo>(context, listen: false)
        .getDropDownInfo()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    var snap=Provider.of<DoctorInfo>(context,listen: false).doctorProfile;
    first_name.text=snap.data.doctor.firstName;
    last_name.text=snap.data.doctor.lastName;
    snap.data.degree==null?degree.text=degree.text:degree.text=snap.data.degree;
    snap.data.doctor.contact==null?contact.text=contact.text:contact.text=snap.data.doctor.contact;
    setState(() {
    snap.data.designation==null?_designation=_designation:_designation=snap.data.designation.id;
    snap.data.specialization==null?_chosenValueSpecilizations=_chosenValueSpecilizations:_chosenValueSpecilizations=snap.data.specialization.id;
    snap.data.doctor.avatarPath==null?imagelink:imagelink=snap.data.doctor.avatarPath;
    snap.data.doctor.gender==null?_character=_character:_character=snap.data.doctor.gender;
    });
         
    });
  }
  

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var dropdown=Provider.of<DoctorInfo>(context).dropDownInfo; 
  
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body:
      _isLoading?Container(color:Colors.white,child:Center(child: Image.asset("images/watting.gif")),):
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: displayHeight(context)*0.06,),
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
                    child: Image.file(
                      _image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.cover,
                    ),
                  )
                      : ClipOval(
                    child: imagelink==null?  Container(
                     decoration: BoxDecoration(
                         color: Colors.grey[200],
                         borderRadius: BorderRadius.circular(50)),
                     width: 110,
                     height: 110,
                     child: Icon(
                     Icons.camera_alt,
                       color: Colors.grey[800],
                    ),
                   ): ClipOval(
                      child: Image.network(
                        imagelink,
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                      ),
                   ),
                  )
                      
               
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
                      value:"Male",
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          _character = value;
                        });
                      },
                    ),
                    Text('Male'),
                    Radio(
                      value:"Female",
                      groupValue: _character,
                      onChanged: (value) {
                        setState(() {
                          _character = value;
                        });
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
                controller: contact,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide(),
                  ),
                ),
                keyboardType: TextInputType.phone,
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, right: 20, left: 20, bottom: 10),
              child: TextFormField(
                controller: degree,
                decoration: InputDecoration(
                  labelText: "Degrees",
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
             padding: const EdgeInsets.only(left: 30,right: 30),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Select Your Designation"),
                value: _designation,
                onChanged: (value){
                  setState(() {
                        _designation = value;
                      });
                },
                items:[
                for(var designations in dropdown.data.designations)
                DropdownMenuItem(
                child: Text(designations.designation),
                value: designations.id,)
              ], ),
            ),
             Padding(
             padding: const EdgeInsets.only(left: 30,right: 30),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Select Your Specilaztion"),
                value: _chosenValueSpecilizations,
                onChanged: (value){
                  setState(() {
                      _chosenValueSpecilizations = value;
                    });
                },
                items:[
                for(var specializations in dropdown.data.specializations)
                DropdownMenuItem(
                child: Text(specializations.name),
                value: specializations.id,)
              ], ),
            ),
            Padding(
             padding: const EdgeInsets.only(left: 30,right: 30),
              child: DropdownButton(
                isExpanded: true,
                hint: Text("Select Your Hospital"),
               value: _chosenValueHospital,
                onChanged: (value){
                  setState(() {
                      _chosenValueHospital = value;
                    });
                },
                items:[
                for(var hospitals in dropdown.data.hospitals)
                DropdownMenuItem(
                child: Text(hospitals.name),
                value: hospitals.id,)
              ], ),
            ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
                          child: Container(
                            height: displayHeight(context)*.075,
                            width: displayWidth(context)*.49,
                            child: ProgressButton(
                   defaultWidget:
                    const Text('Update Profile',  style: TextStyle(color: Colors.white, fontSize: 20,fontFamily: 'Poppins'),),
                progressWidget: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                    borderRadius: 8,
                color:BasedBlueColor,
                type: ProgressButtonType.Flat,
                onPressed: () async {
                  await Future.delayed(
                      const Duration(seconds: 10), () =>0);
                   if(_chosenValueSpecilizations==null){
                    Fluttertoast.showToast(msg: "Select Specilization ",fontSize: 20,backgroundColor: Colors.red,textColor: Colors.white,gravity: ToastGravity.TOP,);
                  }
                  else {
                    updateDoctorProfile();
                  }
                },
              ),
                          ),
                        ),
          ],
        ),
      ),
    );
  }
}
