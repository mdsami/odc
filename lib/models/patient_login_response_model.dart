
import 'dart:convert';

class PatientLoginResponseModel {
  PatientLoginResponseModel({
    this.status,
    this.token,
    this.data,
  });

  final String status;
  final String token;
  final Data data;

  PatientLoginResponseModel copyWith({
    String status,
    String token,
    Data data,
  }) =>
      PatientLoginResponseModel(
        status: status ?? this.status,
        token: token ?? this.token,
        data: data ?? this.data,
      );

  factory PatientLoginResponseModel.fromRawJson(String str) => PatientLoginResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PatientLoginResponseModel.fromJson(Map<String, dynamic> json) => PatientLoginResponseModel(
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
    this.appoinments,
  });

  final String id;
  final Patient patient;
  final List<dynamic> appoinments;

  Data copyWith({
    String id,
    Patient patient,
    List<dynamic> appoinments,
  }) =>
      Data(
        id: id ?? this.id,
        patient: patient ?? this.patient,
        appoinments: appoinments ?? this.appoinments,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    patient: Patient.fromJson(json["patient"]),
    appoinments: List<dynamic>.from(json["appoinments"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "patient": patient.toJson(),
    "appoinments": List<dynamic>.from(appoinments.map((x) => x)),
  };
}

class Patient {
  Patient({
    this.id,
    this.contact,
    this.role,
  });

  final String id;
  final String contact;
  final String role;

  Patient copyWith({
    String id,
    String contact,
    String role,
  }) =>
      Patient(
        id: id ?? this.id,
        contact: contact ?? this.contact,
        role: role ?? this.role,
      );

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    contact: json["contact"],
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "contact": contact,
    "role": role,
  };
}

