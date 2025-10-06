// ignore_for_file: file_names

class UpDateModel {
  String? message;
  Data? data;

  UpDateModel({this.message, this.data});

  UpDateModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
   data = json['data'] == null
          ? null : Data.fromJson(json['data']) ;
  }

}

class Data {
  String? id;
  String? email;
  String? username;
  String? name;
  String? phone;
  String? addedBy;
  String? address;
  String? status;
  String? natId;
  String? image;
  String? specialization;
  String? role;
  String? gender;
  String? age;

  Data(
      {this.id,
        this.email,
        this.username,
        this.name,
        this.phone,
        this.addedBy,
        this.address,
        this.status,
        this.natId,
        this.image,
        this.specialization,
        this.role,
        this.gender,
        this.age});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    phone = json['phone'];
    addedBy = json['added_by'];
    address = json['address'];
    status = json['status'];
    natId = json['nat_id'];
    image = json['image'];
    specialization = json['specialization'];
    role = json['role'];
    gender = json['gender'];
    age = json['age'];
  }

}