// ignore_for_file: unnecessary_question_mark, prefer_void_to_null

class PatientUserModel {
  int? result;
  List<Data>? data;

  PatientUserModel({this.result, this.data});

  PatientUserModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
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
  String? phone;
  int? age;
  String? status;
  List<User>? user;


  Data(
      {this.id,
        this.name,
        this.image,
        this.diseaseType,
        this.roomNumber,
        this.address,
        this.phone,
        this.age,
        this.status,
        this.user});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    diseaseType = json['disease_type'];
    roomNumber = json['room_number'];
    address = json['address'];
    phone = json['phone'];
    age = json['age'];
    status = json['status'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add( User.fromJson(v));
      });
    }
  }
}

class User {
  String? id;
  String? name;
  String? phone;
  String? email;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}