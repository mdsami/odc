import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';

import 'days.dart';


class SheduleCreate extends StatefulWidget {
  @override
  _SheduleCreateState createState() => _SheduleCreateState();
}


class _SheduleCreateState extends State<SheduleCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Consultation time",),
        backgroundColor: BasedBlueColor,
      ),
      body: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: displayHeight(context)*.05,),
          Padding(
            padding: const EdgeInsets.only(left:15.0),
            child: Text(
              "Choose preferable time for the week",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600

              ),
            ),
          ),
          SizedBox(height: displayHeight(context)*.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Sunday")));
                },
                  child: Text("Sunday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
                ),
              ),
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Monday")));
                },
                  child: Text("Monday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),),
              ),
            ],
          ),
          SizedBox(height: displayHeight(context)*.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Tuesday")));
                },
                  child: Text("Tuesday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
                ),
              ),
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Wednesday")));
                },
                  child: Text("Wednesday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 40,right: 40,top: 20,bottom: 20),),
              ),
            ],
          ),
          SizedBox(height: displayHeight(context)*.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Thursday")));
                },
                  child: Text("Thursday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 45,right: 45,top: 20,bottom: 20),
                ),
              ),
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Friday")));
                  },
                  child: Text("Friday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),),
              ),
            ],
          ),
          SizedBox(height: displayHeight(context)*.03,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: 60,
                width: 165,
                child: RaisedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TimeSlot("Saturday")));
                },
                  child: Text("Saturday",style: DaysName,),
                  color: BasedBlueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  padding: EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
