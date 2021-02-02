import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_edit_profile.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_login_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constant.dart';

class PatientProfilePage extends StatefulWidget {
  @override
  _PatientProfilePageState createState() => _PatientProfilePageState();
}

class _PatientProfilePageState extends State<PatientProfilePage> {
  var _isLoading = false;
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<PatientInfo>(context, listen: false)
        .GetPatinetProfileInfo(context)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var snapshot=Provider.of<PatientInfo>(context).getPatientInfo;
    return Scaffold(
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
          :Column(
        children: [
          SizedBox(height: displayHeight(context)*0.05,),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  icon: Icon(
                    FeatherIcons.edit,
                    color: Colors.blueAccent,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PatientEditProfilePage()),
                    );
                  }),
              SizedBox(width:15 ,),
              Column(
                children: [
                  IconButton(
                      icon: Icon(
                        FeatherIcons.logOut,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.QUESTION,
                            headerAnimationLoop: true,
                            animType: AnimType.SCALE,
                            title: 'Warning',
                            desc:
                            'Do you want to Log Out?',
                            btnCancelOnPress: () {},
                            btnOkColor: BasedBlueColor,
                            btnOkOnPress: ()async { 
                               SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.remove("jwtp");
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                      PatientLoginPage()), (Route<dynamic> route) => false);}).show();

                      }),
// Text("Log Out"),
                ],
              ),
            ],
          ),
          snapshot.data.patient.avatarPath==null
              ? Text(" ")
              : CircleAvatar(
            child: ClipOval(
                child: Image.network(
                  snapshot.data.patient.avatarPath,
                  height: displayHeight(context) * 0.4,
                  width: displayWidth(context) * 0.4,
                  fit: BoxFit.cover,
                )),
            radius: 70,
            backgroundColor: Colors.white,
          ),
          SizedBox(height: displayHeight(context)*0.05,),
          Row(
            children: [
              Container(
                width: displayWidth(context)*0.5,
                height: displayHeight(context)*0.3,
                
                child: Padding(
                  padding: const EdgeInsets.only(left:70.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name:",style: ProfileInfoText,),
                      Text("Gender:",style: ProfileInfoText,),
                      Text("Conatct:",style: ProfileInfoText,),
                      Text("Address:",style: ProfileInfoText,),
                      Text("NID:",style: ProfileInfoText,),
                    ],
                  ),
                ),
              ),
              Container(
                width: displayWidth(context)*0.5,
                height: displayHeight(context)*0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: displayWidth(context)*0.5, child: Text(snapshot.data.patient.firstName+" "+snapshot.data.patient.lastName,style: NormalText,maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: false)),
                    snapshot.data.patient.gender==null?Text(""):Text(snapshot.data.patient.gender,style: NormalText,),
                    snapshot.data.patient.contact==null?Text(""): Text(snapshot.data.patient.contact,style: NormalText,),
                    snapshot.data.patient.address==null?Text(""): SizedBox(width: displayWidth(context)*0.5,
                    child: Text(snapshot.data.patient.address,style: NormalText,maxLines: 1,overflow: TextOverflow.ellipsis,softWrap: false,)),
                    snapshot.data.nationalId==null?Text(""): Text(snapshot.data.nationalId,style: NormalText,),
                  ],
                ),
              )
            ],
          ),

        ],
      ),
    );
  }
}
