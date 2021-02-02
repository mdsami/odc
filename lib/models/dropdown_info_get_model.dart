// To parse this JSON data, do
//
//     final dropDownModel = dropDownModelFromJson(jsonString);

import 'dart:convert';

class DropDownModel {
  DropDownModel({
    this.status,
    this.data,
  });

  final String status;
  final Data data;

  DropDownModel copyWith({
    String status,
    Data data,
  }) =>
      DropDownModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory DropDownModel.fromRawJson(String str) => DropDownModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DropDownModel.fromJson(Map<String, dynamic> json) => DropDownModel(
    status: json["status"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    this.designations,
    this.hospitals,
    this.specializations,
  });
  final List<Hospital> hospitals;
  final List<Specialization> specializations;
  final List<Designation> designations;

  Data copyWith({
    List<Hospital> hospitals,
    List<Specialization> specializations,
  }) =>
      Data(
        hospitals: hospitals ?? this.hospitals,
        specializations: specializations ?? this.specializations,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    designations: json["designations"] == null ? null : List<Designation>.from(json["designations"].map((x) => Designation.fromJson(x))),
    hospitals: List<Hospital>.from(json["hospitals"].map((x) => Hospital.fromJson(x))),
    specializations: List<Specialization>.from(json["specializations"].map((x) => Specialization.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "designations": designations == null ? null : List<dynamic>.from(designations.map((x) => x.toJson())),
    "hospitals": List<dynamic>.from(hospitals.map((x) => x.toJson())),
    "specializations": List<dynamic>.from(specializations.map((x) => x.toJson())),
  };
}
class Designation {
  Designation({
    this.id,
    this.designation,
    this.v,
  });

  String id;
  String designation;
  int v;

  factory Designation.fromJson(Map<String, dynamic> json) => Designation(
    id: json["_id"] == null ? null : json["_id"],
    designation: json["designation"] == null ? null : json["designation"],
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id == null ? null : id,
    "designation": designation == null ? null : designation,
    "__v": v == null ? null : v,
  };
}
class Hospital {
  Hospital({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  Hospital copyWith({
    String id,
    String name,
  }) =>
      Hospital(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Hospital.fromRawJson(String str) => Hospital.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}

class Specialization {
  Specialization({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  Specialization copyWith({
    String id,
    String name,
  }) =>
      Specialization(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Specialization.fromRawJson(String str) => Specialization.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
