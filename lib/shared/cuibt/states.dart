abstract class AppStates {}

class InitialState extends AppStates {}

class IsPasswordState extends AppStates {}

class NurseBottomNavigationBarTapState extends AppStates {}

class DoctorBottomNavigationBarTapState extends AppStates {}

class LogoutLoadingState extends AppStates {}

class LogoutScusessState extends AppStates {
  // LoginModel loginModel;
  // LoginScusessState(this.loginModel);
}

class LogoutErrorState extends AppStates {
  final String? error;

  LogoutErrorState(this.error);
}
