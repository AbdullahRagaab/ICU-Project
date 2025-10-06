import '../../models/auth/login_model.dart';

abstract class SignUpStates{}

class InitialSignUpState extends SignUpStates {}

class IsPasswordState extends SignUpStates {}

class IsConfirmPasswordState extends SignUpStates {}


class SignUpLoadingState extends SignUpStates {}

class SignUpScusessState extends SignUpStates {

  LoginModel loginModel ;

  SignUpScusessState(this.loginModel);

}

class SignUpErrorState extends SignUpStates {

  final String? error ;

  SignUpErrorState(this.error);

}
