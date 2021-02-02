import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/providers/prescription_view.dart';
import 'package:online_doctor_chember/screens/doctor_pages/doctor_home_screen_page.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_screen.dart';
import 'package:online_doctor_chember/sliding_pages/account_devied_page.dart';
import 'package:online_doctor_chember/sliding_pages/sliding_page.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:splashscreen/splashscreen.dart';

bool secondtime;
bool messagep;
bool messaged;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var jwtp = await prefs.getString("jwtp");
  var jwtd = await prefs.getString("jwtd");
  secondtime = await prefs.getBool("time");
  if (jwtp == null && jwtd != null) {
    var url = "https://remote-doctor-api.herokuapp.com/api/v1/verify/token";
    var respose = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": " Bearer $jwtd",
    });
    print(respose.body);
    var decode = jsonDecode(respose.body);
    messaged = decode["message"];
  } else {
    var url = "https://remote-doctor-api.herokuapp.com/api/v1/verify/token";
    var respose = await http.get(url, headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": "Bearer $jwtp",
    });
     print(respose.body);
    var decode = jsonDecode(respose.body);
    messagep = decode["message"];
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => DoctorInfo()),
            ChangeNotifierProvider(create: (context) => PatientInfo()),
            ChangeNotifierProvider(create: (context) => Prescription()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: BasedBlueColor,
            ),
            home: SplashScreen(
                seconds: 4,
                navigateAfterSeconds: secondtime == null
                    ? SlidePages()
                    : messagep == true
                        ? PatientHomeScreenPage()
                        : messaged == true
                            ? DoctorHomeScreen()
                            : AccountType(),
                image: Image.asset('images/splash_icon.jpeg'),
                title: Text(
                  'Online Doctor Chamber',textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
                backgroundColor: BasedBlueColor,
                styleTextUnderTheLoader: new TextStyle(),
                photoSize: 120.0,
                loaderColor: Colors.white),
          )),
    );
  }
}
