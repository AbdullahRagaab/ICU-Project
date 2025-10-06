class ForgetPasswordModel {
  String? message ;

  ForgetPasswordModel.fromJson(Map<String ,dynamic> json){
    message = json['message'];
  }
}