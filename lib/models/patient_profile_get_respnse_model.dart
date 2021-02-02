
import 'dart:convert';

class PatientProfileResponseModel {
  PatientProfileResponseModel({
    this.status,
    this.token,
    this.data,
  });

  final String status;
  final String token;
  final Data data;

  PatientProfileResponseModel copyWith({
    String status,
    String token,
    Data data,
  }) =>
      PatientProfileResponseModel(
        status: status ?? this.status,
        token: token ?? this.token,
        data: data ?? this.data,
      );

  factory PatientProfileResponseModel.fromRawJson(String str) => PatientProfileResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientProfileResponseModel.fromJson(Map<String, dynamic> json) => PatientProfileResponseModel(
    status: json["status"],
    token: json["token"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "token": token,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.patient,
    this.bloodGroup,
    this.nationalId,
    this.appoinments,
  });

  final String id;
  final Patient patient;
  final String bloodGroup;
  final String nationalId;
  final List<Appoinment> appoinments;

  Data copyWith({
    String id,
    Patient patient,
    String bloodGroup,
    String nationalId,
    List<Appoinment> appoinments,
  }) =>
      Data(
        id: id ?? this.id,
        patient: patient ?? this.patient,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        nationalId: nationalId ?? this.nationalId,
        appoinments: appoinments ?? this.appoinments,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    patient: Patient.fromJson(json["patient"]),
    bloodGroup: json["bloodGroup"],
    nationalId: json["nationalId"],
    appoinments: List<Appoinment>.from(json["appoinments"].map((x) => Appoinment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patient": patient.toJson(),
    "bloodGroup": bloodGroup,
    "nationalId": nationalId,
    "appoinments": List<dynamic>.from(appoinments.map((x) => x.toJson())),
  };
}

class Appoinment {
  Appoinment({
    this.id,
    this.date,
    this.time,
    this.serialNum,
    this.isComplete,
    this.dayOfWeek,
    this.prescriptionID,
    this.doctor,
  });
  final String id;
  final String date;
  final String time;
  final int serialNum;
  final bool isComplete;
  final String dayOfWeek;
  final String prescriptionID;
  final Doctor doctor;

  Appoinment copyWith({
    String date,
    String time,
    int serialNum,
    bool isComplete,
    String dayOfWeek,
    String prescriptionID,
    Doctor doctor,
  }) =>
      Appoinment(
        date: date ?? this.date,
        time: time ?? this.time,
        serialNum: serialNum ?? this.serialNum,
        isComplete: isComplete ?? this.isComplete,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        prescriptionID: prescriptionID ?? this.prescriptionID,
        doctor: doctor ?? this.doctor,
      );

  factory Appoinment.fromRawJson(String str) => Appoinment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appoinment.fromJson(Map<String, dynamic> json) => Appoinment(
    id: json["_id"],
    date: json["date"],
    time: json["time"],
    serialNum: json["serialNum"],
    isComplete: json["isComplete"],
    dayOfWeek: json["dayOfWeek"],
    prescriptionID:json["prescriptionID"],
    doctor: Doctor.fromJson(json["doctor"]),
  );

  Map<String, dynamic> toJson() => {
    "id":id,
    "date": date,
    "time": time,
    "serialNum": serialNum,
    "isComplete": isComplete,
    "dayOfWeek": dayOfWeek,
    "prescriptionID":prescriptionID,
    "doctor": doctor.toJson(),
  };
}

class Doctor {
  Doctor({
    this.firstName,
    this.lastName,
    this.avatarPath,
    this.degree,
    this.hospitalName,
    this.hospitalLocation,
  });

  final String firstName;
  final String lastName;
  final String avatarPath;
  final String degree;
  final String hospitalName;
  final String hospitalLocation;

  Doctor copyWith({
    String firstName,
    String lastName,
    String designation,
    String hospitalName,
    String hospitalLocation,
  }) =>
      Doctor(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        avatarPath: avatarPath ?? this.avatarPath,
        degree: degree ?? this.degree,
        hospitalName: hospitalName ?? this.hospitalName,
        hospitalLocation: hospitalLocation ?? this.hospitalLocation,
      );

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    firstName: json["firstName"],
    lastName: json["lastName"],
    avatarPath:json["avatarPath"],
    degree: json["degree"],
    hospitalName: json["hospitalName"],
    hospitalLocation: json["hospitalLocation"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "avatarPath":avatarPath,
    "degree": degree,
    "hospitalName": hospitalName,
    "hospitalLocation": hospitalLocation,
  };
}

class Patient {
  Patient({
    this.id,
    this.contact,
    this.role,
    this.address,
    this.avatarPath,
    this.firstName,
    this.gender,
    this.lastName,
  });

  final String id;
  final String contact;
  final String role;
  final String address;
  final String avatarPath;
  final String firstName;
  final String gender;
  final String lastName;

  Patient copyWith({
    String id,
    String contact,
    String role,
    String address,
    String avatarPath,
    String firstName,
    String gender,
    String lastName,
  }) =>
      Patient(
        id: id ?? this.id,
        contact: contact ?? this.contact,
        role: role ?? this.role,
        address: address ?? this.address,
        avatarPath: avatarPath ?? this.avatarPath,
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName ?? this.lastName,
      );

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    contact: json["contact"],
    role: json["role"],
    address: json["address"],
    avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
    firstName: json["firstName"],
    gender: json["gender"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "contact": contact,
    "role": role,
    "address": address,
    "avatarPath": avatarPath,
    "firstName": firstName,
    "gender": gender,
    "lastName": lastName,
  };
}
