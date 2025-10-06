// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

import 'get_all_patients_model.dart';

class PatientModel {
  Patient? patient;
  String? message;

  PatientModel({this.patient, this.message});

  PatientModel.fromJson(Map<String, dynamic> json) {
    patient =
    json['patient'] != null ?  Patient.fromJson(json['patient']) : null;
    message = json['message'];
  }
}

class Patient {
  String? id;
  String? name;
  Null? image;
  String? diseaseType;
  int? roomNumber;
  String? address;
  int? natId;
  String? phone;
  String? gender;
  int? age;
  String? status;
  List<Doctor>? doctor;
  List<Nurse>? nurse;

  Patient(
      {this.id,
        this.name,
        this.image,
        this.diseaseType,
        this.roomNumber,
        this.address,
        this.natId,
        this.phone,
        this.gender,
        this.age,
        this.status,
        this.doctor,
        this.nurse});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    diseaseType = json['disease_type'];
    roomNumber = json['room_number'];
    address = json['address'];
    natId = json['nat_id'];
    phone = json['phone'];
    gender = json['gender'];
    age = json['age'];
    status = json['status'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add( Doctor.fromJson(v));
      });
    }
    if (json['nurse'] != null) {
      nurse = <Nurse>[];
      json['nurse'].forEach((v) {
        nurse!.add( Nurse.fromJson(v));
      });
    }
  }

}

class Doctor {
  String? id;
  String? username;
  String? image;
  String? phone;

  Doctor({this.id, this.username, this.image, this.phone});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    image = json['image'];
    phone = json['phone'];
  }

}