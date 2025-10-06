
// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

import 'patient/get_all_patients_model.dart';

class NursingDetectorModel {
  int? result;
  List<Data>? data;

  NursingDetectorModel({this.result, this.data});

  NursingDetectorModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? id;
  String? name;
  Null? image;
  String? diseaseType;
  int? roomNumber;
  String? address;
  String? natId;
  String? phone;
  String? gender;
  int? age;
  String? status;
  List<Doctor>? doctor;
  List<Nurse>? nurse;

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
        doctor!.add(Doctor.fromJson(v));
      });
    }
    if (json['nurse'] != null) {
      nurse = <Nurse>[];
      json['nurse'].forEach((v) {
        nurse!.add(Nurse.fromJson(v));
      });
    }
  }
}

class Doctor {
  String? id;
  String? name;
  String? phone;
  String? email;

  Doctor({this.id, this.name, this.phone, this.email});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}
