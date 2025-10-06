class SignUpModel {
  String? message;
  num? status;

  UserDataModel? data;

  SignUpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = (json['data'] != null ? UserDataModel.fromJson(json['data']) : null);
  }
}

class UserDataModel {
  String? id;
  String? email;
  String? username;
  String? name;
  String? phone;
  String? addBy;
  String? address;
  String? status;
  double? nationalID;
  String? image;
  String? specialization;
  String? gender;
  String? role;
  String? age;

  UserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    phone = json['phone'];
    addBy = json['added_by'];
    nationalID = json['nat_id'];
    image = json['image'];
    specialization = json['specialization'];
    gender = json['gender'];
    role = json['role'];
    age = json['age'];
    address = json['address'];
    status = json['status'];

    
  }
}
