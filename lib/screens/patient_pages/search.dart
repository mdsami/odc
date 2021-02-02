import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/screens/patient_pages/single_doctor_info_and_appiontment_taken.dart';
import 'package:provider/provider.dart';

class SearchDoctor extends SearchDelegate<String>{
  final name=[
    "dd",
    "dff",
    "ww"
  ];
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
    var snapshot=Provider.of<PatientInfo>(context).getDoctorIngo ;

   final names=List<String>();
    snapshot.data.forEach((element) {
     names.add(element.user.firstName.toLowerCase() + " "+ element.user.lastName.toLowerCase());
   });
   

    final suggestionList =names.where((p) => p.endsWith(query)||p.startsWith(query)).toList();
    return ListView.builder(itemBuilder: (context, index) => ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                    DoctorInfoAndAppiontmentTaken(
                      snapshot.data[index]," "
                    )));
      },
      leading: Icon(FeatherIcons.userCheck),
      title: RichText(text:TextSpan(text: suggestionList[index].substring(0,query.length),
      style: TextStyle(color:Colors.green ),
      children: [
        TextSpan(text: suggestionList[index].substring(query.length),
      style: TextStyle(color: BasedBlueColor),)
      ]
      ))
    
    ),
      itemCount: suggestionList.length,
    );
  }
  }