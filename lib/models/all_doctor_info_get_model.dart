
import 'dart:convert';

class GetDoctorInfoModel {
  GetDoctorInfoModel({
    this.status,
    this.data,
  });

  final String status;
  final List<Datum> data;

  GetDoctorInfoModel copyWith({
    String status,
    List<Datum> data,
  }) =>
      GetDoctorInfoModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory GetDoctorInfoModel.fromRawJson(String str) => GetDoctorInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetDoctorInfoModel.fromJson(Map<String, dynamic> json) => GetDoctorInfoModel(
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
    this.hospitals,
    this.schedules,
    this.appoinments,
    this.id,
    this.user,
    this.bmdcId,
    this.v,
    this.degree,
    this.designation,
    this.specialization,
  });

  final List<Hospital> hospitals;
  final List<Schedule> schedules;
  final List<int> appoinments;
  final String id;
  final User user;
  final String bmdcId;
  final int v;
  final String degree;
  Designation designation;
  final Specialization specialization;

  Datum copyWith({
    List<Hospital> hospitals,
    List<Schedule> schedules,
    List<int> appoinments,
    String id,
    User user,
    String bmdcId,
    int v,
    String degree,
    Designation designation,
    Specialization specialization,
  }) =>
      Datum(
        hospitals: hospitals ?? this.hospitals,
        schedules: schedules ?? this.schedules,
        appoinments: appoinments ?? this.appoinments,
        id: id ?? this.id,
        user: user ?? this.user,
        bmdcId: bmdcId ?? this.bmdcId,
        v: v ?? this.v,
        degree: degree ?? this.degree,
        specialization: specialization ?? this.specialization,
      );

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    hospitals: List<Hospital>.from(json["hospitals"].map((x) => Hospital.fromJson(x))),
    schedules: List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
    appoinments: List<int>.from(json["appoinments"].map((x) => x)),
    id: json["_id"],
    user: User.fromJson(json["user"]),
    bmdcId: json["bmdcId"],
    v: json["__v"],
    degree: json["degree"],
    designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
    specialization: Specialization.fromJson(json["specialization"]),
  );

  Map<String, dynamic> toJson() => {
    "hospitals": List<dynamic>.from(hospitals.map((x) => x.toJson())),
    "schedules": List<dynamic>.from(schedules.map((x) => x.toJson())),
    "appoinments": List<dynamic>.from(appoinments.map((x) => x)),
    "_id": id,
    "user": user.toJson(),
    "bmdcId": bmdcId,
    "__v": v,
    "degree": degree,
    "specialization": specialization.toJson(),
  };
}
class Designation {
  Designation({
    this.id,
    this.designation,
  });

  String id;
  String designation;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json["_id"] == null ? null : json["_id"],
    designation: json["designation"] == null ? null : json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "designation": designation == null ? null : designation,
  };
}
class Hospital {
  Hospital({
    this.id,
    this.name,
    this.location,
  });

  final String id;
  final String name;
  final String location;

  Hospital copyWith({
    String id,
    String name,
    String location,
  }) =>
      Hospital(
        id: id ?? this.id,
        name: name ?? this.name,
        location: location ?? this.location,
      );

  factory Hospital.fromRawJson(String str) => Hospital.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json["_id"],
    name: json["name"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "location": location,
  };
}

class Schedule {
  Schedule({
    this.id,
    this.maxNumberOfPatient,
    this.dayOfWeek,
    this.startAt,
    this.endAt,
  });

  final String id;
  final int maxNumberOfPatient;
  final String dayOfWeek;
  final String startAt;
  final String endAt;

  Schedule copyWith({
    String id,
    int maxNumberOfPatient,
    String dayOfWeek,
    String startAt,
    String endAt,
  }) =>
      Schedule(
        id: id ?? this.id,
        maxNumberOfPatient: maxNumberOfPatient ?? this.maxNumberOfPatient,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
      );

  factory Schedule.fromRawJson(String str) => Schedule.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json["_id"],
    maxNumberOfPatient: json["maxNumberOfPatient"],
    dayOfWeek: json["dayOfWeek"],
    startAt: json["startAt"],
    endAt: json["endAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "maxNumberOfPatient": maxNumberOfPatient,
    "dayOfWeek": dayOfWeek,
    "startAt": startAt,
    "endAt": endAt,
  };
}

class Specialization {
  Specialization({
    this.id,
    this.name,
    this.description,
  });

  final String id;
  final String name;
  final String description;

  Specialization copyWith({
    String id,
    String name,
    String description,
  }) =>
      Specialization(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
      );

  factory Specialization.fromRawJson(String str) => Specialization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
  };
}

class User {
  User({
    this.id,
    this.role,
    this.avatarPath,
    this.contact,
    this.firstName,
    this.gender,
    this.lastName,
  });

  final String id;
  final String role;
  final String avatarPath;
  final String contact;
  final String firstName;
  final String gender;
  final String lastName;

  User copyWith({
    String id,
    String role,
    String contact,
    String firstName,
    String gender,
    String lastName,
  }) =>
      User(
        id: id ?? this.id,
        role: role ?? this.role,
        contact: contact ?? this.contact,
        avatarPath: avatarPath ?? this.avatarPath,
        firstName: firstName ?? this.firstName,
        gender: gender ?? this.gender,
        lastName: lastName ?? this.lastName,
      );

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    role: json["role"],
    avatarPath:json["avatarPath"],
    contact: json["contact"],
    firstName: json["firstName"],
    gender: json["gender"],
    lastName: json["lastName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "role": role,
    "avatarPath":avatarPath,
    "contact": contact,
    "firstName": firstName,
    "gender": gender,
    "lastName": lastName,
  };
}
