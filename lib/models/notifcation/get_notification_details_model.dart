class NoticationDetails {
  NoticationDetails({
    required this.id,
    required this.userSender,
    required this.userReceiver,
    required this.patient,
    required this.status,
    required this.message,
    required this.title,
    required this.created,
    required this.updated,
  });
   int? id;
   UserSender? userSender;
   List<UserReceiver>? userReceiver;
   Patient? patient;
   bool? status;
   String? message;
   String? title;
   String? created;
   String? updated;
  
  NoticationDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userSender = UserSender.fromJson(json['user_sender']);
    userReceiver = List.from(json['user_receiver']).map((e)=>UserReceiver.fromJson(e)).toList();
    patient = Patient.fromJson(json['patient']);
    status = json['status'];
    message = json['message'];
    title = json['title'];
    created = json['created'];
    updated = json['updated'];
  }
}

class UserSender {
  UserSender({
    required this.id,
    required this.role,
    required this.name,
  });
   String? id;
   String? role;
   String? name;
  
  UserSender.fromJson(Map<String, dynamic> json){
    id = json['id'];
    role = json['role'];
    name = json['name'];
  }

}

class UserReceiver {
  UserReceiver({
    required this.id,
    required this.role,
    required this.name,
  });
   String? id;
   String? role;
   String? name;
  
  UserReceiver.fromJson(Map<String, dynamic> json){
    id = json['id'];
    role = json['role'];
    name = json['name'];
  }

}

class Patient {
  Patient({
    required this.id,
    required this.name,
    required this.diseaseType,
    required this.roomNumber,
    required this.status,
  });
   String? id;
   String? name;
   String? diseaseType;
   int? roomNumber;
   String? status;
  
  Patient.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    diseaseType = json['disease_type'];
    roomNumber = json['room_number'];
    status = json['status'];
  }

}