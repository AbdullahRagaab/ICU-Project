class NurseNameModel {
  
 List<Data>? data;
  
  NurseNameModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }


}
class Data {
  String? id;
  String? username;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
  }

}