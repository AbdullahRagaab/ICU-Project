class NurseAllReports {
  int? result;
  List<Data>? data ;


 NurseAllReports.fromJson(Map<String, dynamic> json){
    result = json['result'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

}

class Data {
   int? id;
   String? title;
   List<Doctor>? doctor;
   String? patient;
   String? created;
   String? updated;


  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    doctor = List.from(json['doctor']).map((e)=>Doctor.fromJson(e)).toList();
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
  
  Doctor.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
  }
}