class AddDoctorReport {
  String? message;

  AddDoctorReport.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
