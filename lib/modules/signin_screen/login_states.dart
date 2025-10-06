import '../../models/auth/login_model.dart';

abstract class LoginStates{}

class InitialLoginState extends LoginStates {}

class IsPasswordState extends LoginStates{}

class LoginLoadingState extends LoginStates{}


class LoginScusessState extends LoginStates {
   LoginModel loginModel ;
  LoginScusessState(this.loginModel);
}

class LoginErrorState extends LoginStates {

  final String? error ;

 LoginErrorState(this.error);

}

class LogoutLoadingState extends LoginStates {}

class LogoutScusessState extends LoginStates {
  // LoginModel loginModel;
  // LoginScusessState(this.loginModel);
}

class LogoutErrorState extends LoginStates {
  final String? error;

  LogoutErrorState(this.error);
}
