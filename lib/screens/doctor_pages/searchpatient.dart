import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:provider/provider.dart';


class SearchPatient extends SearchDelegate<String>{
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(icon: Icon(Icons.clear), onPressed: () {
      query = '';
    })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();

  }

  @override
  Widget buildSuggestions(BuildContext context) {
  
     var visitedPatientData=Provider.of<DoctorInfo>(context).compeletList;
     final listname=List<String>();
     visitedPatientData.data.forEach((element) {
       listname.add(element.patient.firstName+" "+element.patient.lastName);
      });
    final suggestionList =listname.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context,index) => ListTile(
      onTap: () {
        showResults(context);
      },
      leading: Icon(FeatherIcons.userCheck),
      title: RichText(
        text: TextSpan(
             text: suggestionList[index].substring(0,query.length),
            style: TextStyle(
                color: BasedBlueColor, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey))
            ]),
      ),
    ),
      itemCount: suggestionList.length,
    );
  }
  }