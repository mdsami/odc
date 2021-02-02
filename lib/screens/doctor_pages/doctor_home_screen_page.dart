
import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screens/doctor_pages/create_schedule_page.dart';
import 'package:online_doctor_chember/screens/doctor_pages/visited_patient_list.dart';

import 'doctor_home_page.dart';
import 'doctor_profile_page.dart';

class DoctorHomeScreen extends StatefulWidget {
  @override
  _DoctorHomeScreenState createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
  int _selectedIndex = 0;
  static  List<Widget>_children= <Widget>[
    DoctorHomePage(),
    DoctorProfilePage(),
    VisitedPatientListPage(),
    SheduleCreate(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:BottomNavigationBar(
        unselectedItemColor:BasedBlueColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            title: Text('Home',style: TextStyle(fontFamily: 'Poppins'),),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.user),
            title: Text('Profile',style: TextStyle(fontFamily: 'Poppins',),),
          ),
          BottomNavigationBarItem(
            icon:Icon(FeatherIcons.checkSquare),
            title: Text('Completed',style: TextStyle(fontFamily: 'Poppins',),),
          ),
          BottomNavigationBarItem(
            icon:Icon(FeatherIcons.calendar),
            title: Text('Schedule',style: TextStyle(fontFamily: 'Poppins',),),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: BasedBlueColor,
        onTap: _onItemTapped,

      ),


      body:_children[_selectedIndex],
    );
  }
}
