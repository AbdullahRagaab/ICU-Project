class AddDoctorMedicine {
  String? message;

  AddDoctorMedicine.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
