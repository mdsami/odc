import 'package:feather_icons_flutter/feather_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:online_doctor_chember/constants/constant.dart';
import 'package:online_doctor_chember/models/patient_profile_get_respnse_model.dart';
import 'package:online_doctor_chember/providers/prescription_view.dart';
import 'package:online_doctor_chember/screen_size_helper/sized_helper.dart';
import 'package:provider/provider.dart';

class ViewPrescription extends StatefulWidget {
  Appoinment _appoinment;
  ViewPrescription(this._appoinment);
  @override
  _ViewPrescriptionState createState() => _ViewPrescriptionState();
}

class _ViewPrescriptionState extends State<ViewPrescription> {
  var _isLoading = false;
  void initState() {
    // TODO: implement initState
    _isLoading = true;
    Provider.of<Prescription>(context, listen: false)
        .GetPrescription(widget._appoinment.prescriptionID)
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var snapshot = Provider.of<Prescription>(context).prescription;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Prescription",
          ),
          backgroundColor: BasedBlueColor,
        ),
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
            : SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: Container(
                          height: displayHeight(context) * .5,
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount:
                                  snapshot.data.newPrescription.symptoms.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 0.0, right: 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Visited Day: ",
                                            style: AppionCardTextBold,
                                          ),
                                          Text(
                                            snapshot.data.newPrescription
                                                .appointment.dayOfWeek
                                                .toString(),
                                            style: NormalText,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Symptoms: ",
                                            style: AppionCardTextBold,
                                          ),
                                          SizedBox(
                                            width: displayWidth(context) * 0.5,
                                            child: Text(
                                              snapshot.data.newPrescription
                                                  .symptoms[index].feelsLike,
                                              style: NormalText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Tests: ",
                                            style: AppionCardTextBold,
                                          ),
                                          SizedBox(
                                            width: displayWidth(context) * 0.6,
                                            child: Text(
                                              snapshot.data.newPrescription
                                                  .tests[index].testName,
                                              style: NormalText,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.02,
                                      ),
                                      Text(
                                        "Medicine: ",
                                        style: AppionCardTextBold,
                                      ),
                                      SizedBox(
                                        height: displayHeight(context) * 0.02,
                                      ),
                                      Container(
                                        height: displayHeight(context) * 0.3,
                                        color: Colors.white,
                                        child: ListView.builder(
                                          itemCount: snapshot
                                              .data
                                              .newPrescription
                                              .medicinesSuggested
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: Icon(
                                                      FeatherIcons.arrowRight,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5.0),
                                                    child: SizedBox(
                                                        width: 160,
                                                        child: Text(
                                                          snapshot
                                                              .data
                                                              .newPrescription
                                                              .medicinesSuggested[
                                                                  index]
                                                              .medicine
                                                              .name,
                                                          style:
                                                              ProfileInfoText,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                        )),
                                                  ),
                                                  Text(
                                                    snapshot
                                                            .data
                                                            .newPrescription
                                                            .medicinesSuggested[
                                                                index]
                                                            .takeAtMorning
                                                            .toString() +
                                                        "-",
                                                    style: NormalText,
                                                  ),
                                                  Text(
                                                    snapshot
                                                            .data
                                                            .newPrescription
                                                            .medicinesSuggested[
                                                                index]
                                                            .takeAtLunch
                                                            .toString() +
                                                        "-",
                                                    style: NormalText,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child: Text(
                                                      snapshot
                                                          .data
                                                          .newPrescription
                                                          .medicinesSuggested[
                                                              index]
                                                          .takeAtDinner
                                                          .toString(),
                                                      style: NormalText,
                                                    ),
                                                  ),
                                                  Text(
                                                      snapshot
                                                              .data
                                                              .newPrescription
                                                              .medicinesSuggested[
                                                                  index]
                                                              .numberOfDays
                                                              .toString() +
                                                          " " +
                                                          "Days",
                                                      style: NormalText),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20, top: 20),
                        child: Container(
                          height: displayHeight(context) * .3,
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount: snapshot.data.historyData.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          actions: [
                                            TextButton(
                                                child: Text("Back"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                          title: Center(
                                              child: Text(
                                            "Prescription",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: "Poppins"),
                                          )),
                                          content: Container(
                                            height:
                                                displayHeight(context) * 0.5,
                                            width: displayWidth(context) * 1,
                                            color: Colors.grey[200],
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  snapshot.data.historyData[
                                                              index] ==
                                                          null
                                                      ? Text("")
                                                      : Row(
                                                          children: [
                                                            Text(
                                                              "Symptoms: ",
                                                              style:
                                                                  AppionCardTextBold,
                                                            ),
                                                            SizedBox(
                                                              width: displayWidth(
                                                                      context) *
                                                                  0.35,
                                                              child: Text(
                                                                snapshot
                                                                    .data
                                                                    .historyData[
                                                                        index]
                                                                    .symptoms[0]
                                                                    .feelsLike,
                                                                style:
                                                                    NormalText,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                  SizedBox(
                                                    height:
                                                        displayHeight(context) *
                                                            0.02,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Tests: ",
                                                        style:
                                                            AppionCardTextBold,
                                                      ),
                                                      SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.35,
                                                        child: Text(
                                                          snapshot
                                                              .data
                                                              .historyData[
                                                                  index]
                                                              .tests[0]
                                                              .testName,
                                                          style: NormalText,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        displayHeight(context) *
                                                            0.02,
                                                  ),
                                                  Text(
                                                    "Medicine: ",
                                                    style: AppionCardTextBold,
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        displayHeight(context) *
                                                            0.02,
                                                  ),
                                                  Container(
                                                    height:
                                                        displayHeight(context) *
                                                            0.2,
                                                    color: Colors.grey[200],
                                                    child: ListView.builder(
                                                      itemCount: snapshot
                                                          .data
                                                          .historyData[index]
                                                          .medicinesSuggested
                                                          .length,
                                                      itemBuilder:
                                                          (context, ind) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10.0),
                                                                child: Icon(
                                                                  FeatherIcons
                                                                      .arrowRight,
                                                                  color: Colors
                                                                      .orange,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right:
                                                                            10.0),
                                                                child: SizedBox(
                                                                    width: 100,
                                                                    child: Text(
                                                                      snapshot
                                                                          .data
                                                                          .historyData[
                                                                              index]
                                                                          .medicinesSuggested[
                                                                              ind]
                                                                          .medicine
                                                                          .name,
                                                                      style:
                                                                          ProfileInfoText,
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      softWrap:
                                                                          false,
                                                                    )),
                                                              ),
                                                              Text(
                                                                snapshot
                                                                        .data
                                                                        .historyData[
                                                                            index]
                                                                        .medicinesSuggested[
                                                                            0]
                                                                        .takeAtMorning
                                                                        .toString() +
                                                                    "-",
                                                                style:
                                                                    NormalText,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                        .data
                                                                        .historyData[
                                                                            index]
                                                                        .medicinesSuggested[
                                                                            0]
                                                                        .takeAtLunch
                                                                        .toString() +
                                                                    "-",
                                                                style:
                                                                    NormalText,
                                                              ),
                                                              Text(
                                                                snapshot
                                                                    .data
                                                                    .historyData[
                                                                        index]
                                                                    .medicinesSuggested[
                                                                        0]
                                                                    .takeAtDinner
                                                                    .toString(),
                                                                style:
                                                                    NormalText,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  snapshot
                                                                          .data
                                                                          .historyData[
                                                                              index]
                                                                          .medicinesSuggested[
                                                                              0]
                                                                          .numberOfDays
                                                                          .toString() +
                                                                      "days",
                                                                  style:
                                                                      NormalText,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: CircleAvatar(
                                              backgroundColor: Colors.white,
                                              radius: 45,
                                              child: ClipOval(
                                                child: Image.network(
                                                  snapshot
                                                      .data
                                                      .historyData[index]
                                                      .appointment
                                                      .doctor
                                                      .avatarPath,
                                                  fit: BoxFit.cover,
                                                  width: 100,
                                                  height: 100,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 15,
                                                    bottom: 5),
                                                child: Text(
                                                  snapshot
                                                          .data
                                                          .historyData[index]
                                                          .appointment
                                                          .doctor
                                                          .firstName +
                                                      " " +
                                                      snapshot
                                                          .data
                                                          .historyData[index]
                                                          .appointment
                                                          .doctor
                                                          .lastName,
                                                  style: NormalText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Text(
                                                  snapshot
                                                      .data
                                                      .historyData[index]
                                                      .appointment
                                                      .dayOfWeek,
                                                  style: NormalText,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0,
                                                    top: 5,
                                                    bottom: 10),
                                                child: Text(
                                                  snapshot.data
                                                      .historyData[index].date,
                                                  style: NormalText,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: BasedBlueColor,
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.blue[50],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ));
  }
}
