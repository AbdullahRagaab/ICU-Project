class AdminData {
  Data? data;
  AdminData.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  String? id;
  String? email;
  String? username;
  String? name;
  String? phone;
  String? addedBy;
  String? natId;
  String? image;
  String? specialization;
  String? role;
  String? gender;
  String? age;
  String? address;
  String? status;

  Data.fromJson(Map<String, dynamic> json) {
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
    address = json['address'];
    status = json['status'];
  }
}
