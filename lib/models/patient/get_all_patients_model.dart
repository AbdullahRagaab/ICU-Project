class PatientDataModel {
    int? result;
    List<Data>? data;

  PatientDataModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }data = json['data'] == null
          ? null
          : List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  String? id;
  String? name;
  String? image;
  String? diseaseType;
  int? roomNumber;
  String? address;
  String? nationalId;
  String? phone;
  String? gender;
  int? age;
  String? status;
  List<Doctor>? doctor;
  List<Nurse>? nurse;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    diseaseType = json['disease_type'];
    roomNumber = json['room_number'];
    address = json['address'];
    nationalId = json['nat_id'];
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
  String? username;
  String? image;
  String? phone;

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['name'];
    image = json['image'];
    phone = json['phone'];
  }
}

class Nurse {
  String? id;
  String? username;
  // String? image;
  String? phone;

  Nurse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['name'];
    // image = json['image'];
    phone = json['phone'];
  }
}
