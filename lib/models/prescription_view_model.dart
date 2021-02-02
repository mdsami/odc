

import 'dart:convert';

PrescriptionViewModel prescriptionViewModelFromJson(String str) => PrescriptionViewModel.fromJson(json.decode(str));

String prescriptionViewModelToJson(PrescriptionViewModel data) => json.encode(data.toJson());

DoctorProfileInfoGetModel doctorProfileInfoGetModelFromJson(String str) => DoctorProfileInfoGetModel.fromJson(json.decode(str));

String doctorProfileInfoGetModelToJson(DoctorProfileInfoGetModel data) => json.encode(data.toJson());

class PrescriptionViewModel {
    PrescriptionViewModel({
        this.status,
        this.data,
    });

    String status;
    PrescriptionViewModelData data;

    factory PrescriptionViewModel.fromJson(Map<String, dynamic> json) => PrescriptionViewModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : PrescriptionViewModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}

class PrescriptionViewModelData {
    PrescriptionViewModelData({
        this.newPrescription,
        this.historyData,
    });

    NewPrescription newPrescription;
    List<HistoryDatum> historyData;

    factory PrescriptionViewModelData.fromJson(Map<String, dynamic> json) => PrescriptionViewModelData(
        newPrescription: json["newPrescription"] == null ? null : NewPrescription.fromJson(json["newPrescription"]),
        historyData: json["historyData"] == null ? null : List<HistoryDatum>.from(json["historyData"].map((x) => HistoryDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "newPrescription": newPrescription == null ? null : newPrescription.toJson(),
        "historyData": historyData == null ? null : List<dynamic>.from(historyData.map((x) => x.toJson())),
    };
}

class HistoryDatum {
    HistoryDatum({
        this.id,
        this.symptoms,
        this.tests,
        this.foodsSuggested,
        this.medicinesSuggested,
        this.exercisesSuggested,
        this.appointment,
        this.date,
    });

    String id;
    List<Symptom> symptoms;
    List<Test> tests;
    List<dynamic> foodsSuggested;
    List<MedicinesSuggested> medicinesSuggested;
    List<dynamic> exercisesSuggested;
    HistoryDatumAppointment appointment;
    String date;

    factory HistoryDatum.fromJson(Map<String, dynamic> json) => HistoryDatum(
        id: json["_id"] == null ? null : json["_id"],
        symptoms: json["symptoms"] == null ? null : List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromJson(x))),
        tests: json["tests"] == null ? null : List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        foodsSuggested: json["foodsSuggested"] == null ? null : List<dynamic>.from(json["foodsSuggested"].map((x) => x)),
        medicinesSuggested: json["medicinesSuggested"] == null ? null : List<MedicinesSuggested>.from(json["medicinesSuggested"].map((x) => MedicinesSuggested.fromJson(x))),
        exercisesSuggested: json["exercisesSuggested"] == null ? null : List<dynamic>.from(json["exercisesSuggested"].map((x) => x)),
        appointment: json["appointment"] == null ? null : HistoryDatumAppointment.fromJson(json["appointment"]),
        date: json["date"] == null ? null : json["date"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "symptoms": symptoms == null ? null : List<dynamic>.from(symptoms.map((x) => x.toJson())),
        "tests": tests == null ? null : List<dynamic>.from(tests.map((x) => x.toJson())),
        "foodsSuggested": foodsSuggested == null ? null : List<dynamic>.from(foodsSuggested.map((x) => x)),
        "medicinesSuggested": medicinesSuggested == null ? null : List<dynamic>.from(medicinesSuggested.map((x) => x.toJson())),
        "exercisesSuggested": exercisesSuggested == null ? null : List<dynamic>.from(exercisesSuggested.map((x) => x)),
        "appointment": appointment == null ? null : appointment.toJson(),
        "date": date == null ? null : date,
    };
}

class HistoryDatumAppointment {
    HistoryDatumAppointment({
        this.id,
        this.dayOfWeek,
        this.time,
        this.doctor,
    });

    String id;
    String dayOfWeek;
    String time;
    PurpleDoctor doctor;

    factory HistoryDatumAppointment.fromJson(Map<String, dynamic> json) => HistoryDatumAppointment(
        id: json["_id"] == null ? null : json["_id"],
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        time: json["time"] == null ? null : json["time"],
        doctor: json["doctor"] == null ? null : PurpleDoctor.fromJson(json["doctor"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "dayOfWeek": dayOfWeek == null ? null : dayOfWeek,
        "time": time == null ? null : time,
        "doctor": doctor == null ? null : doctor.toJson(),
    };
}

class PurpleDoctor {
    PurpleDoctor({
        this.hospitalsName,
        this.firstName,
        this.lastName,
        this.avatarPath,
        this.degree,
    });

    String hospitalsName;
    String firstName;
    String lastName;
    String avatarPath;
    String degree;

    factory PurpleDoctor.fromJson(Map<String, dynamic> json) => PurpleDoctor(
        hospitalsName: json["hospitalsName"] == null ? null : json["hospitalsName"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
        degree: json["degree"] == null ? null : json["degree"],
    );

    Map<String, dynamic> toJson() => {
        "hospitalsName": hospitalsName == null ? null : hospitalsName,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatarPath": avatarPath == null ? null : avatarPath,
        "degree": degree == null ? null : degree,
    };
}

class MedicinesSuggested {
    MedicinesSuggested({
        this.takeAtMorning,
        this.takeAtLunch,
        this.takeAtDinner,
        this.id,
        this.morning,
        this.lunch,
        this.dinner,
        this.numberOfDays,
        this.medicine,
    });

    int takeAtMorning;
    int takeAtLunch;
    int takeAtDinner;
    String id;
    bool morning;
    bool lunch;
    bool dinner;
    int numberOfDays;
    Medicine medicine;

    factory MedicinesSuggested.fromJson(Map<String, dynamic> json) => MedicinesSuggested(
        takeAtMorning: json["takeAtMorning"] == null ? null : json["takeAtMorning"],
        takeAtLunch: json["takeAtLunch"] == null ? null : json["takeAtLunch"],
        takeAtDinner: json["takeAtDinner"] == null ? null : json["takeAtDinner"],
        id: json["_id"] == null ? null : json["_id"],
        morning: json["morning"] == null ? null : json["morning"],
        lunch: json["lunch"] == null ? null : json["lunch"],
        dinner: json["dinner"] == null ? null : json["dinner"],
        numberOfDays: json["numberOfDays"] == null ? null : json["numberOfDays"],
        medicine: json["medicine"] == null ? null : Medicine.fromJson(json["medicine"]),
    );

    Map<String, dynamic> toJson() => {
        "takeAtMorning": takeAtMorning == null ? null : takeAtMorning,
        "takeAtLunch": takeAtLunch == null ? null : takeAtLunch,
        "takeAtDinner": takeAtDinner == null ? null : takeAtDinner,
        "_id": id == null ? null : id,
        "morning": morning == null ? null : morning,
        "lunch": lunch == null ? null : lunch,
        "dinner": dinner == null ? null : dinner,
        "numberOfDays": numberOfDays == null ? null : numberOfDays,
        "medicine": medicine == null ? null : medicine.toJson(),
    };
}

class Medicine {
    Medicine({
        this.id,
        this.name,
        this.company,
        this.medicineSuggested,
    });

    String id;
    String name;
    BodyPart company;
    String medicineSuggested;

    factory Medicine.fromJson(Map<String, dynamic> json) => Medicine(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        company: json["company"] == null ? null : bodyPartValues.map[json["company"]],
        medicineSuggested: json["medicineSuggested"] == null ? null : json["medicineSuggested"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "company": company == null ? null : bodyPartValues.reverse[company],
        "medicineSuggested": medicineSuggested == null ? null : medicineSuggested,
    };
}

enum BodyPart { A }

final bodyPartValues = EnumValues({
    "a": BodyPart.A
});

class Symptom {
    Symptom({
        this.id,
        this.feelsLike,
        this.bodyPart,
    });

    String id;
    String feelsLike;
    BodyPart bodyPart;

    factory Symptom.fromJson(Map<String, dynamic> json) => Symptom(
        id: json["_id"] == null ? null : json["_id"],
        feelsLike: json["feelsLike"] == null ? null : json["feelsLike"],
        bodyPart: json["bodyPart"] == null ? null : bodyPartValues.map[json["bodyPart"]],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "feelsLike": feelsLike == null ? null : feelsLike,
        "bodyPart": bodyPart == null ? null : bodyPartValues.reverse[bodyPart],
    };
}

class Test {
    Test({
        this.id,
        this.testName,
    });

    String id;
    String testName;

    factory Test.fromJson(Map<String, dynamic> json) => Test(
        id: json["_id"] == null ? null : json["_id"],
        testName: json["testName"] == null ? null : json["testName"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "testName": testName == null ? null : testName,
    };
}

class NewPrescription {
    NewPrescription({
        this.id,
        this.date,
        this.symptoms,
        this.tests,
        this.foodsSuggested,
        this.medicinesSuggested,
        this.exercisesSuggested,
        this.appointment,
    });

    String id;
    String date;
    List<Symptom> symptoms;
    List<Test> tests;
    List<dynamic> foodsSuggested;
    List<MedicinesSuggested> medicinesSuggested;
    List<dynamic> exercisesSuggested;
    NewPrescriptionAppointment appointment;

    factory NewPrescription.fromJson(Map<String, dynamic> json) => NewPrescription(
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : json["date"],
        symptoms: json["symptoms"] == null ? null : List<Symptom>.from(json["symptoms"].map((x) => Symptom.fromJson(x))),
        tests: json["tests"] == null ? null : List<Test>.from(json["tests"].map((x) => Test.fromJson(x))),
        foodsSuggested: json["foodsSuggested"] == null ? null : List<dynamic>.from(json["foodsSuggested"].map((x) => x)),
        medicinesSuggested: json["medicinesSuggested"] == null ? null : List<MedicinesSuggested>.from(json["medicinesSuggested"].map((x) => MedicinesSuggested.fromJson(x))),
        exercisesSuggested: json["exercisesSuggested"] == null ? null : List<dynamic>.from(json["exercisesSuggested"].map((x) => x)),
        appointment: json["appointment"] == null ? null : NewPrescriptionAppointment.fromJson(json["appointment"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "date": date == null ? null : date,
        "symptoms": symptoms == null ? null : List<dynamic>.from(symptoms.map((x) => x.toJson())),
        "tests": tests == null ? null : List<dynamic>.from(tests.map((x) => x.toJson())),
        "foodsSuggested": foodsSuggested == null ? null : List<dynamic>.from(foodsSuggested.map((x) => x)),
        "medicinesSuggested": medicinesSuggested == null ? null : List<dynamic>.from(medicinesSuggested.map((x) => x.toJson())),
        "exercisesSuggested": exercisesSuggested == null ? null : List<dynamic>.from(exercisesSuggested.map((x) => x)),
        "appointment": appointment == null ? null : appointment.toJson(),
    };
}

class NewPrescriptionAppointment {
    NewPrescriptionAppointment({
        this.doctorConsent,
        this.patientConsent,
        this.isComplete,
        this.id,
        this.dayOfWeek,
        this.time,
        this.doctor,
        this.patient,
    });

    bool doctorConsent;
    bool patientConsent;
    bool isComplete;
    String id;
    String dayOfWeek;
    String time;
    FluffyDoctor doctor;
    AppointmentPatient patient;

    factory NewPrescriptionAppointment.fromJson(Map<String, dynamic> json) => NewPrescriptionAppointment(
        doctorConsent: json["doctorConsent"] == null ? null : json["doctorConsent"],
        patientConsent: json["patientConsent"] == null ? null : json["patientConsent"],
        isComplete: json["isComplete"] == null ? null : json["isComplete"],
        id: json["_id"] == null ? null : json["_id"],
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        time: json["time"] == null ? null : json["time"],
        doctor: json["doctor"] == null ? null : FluffyDoctor.fromJson(json["doctor"]),
        patient: json["patient"] == null ? null : AppointmentPatient.fromJson(json["patient"]),
    );

    Map<String, dynamic> toJson() => {
        "doctorConsent": doctorConsent == null ? null : doctorConsent,
        "patientConsent": patientConsent == null ? null : patientConsent,
        "isComplete": isComplete == null ? null : isComplete,
        "_id": id == null ? null : id,
        "dayOfWeek": dayOfWeek == null ? null : dayOfWeek,
        "time": time == null ? null : time,
        "doctor": doctor == null ? null : doctor.toJson(),
        "patient": patient == null ? null : patient.toJson(),
    };
}

class FluffyDoctor {
    FluffyDoctor({
        this.hospitalsName,
        this.hospitalsLocation,
        this.firstName,
        this.lastName,
        this.avatarPath,
        this.degree,
        this.designation,
    });

    String hospitalsName;
    String hospitalsLocation;
    String firstName;
    String lastName;
    String avatarPath;
    String degree;
    Designation designation;

    factory FluffyDoctor.fromJson(Map<String, dynamic> json) => FluffyDoctor(
        hospitalsName: json["hospitalsName"] == null ? null : json["hospitalsName"],
        hospitalsLocation: json["hospitalsLocation"] == null ? null : json["hospitalsLocation"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
        degree: json["degree"] == null ? null : json["degree"],
        designation: json["designation"] == null ? null : Designation.fromJson(json["designation"]),
    );

    Map<String, dynamic> toJson() => {
        "hospitalsName": hospitalsName == null ? null : hospitalsName,
        "hospitalsLocation": hospitalsLocation == null ? null : hospitalsLocation,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatarPath": avatarPath == null ? null : avatarPath,
        "degree": degree == null ? null : degree,
        "designation": designation == null ? null : designation.toJson(),
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

class AppointmentPatient {
    AppointmentPatient({
        this.firstName,
        this.lastName,
        this.avatarPath,
    });

    String firstName;
    String lastName;
    String avatarPath;

    factory AppointmentPatient.fromJson(Map<String, dynamic> json) => AppointmentPatient(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        avatarPath: json["avatarPath"] == null ? null : json["avatarPath"],
    );

    Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "avatarPath": avatarPath == null ? null : avatarPath,
    };
}

class DoctorProfileInfoGetModel {
    DoctorProfileInfoGetModel({
        this.status,
        this.data,
    });

    String status;
    DoctorProfileInfoGetModelData data;

    factory DoctorProfileInfoGetModel.fromJson(Map<String, dynamic> json) => DoctorProfileInfoGetModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : DoctorProfileInfoGetModelData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
    };
}

class DoctorProfileInfoGetModelData {
    DoctorProfileInfoGetModelData({
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
    DataDoctor doctor;
    String bmdcId;
    String degree;
    Designation designation;
    Specialization specialization;
    List<Hospital> hospitals;
    List<Schedule> schedules;
    List<Appoinment> appoinments;

    factory DoctorProfileInfoGetModelData.fromJson(Map<String, dynamic> json) => DoctorProfileInfoGetModelData(
        id: json["_id"] == null ? null : json["_id"],
        doctor: json["doctor"] == null ? null : DataDoctor.fromJson(json["doctor"]),
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
        this.prescriptionId,
    });

    String id;
    String date;
    String time;
    int serialNum;
    bool isComplete;
    String dayOfWeek;
    AppoinmentPatient patient;
    String prescriptionId;

    factory Appoinment.fromJson(Map<String, dynamic> json) => Appoinment(
        id: json["_id"] == null ? null : json["_id"],
        date: json["date"] == null ? null : json["date"],
        time: json["time"] == null ? null : json["time"],
        serialNum: json["serialNum"] == null ? null : json["serialNum"],
        isComplete: json["isComplete"] == null ? null : json["isComplete"],
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        patient: json["patient"] == null ? null : AppoinmentPatient.fromJson(json["patient"]),
        prescriptionId: json["prescriptionID"] == null ? null : json["prescriptionID"],
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
    };
}

class AppoinmentPatient {
    AppoinmentPatient({
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

    factory AppoinmentPatient.fromJson(Map<String, dynamic> json) => AppoinmentPatient(
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

class DataDoctor {
    DataDoctor({
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

    factory DataDoctor.fromJson(Map<String, dynamic> json) => DataDoctor(
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

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
