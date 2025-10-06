class GetMedicalImageModel {
  List<Data>? data;

  GetMedicalImageModel({this.data});

  GetMedicalImageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
}

class Data {
  int? id;
  List<String>? imagesUrl;
  String? name;
  String? patient;

  Data({this.id, this.imagesUrl, this.name, this.patient});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imagesUrl = json['images_url'].cast<String>();
    name = json['name'];
    patient = json['patient'];
  }
}