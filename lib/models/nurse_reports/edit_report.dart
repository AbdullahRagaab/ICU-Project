class UpdateReport {
  String? message;
  Data? data;

  UpdateReport({this.message, this.data});

  UpdateReport.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? id;
  String? title;
  List<Doctor>? doctor;
  String? patient;
  String? created;
  String? updated;

  

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    if (json['doctor'] != null) {
      doctor = <Doctor>[];
      json['doctor'].forEach((v) {
        doctor!.add(Doctor.fromJson(v));
      });
    }
    patient = json['patient'];
    created = json['created'];
    updated = json['updated'];
  }

}

class Doctor {
  String? id;
  String? name;
  String? phone;
  String? email;

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}
