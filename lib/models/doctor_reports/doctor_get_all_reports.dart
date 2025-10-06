class DoctorAllReports {
  int? result;
  List<Data>? data;

  DoctorAllReports.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  int? id;
  String? title;
  List<Nurse>? nurse;
  String? patient;
  String? created;
  String? updated;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    nurse = List.from(json['nurse']).map((e) => Nurse.fromJson(e)).toList();
    patient = json['patient'];
    created = json['created'];
    updated = json['updated'];
  }
}

class Nurse {
  String? id;
  String? name;
  String? phone;
  String? email;

  Nurse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}
