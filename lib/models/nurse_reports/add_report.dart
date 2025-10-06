class AddReport {
  String? message;


  AddReport.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

 
}
