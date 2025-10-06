class LoginModel {
  User? user;
  String? token;
  String? message;

  LoginModel({this.user, this.token, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
  }

}

class User {
  String? id;
  String? email;
  String? username;
  String? name;
  String? phone;
  String ? addedBy;
  String? natId;
   String ? image;
  String? specialization;
  String? role;
  String? gender;
  String ? age;

  User(
      {this.id,
        this.email,
        this.username,
        this.name,
        this.phone,
        this.addedBy,
        this.natId,
        this.image,
        this.specialization,
        this.role,
        this.gender,
        this.age});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    name = json['name'];
    phone = json['phone'];
    addedBy = json['added_by'];
    natId = json['nat_id'];
    image = json['image'];
    specialization = json['specialization'];
    role = json['role'];
    gender = json['gender'];
    age = json['age'];
  }

}