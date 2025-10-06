class MedicineCheck {
  String? message;

  MedicineCheck({this.message});

  MedicineCheck.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

}
