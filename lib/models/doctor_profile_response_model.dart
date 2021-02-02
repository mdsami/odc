
import 'dart:convert';

DoctorProfileInfoGetModel doctorProfileInfoGetModelFromJson(String str) => DoctorProfileInfoGetModel.fromJson(json.decode(str));

String doctorProfileInfoGetModelToJson(DoctorProfileInfoGetModel data) => json.encode(data.toJson());

class DoctorProfileInfoGetModel {
    DoctorProfileInfoGetModel({
        this.status,
        this.data,
    });

    String status;
    Data data;

    factory DoctorProfileInfoGetModel.fromJson(Map<String, dynamic> json) => DoctorProfileInfoGetModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.id,
        this.doctor,
        this.bmdcId,
        this.degree,
        this.designation,
        this.specialization,
        this.hospitals,
        this.schedules,
        this.appoinments,
    });

    String id;
    Doctor doctor;
    String bmdcId;
    String degree;
    Designation designation;
    Specialization specialization;
    List<Hospital> hospitals;
    List<Schedule> schedules;
    List<Appoinment> appoinments;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"] == null ? null : json["_id"],
        doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
        bmdcId: json["bmdcId"] == null ? null : json["bmdcId"],
        degree: json["degree"] == null ? null : json["degree"],
        designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
        specialization: json["specialization"] == null ? null : Specialization.fromJson(json["specialization"]),
        hospitals: json["hospitals"] == null ? null : List<Hospital>.from(json["hospitals"].map((x) => Hospital.fromJson(x))),
        schedules: json["schedules"] == null ? null : List<Schedule>.from(json["schedules"].map((x) => Schedule.fromJson(x))),
        appoinments: json["appoinments"] == null ? null : List<Appoinment>.from(json["appoinments"].map((x) => Appoinment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "doctor": doctor == null ? null : doctor.toJson(),
        "bmdcId": bmdcId == null ? null : bmdcId,
        "degree": degree == null ? null : degree,
        "designation": designation == null ? null : designation.toJson(),
        "specialization": specialization == null ? null : specialization.toJson(),
        "hospitals": hospitals == null ? null : List<dynamic>.from(hospitals.map((x) => x.toJson())),
        "schedules": schedules == null ? null : List<dynamic>.from(schedules.map((x) => x.toJson())),
        "appoinments": appoinments == null ? null : List<dynamic>.from(appoinments.map((x) => x.toJson())),
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
        this.patient,
        this.isSecondTime,
        this.prescriptionId,
    });

    String id;
    String date;
    String time;
    int serialNum;
    bool isComplete;
    String dayOfWeek;
    Patient patient;
    bool isSecondTime;
    String prescriptionId;

    factory Appoinment.fromJson(Map<String, dynamic> json) => Appoinment(
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        serialNum: json["serialNum"] == null ? null : json["serialNum"],
        isComplete: json["isComplete"] == null ? null : json["isComplete"],
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        patient: json["patient"] == null ? null : Patient.fromJson(json["patient"]),
        prescriptionId: json["prescriptionID"] == null ? null : json["prescriptionID"],
        isSecondTime: json["isSecondTime"] == null ? null : json["isSecondTime"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "date": date == null ? null : date,
        "time": time == null ? null : time,
        "serialNum": serialNum == null ? null : serialNum,
        "isComplete": isComplete == null ? null : isComplete,
        "dayOfWeek": dayOfWeek == null ? null : dayOfWeek,
        "patient": patient == null ? null : patient.toJson(),
        "prescriptionID": prescriptionId == null ? null : prescriptionId,
        "isSecondTime": isSecondTime == null ? null : isSecondTime,
    };
}

class Patient {
    Patient({
        this.id,
        this.firstName,
        this.lastName,
        this.avatarPath,
        this.deviceId,
    });

    String id;
    String firstName;
    String lastName;
    String avatarPath;
    String deviceId;

    factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json["_id"] == null ? null : json["_id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
        deviceId: json["deviceId"] == null ? null : json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatarPath": avatarPath == null ? null : avatarPath,
        "deviceId": deviceId == null ? null : deviceId,
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

class Doctor {
    Doctor({
        this.id,
        this.firstName,
        this.lastName,
        this.role,
        this.avatarPath,
        this.contact,
        this.gender,
    });

    String id;
    String firstName;
    String lastName;
    String role;
    String avatarPath;
    String contact;
    String gender;

    factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json["_id"] == null ? null : json["_id"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        role: json["role"] == null ? null : json["role"],
        avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
        contact: json["contact"] == null ? null : json["contact"],
        gender: json["gender"] == null ? null : json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "role": role == null ? null : role,
        "avatarPath": avatarPath == null ? null : avatarPath,
        "contact": contact == null ? null : contact,
        "gender": gender == null ? null : gender,
    };
}

class Hospital {
    Hospital({
        this.id,
        this.name,
        this.location,
    });

    String id;
    String name;
    String location;

    factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : json["location"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "location": location == null ? null : location,
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

    String id;
    int maxNumberOfPatient;
    String dayOfWeek;
    String startAt;
    String endAt;

    factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["_id"] == null ? null : json["_id"],
        maxNumberOfPatient: json["maxNumberOfPatient"] == null ? null : json["maxNumberOfPatient"],
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        startAt: json["startAt"] == null ? null : json["startAt"],
        endAt: json["endAt"] == null ? null : json["endAt"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "maxNumberOfPatient": maxNumberOfPatient == null ? null : maxNumberOfPatient,
        "dayOfWeek": dayOfWeek == null ? null : dayOfWeek,
        "startAt": startAt == null ? null : startAt,
        "endAt": endAt == null ? null : endAt,
    };
}

class Specialization {
    Specialization({
        this.id,
        this.name,
        this.description,
    });

    String id;
    String name;
    String description;

    factory Specialization.fromJson(Map<String, dynamic> json) => Specialization(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        description: json["description"] == null ? null : json["description"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "description": description == null ? null : description,
    };
}
