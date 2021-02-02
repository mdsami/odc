import 'dart:convert';

class PrescriptionResponseModel{
  PrescriptionResponseModel({
    this.status,
    this.data,
  });

  final String status;
  final Data data;

  PrescriptionResponseModel copyWith({
    String status,
    Data data,
  }) =>
      PrescriptionResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory PrescriptionResponseModel.fromRawJson(String str) => PrescriptionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PrescriptionResponseModel.fromJson(Map<String, dynamic> json) => PrescriptionResponseModel(
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
    this.advice,
    this.symptoms,
    this.foodsSuggested,
    this.medicinesSuggested,
    this.exercisesSuggested,
    this.appointment,
  });

  final String id;
  final String advice;
  final List<dynamic> symptoms;
  final List<dynamic> foodsSuggested;
  final List<dynamic> medicinesSuggested;
  final List<dynamic> exercisesSuggested;
  final Appointment appointment;

  Data copyWith({
    String id,
    String advice,
    List<dynamic> symptoms,
    List<dynamic> foodsSuggested,
    List<dynamic> medicinesSuggested,
    List<dynamic> exercisesSuggested,
    Appointment appointment,
  }) =>
      Data(
        id: id ?? this.id,
        advice: advice ?? this.advice,
        symptoms: symptoms ?? this.symptoms,
        foodsSuggested: foodsSuggested ?? this.foodsSuggested,
        medicinesSuggested: medicinesSuggested ?? this.medicinesSuggested,
        exercisesSuggested: exercisesSuggested ?? this.exercisesSuggested,
        appointment: appointment ?? this.appointment,
      );

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    advice: json["advice"],
    symptoms: List<dynamic>.from(json["symptoms"].map((x) => x)),
    foodsSuggested: List<dynamic>.from(json["foodsSuggested"].map((x) => x)),
    medicinesSuggested: List<dynamic>.from(json["medicinesSuggested"].map((x) => x)),
    exercisesSuggested: List<dynamic>.from(json["exercisesSuggested"].map((x) => x)),
    appointment: Appointment.fromJson(json["appointment"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "advice": advice,
    "symptoms": List<dynamic>.from(symptoms.map((x) => x)),
    "foodsSuggested": List<dynamic>.from(foodsSuggested.map((x) => x)),
    "medicinesSuggested": List<dynamic>.from(medicinesSuggested.map((x) => x)),
    "exercisesSuggested": List<dynamic>.from(exercisesSuggested.map((x) => x)),
    "appointment": appointment.toJson(),
  };
}

class Appointment {
  Appointment({
    this.doctorConsent,
    this.patientConsent,
    this.isComplete,
    this.id,
    this.dayOfWeek,
    this.time,
    this.doctor,
    this.patient,
  });

  final bool doctorConsent;
  final bool patientConsent;
  final bool isComplete;
  final String id;
  final String dayOfWeek;
  final String time;
  final Doctor doctor;
  final Patient patient;

  Appointment copyWith({
    bool doctorConsent,
    bool patientConsent,
    bool isComplete,
    String id,
    String dayOfWeek,
    String time,
    Doctor doctor,
    Patient patient,
  }) =>
      Appointment(
        doctorConsent: doctorConsent ?? this.doctorConsent,
        patientConsent: patientConsent ?? this.patientConsent,
        isComplete: isComplete ?? this.isComplete,
        id: id ?? this.id,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        time: time ?? this.time,
        doctor: doctor ?? this.doctor,
        patient: patient ?? this.patient,
      );

  factory Appointment.fromRawJson(String str) => Appointment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
    doctorConsent: json["doctorConsent"],
    patientConsent: json["patientConsent"],
    isComplete: json["isComplete"],
    id: json["_id"],
    dayOfWeek: json["dayOfWeek"],
    time: json["time"],
    doctor: Doctor.fromJson(json["doctor"]),
    patient: Patient.fromJson(json["patient"]),
  );

  Map<String, dynamic> toJson() => {
    "doctorConsent": doctorConsent,
    "patientConsent": patientConsent,
    "isComplete": isComplete,
    "_id": id,
    "dayOfWeek": dayOfWeek,
    "time": time,
    "doctor": doctor.toJson(),
    "patient": patient.toJson(),
  };
}

class Doctor {
  Doctor({
    this.hospitalsName,
    this.hospitalsLocation,
    this.firstName,
    this.lastName,
    this.degree,
  });

  final String hospitalsName;
  final String hospitalsLocation;
  final String firstName;
  final String lastName;
  final String degree;

  Doctor copyWith({
    String hospitalsName,
    String hospitalsLocation,
    String firstName,
    String lastName,
    String degree,
  }) =>
      Doctor(
        hospitalsName: hospitalsName ?? this.hospitalsName,
        hospitalsLocation: hospitalsLocation ?? this.hospitalsLocation,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        degree: degree ?? this.degree,
      );

  factory Doctor.fromRawJson(String str) => Doctor.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
    hospitalsName: json["hospitalsName"],
    hospitalsLocation: json["hospitalsLocation"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    degree: json["degree"],
  );

  Map<String, dynamic> toJson() => {
    "hospitalsName": hospitalsName,
    "hospitalsLocation": hospitalsLocation,
    "firstName": firstName,
    "lastName": lastName,
    "degree": degree,
  };
}

class Patient {
  Patient({
    this.firstName,
    this.lastName,
    this.address,
    this.bloodGroup,
  });

  final String firstName;
  final String lastName;
  final String address;
  final String bloodGroup;

  Patient copyWith({
    String firstName,
    String lastName,
    String address,
    String bloodGroup,
  }) =>
      Patient(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        address: address ?? this.address,
        bloodGroup: bloodGroup ?? this.bloodGroup,
      );

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    firstName: json["firstName"],
    lastName: json["lastName"],
    address: json["address"],
    bloodGroup: json["bloodGroup"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "address": address,
    "bloodGroup": bloodGroup,
  };
}
