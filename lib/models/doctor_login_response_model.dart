import 'dart:convert';

class DoctorLoginResponseModel {
  DoctorLoginResponseModel({
    this.status,
    this.token,
    this.data,
  });

  final String status;
  final String token;
  final Data data;

  DoctorLoginResponseModel copyWith({
    String status,
    String token,
    Data data,
  }) =>
      DoctorLoginResponseModel(
        status: status ?? this.status,
        token: token ?? this.token,
        data: data ?? this.data,
      );

  factory DoctorLoginResponseModel.fromRawJson(String str) => DoctorLoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DoctorLoginResponseModel.fromJson(Map<String, dynamic> json) => DoctorLoginResponseModel(
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
    this.doctor,
    this.bmdcId,
    this.hospitals,
    this.schedules,
    this.appoinments,
  });

  final String id;
  final Doctor doctor;
  final String bmdcId;
  final List<dynamic> hospitals;
  final List<dynamic> schedules;
  final List<dynamic> appoinments;

  Data copyWith({
    String id,
    Doctor doctor,
    String bmdcId,
    List<dynamic> hospitals,
    List<dynamic> schedules,
    List<dynamic> appoinments,
  }) =>
      Data(
        id: id ?? this.id,
        doctor: doctor ?? this.doctor,
        bmdcId: bmdcId ?? this.bmdcId,
        hospitals: hospitals ?? this.hospitals,
        schedules: schedules ?? this.schedules,
        appoinments: appoinments ?? this.appoinments,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    doctor: Doctor.fromJson(json["doctor"]),
    bmdcId: json["bmdcId"],
    hospitals: List<dynamic>.from(json["hospitals"].map((x) => x)),
    schedules: List<dynamic>.from(json["schedules"].map((x) => x)),
    appoinments: List<dynamic>.from(json["appoinments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "doctor": doctor.toJson(),
    "bmdcId": bmdcId,
    "hospitals": List<dynamic>.from(hospitals.map((x) => x)),
    "schedules": List<dynamic>.from(schedules.map((x) => x)),
    "appoinments": List<dynamic>.from(appoinments.map((x) => x)),
  };
}

class Doctor {
  Doctor({
    this.id,
    this.firstName,
    this.lastName,
    this.role,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String role;

  Doctor copyWith({
    String id,
    String firstName,
    String lastName,
    String role,
  }) =>
      Doctor(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        role: role ?? this.role,
      );

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "role": role,
  };
}
