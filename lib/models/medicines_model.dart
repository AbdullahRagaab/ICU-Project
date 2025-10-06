class MedicinesModel {
  int? result;
  List<Data>? data;

  MedicinesModel({this.result, this.data});

  MedicinesModel.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? created;
  String? updated;

  Data({this.id, this.name, this.created, this.updated});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    created = json['created'];
    updated = json['updated'];
  }
}