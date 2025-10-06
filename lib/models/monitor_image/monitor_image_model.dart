class MonitorImageModel {
  MonitorImageModel({
    required this.results,
    required this.data,
  });
  int? results;
  List<Data>? data;

  MonitorImageModel.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }
}

class Data {
  Data({
    required this.id,
    required this.url,
    required this.created,
  });
  int? id;
  String? url;
  String? created;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    created = json['created'];
  }
}
