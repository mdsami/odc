import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/doctor_profile_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/doctor_pages/searchpatient.dart';
import 'package:online_doctor_chember/screens/prescription/precription_viwe_from_doctor_side.dart';
import 'package:provider/provider.dart';

class VisitedPatientListPage extends StatefulWidget {
  @override
  _VisitedPatientListPageState createState() => _VisitedPatientListPageState();
}

class _VisitedPatientListPageState extends State<VisitedPatientListPage> {
  var _isLoading = false;
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<DoctorInfo>(context, listen: false)
        .GetCompeleteList(context)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var visitedPatientData = Provider.of<DoctorInfo>(context).compeletList;
    var reversedlist;
    visitedPatientData == null
        ? Text("")
        : reversedlist = visitedPatientData.data.reversed.toList();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: BasedBlueColor,
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              color: BasedBlueColor,
              onPressed: () {
                showSearch(context: context, delegate: SearchPatient());
              },
              padding: EdgeInsets.only(right: 30),
            )
          ],
          title: Text(
            "Completed List",
          )),
      body: _isLoading
          ? Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fetching Data",
                    style: TextStyle(fontSize: 20, color: BasedBlueColor),
                  ),
                  Image.asset("images/watting.gif")
                ],
              ))
          :visitedPatientData.data.length==0?Center(child: Text("No appointment is completed",style: NormalText,)) :Column(
              children: [
                Container(
                  height: displayHeight(context) * .77,
                  width: displayWidth(context) * 1,
                  color: Colors.white,
                  child: ListView.builder(
                      itemCount: reversedlist.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  reversedlist[index].patient.avatarPath == null
                                      ? Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 45,
                                            child: ClipOval(
                                              child: Image.asset(
                                                'images/patient.png',
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 45,
                                            child: ClipOval(
                                              child: Image.network(
                                                reversedlist[index]
                                                    .patient
                                                    .avatarPath,
                                                fit: BoxFit.cover,
                                                width: 100,
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          reversedlist[index]
                                                  .patient
                                                  .firstName +
                                              " " +
                                              reversedlist[index]
                                                  .patient
                                                  .lastName,
                                          style: AppionCardTextBold,
                                        ),
                                        Text(
                                          reversedlist[index].date,
                                          style: NormalText,
                                        ),
                                        Text(
                                          reversedlist[index].dayOfWeek,
                                          style: NormalText,
                                        ),
                                        Text(
                                          reversedlist[index].time,
                                          style: NormalText,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllPrecriptionView(
                                                      reversedlist[index])));
                                    },
                                    child: Text(
                                      "Check prescription",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.deepOrange,
                                          fontFamily: "Poppins"),
                                    ),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    color: Color(
                                        0xfffbe9e7) //Colors.deepOrange[100],
                                    ),
                              ),
                            ],
                          ),
                          elevation: 4,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
