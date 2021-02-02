import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/providers/patient_service_provider.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:online_doctor_chember/screens/patient_pages/patient_home_screen.dart';
import 'package:online_doctor_chember/screens/prescription/prescripton_view_page.dart';
import 'package:online_doctor_chember/video_call/indexs.dart';
import 'package:provider/provider.dart';

class PatientAppiontmentListPage extends StatefulWidget {
  @override
  _PatientAppiontmentListPageState createState() =>
      _PatientAppiontmentListPageState();
}

class _PatientAppiontmentListPageState extends State<PatientAppiontmentListPage> {
  var _isLoading = false;
  String title;
  String helper;
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
  }
  @override
  Widget build(BuildContext context) {
     MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var snapshot = Provider.of<PatientInfo>(context).getPatientInfo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BasedBlueColor,
        automaticallyImplyLeading: false,
        title:  Text(
            'Appointments',
          ),
      ),
        body: _isLoading
            ?Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Wait a moment",style: TextStyle(fontSize: 18,color: BasedBlueColor),),
                Image.asset("images/watting.gif"),
              ],
            ))
            :Container(
      height: queryData.size.height* 1,
      width: queryData.size.width * 1,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: displayHeight(context) * .01,
          ),
          DefaultTabController(
            length: 2,
            initialIndex: 0,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                    right: 25,
                  ),
                  child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFFDCE7FF),
                      ),
                      unselectedLabelColor: Colors.black,
                      labelColor: Color(0xFF1A73E9),
                      tabs: [
                        Tab(
                          text: 'Pending',
                        ),
                        Tab(
                          text: 'Complete',
                        ),
                      ]),
                ),
                Container(
                  height: queryData.size.height*.70,
                  width: displayWidth(context) * 1,
                  color: Colors.white,
                  child: TabBarView(
                    children: [
                      Container(
                          child:snapshot.data.appoinments.length==0?Center(child: Text("No Appiontments Taken",style: NormalText,)): ListView.builder(
                              itemCount: snapshot.data.appoinments.length,
                              itemBuilder: (context, index) {
                                return snapshot.data.appoinments[index].isComplete ==
                                    false
                                    ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(top:15.0,bottom: 15),
                                          child: Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                child: ClipOval(
                                                  child: Image.network(
                                                    snapshot
                                                        .data
                                                        .appoinments[index]
                                                        .doctor
                                                        .avatarPath,
                                                    fit: BoxFit.cover,
                                                    width: 80,
                                                    height: 80,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .appoinments[index]
                                                        .doctor
                                                        .firstName +" "+
                                                        snapshot
                                                            .data
                                                            .appoinments[index]
                                                            .doctor
                                                            .lastName,
                                                    style: AppionCardTextBold,
                                                  ),
                                                  SizedBox(
                                                    width: 150,
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .appoinments[index]
                                                          .doctor
                                                          .degree,
                                                      maxLines: 1,
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: NormalText,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Serial Number : " +
                                                        snapshot.data
                                                            .appoinments[index].serialNum
                                                            .toString(),
                                                    style: NormalText,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(bottom:16.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.watch_later_outlined,
                                                        ),
                                                        SizedBox(width:displayWidth(context)*0.03 ,),
                                                        Text(
                                                          
                                                              snapshot.data
                                                                  .appoinments[index].time
                                                                  .replaceAll(".00", ""),
                                                          style: NormalText,
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                ],
                                              ),

                                              RaisedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>IndexPages(snapshot.data.appoinments[index])));},
                                                child: Text("Join",style: PagesBottonText,),
                                                color: BasedBlueColor,
                                                 shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8.0)),
                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                    elevation: 4,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(20)),
                                  ),
                                )
                                    : Center(
                                  child: Text(""),
                                );
                              })),
                      Container(
                          child:snapshot.data.appoinments.length==0?Center(child: Text("No Compeleted Appointments",style: NormalText,)): ListView.builder(
                              itemCount:
                              snapshot.data.appoinments.length,
                              itemBuilder: (context, index) {
                                return snapshot
                                    .data
                                    .appoinments[index]
                                    .isComplete ==
                                    true
                                    ? Padding(
                                  padding:
                                  const EdgeInsets.all(4.0),
                                  child: Card(
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceEvenly,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: CircleAvatar(
                                                backgroundColor:
                                                Colors.white,
                                                radius: 40,
                                                child: ClipOval(
                                                  child:
                                                  Image.network(
                                                    snapshot
                                                        .data
                                                        .appoinments[
                                                    index]
                                                        .doctor
                                                        .avatarPath,
                                                    fit: BoxFit
                                                        .cover,
                                                    width: 100,
                                                    height: 100,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot
                                                      .data
                                                      .appoinments[
                                                  index]
                                                      .doctor
                                                      .firstName +" "+
                                                      snapshot
                                                          .data
                                                          .appoinments[
                                                      index]
                                                          .doctor
                                                          .lastName,
                                                  style:
                                                  AppionCardTextBold,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data
                                                      .appoinments[
                                                  index]
                                                      .doctor
                                                      .degree,
                                                  style:
                                                  AppionCardText,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data
                                                      .appoinments[
                                                  index]
                                                      .doctor
                                                      .hospitalName,
                                                  style:
                                                  AppionCardText,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                  onPressed: () {
                                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPrescription(snapshot.data.appoinments[index])));
                                                  },
                                                  child: Text(
                                                    "Check prescription",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.deepOrange,
                                                        fontFamily:
                                                        "Poppins"),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          8.0)),
                                                  color:Color(0xfffbe9e7) //Colors.deepOrange[100],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: RaisedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>PatientHomeScreenPage()));
                                                },
                                                child: Text(
                                                  "Get appointment",
                                                  style: TextStyle(
                                                      color: Color(
                                                        0xff4286F5,
                                                      ),
                                                      fontFamily:
                                                      "Poppins"),
                                                ),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        8.0)),
                                                color:
                                                Color(0xffFFFFFF),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    elevation: 4,
                                    shadowColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            20)),
                                  ),
                                )
                                    : Center(
                                  child: Text(""),
                                );
                              })),
                    ],
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    ));
  }
}
