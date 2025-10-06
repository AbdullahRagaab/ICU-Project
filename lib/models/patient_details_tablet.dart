// ignore_for_file: camel_case_types

import 'package:icu_project/models/notifcation/get_notification_details_model.dart';

class patientDetailsModel {
  List<Data>? data;

  patientDetailsModel({this.data});

  patientDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  UserSender? userSender;
  List<UserReceiver>? userReceiver;
  Patient? patient;
  bool? status;
  String? message;
  String? title;
  String? created;
  String? updated;

  Data(
      {this.id,
        this.userSender,
        this.userReceiver,
        this.patient,
        this.status,
        this.message,
        this.title,
        this.created,
        this.updated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userSender = json['user_sender'] != null
        ? UserSender.fromJson(json['user_sender'])
        : null;
    if (json['user_receiver'] != null) {
      userReceiver = <UserReceiver>[];
      json['user_receiver'].forEach((v) {
        userReceiver!.add(UserReceiver.fromJson(v));
      });
    }
    patient =
    json['patient'] != null ? Patient.fromJson(json['patient']) : null;
    status = json['status'];
    message = json['message'];
    title = json['title'];
    created = json['created'];
    updated = json['updated'];
  }
}

class UserSender {
  String? id;
  String? role;
  String? name;

  UserSender({this.id, this.role, this.name});

  UserSender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
  }
}

class Patient {
  String? id;
  String? name;
  String? diseaseType;
  int? roomNumber;
  String? status;

  Patient({this.id, this.name, this.diseaseType, this.roomNumber, this.status});

  Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    diseaseType = json['disease_type'];
    roomNumber = json['room_number'];
    status = json['status'];
  }

}