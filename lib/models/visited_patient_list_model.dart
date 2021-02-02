
import 'dart:convert';

class VisitedPatientCompelteListModel {
  VisitedPatientCompelteListModel({
    this.status,
    this.data,
  });

  final String status;
  final List<Datum> data;

  VisitedPatientCompelteListModel copyWith({
    String status,
    List<Datum> data,
  }) =>
      VisitedPatientCompelteListModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory VisitedPatientCompelteListModel.fromRawJson(String str) => VisitedPatientCompelteListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VisitedPatientCompelteListModel.fromJson(Map<String, dynamic> json) => VisitedPatientCompelteListModel(
    status: json["status"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.serialNum,
    this.date,
    this.time,
    this.dayOfWeek,
    this.patient,
    this.prescription,
  });

  final String id;
  final int serialNum;
  final String date;
  final String time;
  final String dayOfWeek;
  final Patient patient;
  final String prescription;

  Datum copyWith({
    String id,
    int serialNum,
    String date,
    String time,
    String dayOfWeek,
    Patient patient,
    String prescription,
  }) =>
      Datum(
        id: id ?? this.id,
        serialNum: serialNum ?? this.serialNum,
        date: date ?? this.date,
        time: time ?? this.time,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        patient: patient ?? this.patient,
        prescription: prescription ?? this.prescription,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    serialNum: json["serialNum"],
    date: json["date"],
    time: json["time"],
    dayOfWeek: json["dayOfWeek"],
    patient: Patient.fromJson(json["patient"]),
    prescription: json["prescription"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "serialNum": serialNum,
    "date": date,
    "time": time,
    "dayOfWeek": dayOfWeek,
    "patient": patient.toJson(),
    "prescription": prescription,
  };
}

class Patient {
  Patient({
    this.id,
    this.firstName,
    this.lastName,
    this.contact,
    this.avatarPath
  });

  final String id;
  final String firstName;
  final String lastName;
  final String contact;
  String avatarPath;

  Patient copyWith({
    String id,
    String firstName,
    String lastName,
    String contact,
  }) =>
      Patient(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        contact: contact ?? this.contact,

      );

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    avatarPath: json["avatarPath"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "contact": contact,
    "avatarPath": avatarPath,
  };
}
