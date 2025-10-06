class AddXray {
  String? message;

  AddXray.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
