class GetActiveAdminModel {
  int? result;
  List<Data>? data;

  GetActiveAdminModel({this.result, this.data});

  GetActiveAdminModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add( Data.fromJson(v));
      });
    }
  }
}

class Data {
  String? id;
  String? email;
  String? name;
  String? phone;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
  }


}
