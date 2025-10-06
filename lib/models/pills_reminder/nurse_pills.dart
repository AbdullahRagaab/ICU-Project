class NursePillsModel {
  int? result;
  List<Data>? data;

  NursePillsModel.fromJson(Map<String, dynamic> json) {
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
  String? doctor;
  String? patient;
  String? name;
  int? quantity;
  String? dosage;
  bool? status;
  String? startDate;
  String? endDate;
  String? created;
  String? updated;
  String? time;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctor = json['doctor'];
    patient = json['patient'];
    name = json['name'];
    quantity = json['quantity'];
    dosage = json['dosage'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    created = json['created'];
    updated = json['updated'];
    time = json['time_clock'];
    
  }
}
