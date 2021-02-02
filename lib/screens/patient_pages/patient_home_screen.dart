import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_appiontment_list_page.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_page.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_profile_page.dart';
class PatientHomeScreenPage extends StatefulWidget {
  @override
  _PatientHomeScreenPageState createState() => _PatientHomeScreenPageState();
}

class _PatientHomeScreenPageState extends State<PatientHomeScreenPage> {
  int _selectedIndex = 0;
  static  List<Widget>_children= <Widget>[
    PatientHomePage(),
    PatientAppiontmentListPage(),
    PatientProfilePage(),
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
        unselectedItemColor: Colors.black,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.home),
            title: Text('Home',style: TextStyle(fontFamily: 'Poppins', ),),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            title: Text('Appointment',style: TextStyle(fontFamily: 'Poppins',),),
          ),
          BottomNavigationBarItem(
            icon: Icon(FeatherIcons.user),
            title: Text('Profile',style: TextStyle(fontFamily: 'Poppins',),),
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(FeatherIcons.logOut),
          //   title: Text('',style: TextStyle(fontFamily: 'Poppins',),),
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: BasedBlueColor,
        onTap: _onItemTapped,

      ),


      body:_children[_selectedIndex],
    );
  }
}
