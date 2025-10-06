import '../../../models/auth/forget_password_model.dart';

abstract class ForgetPasswordStates{}

class InitialLoginState extends ForgetPasswordStates {}

class IsPasswordState extends ForgetPasswordStates{}

class IsConfirmPasswordState extends ForgetPasswordStates {}

class ForgetPasswordLoadingState extends ForgetPasswordStates {}

class ForgetPasswordScusessState extends ForgetPasswordStates {
   ForgetPasswordModel forgetPasswordModel ;
  ForgetPasswordScusessState(this.forgetPasswordModel);
}

class ForgetPasswordErrorState extends ForgetPasswordStates {

  final String? error ;

 ForgetPasswordErrorState(this.error);

}
class SubmitCodeLoadingState extends ForgetPasswordStates {}

class SubmitCodeScusessState extends ForgetPasswordStates {
   ForgetPasswordModel forgetPasswordModel ;
  SubmitCodeScusessState(this.forgetPasswordModel);
}

class SubmitCodeErrorState extends ForgetPasswordStates {

  final String? error ;

 SubmitCodeErrorState(this.error);

}

class ChangePasswordLoadingState extends ForgetPasswordStates {}

class ChangePasswordScusessState extends ForgetPasswordStates {
   ForgetPasswordModel forgetPasswordModel ;
  ChangePasswordScusessState(this.forgetPasswordModel);
}

class ChangePasswordErrorState extends ForgetPasswordStates {

  final String? error ;

 ChangePasswordErrorState(this.error);

}
