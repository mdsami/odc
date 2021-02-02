
import 'dart:convert';

class SheduleResponseModel {
  SheduleResponseModel({
    this.status,
    this.data,
  });

  final String status;
  final Data data;

  SheduleResponseModel copyWith({
    String status,
    Data data,
  }) =>
      SheduleResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory SheduleResponseModel.fromRawJson(String str) => SheduleResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SheduleResponseModel.fromJson(Map<String, dynamic> json) => SheduleResponseModel(
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
    this.id,
    this.maxNumberOfPatient,
    this.doctor,
    this.dayOfWeek,
    this.startAt,
    this.endAt,
    this.v,
  });

  final String id;
  final int maxNumberOfPatient;
  final String doctor;
  final String dayOfWeek;
  final String startAt;
  final String endAt;
  final int v;

  Data copyWith({
    String id,
    int maxNumberOfPatient,
    String doctor,
    String dayOfWeek,
    String startAt,
    String endAt,
    int v,
  }) =>
      Data(
        id: id ?? this.id,
        maxNumberOfPatient: maxNumberOfPatient ?? this.maxNumberOfPatient,
        doctor: doctor ?? this.doctor,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        startAt: startAt ?? this.startAt,
        endAt: endAt ?? this.endAt,
        v: v ?? this.v,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    maxNumberOfPatient: json["maxNumberOfPatient"],
    doctor: json["doctor"],
    dayOfWeek: json["dayOfWeek"],
    startAt: json["startAt"],
    endAt: json["endAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "maxNumberOfPatient": maxNumberOfPatient,
    "doctor": doctor,
    "dayOfWeek": dayOfWeek,
    "startAt": startAt,
    "endAt": endAt,
    "__v": v,
  };
}
