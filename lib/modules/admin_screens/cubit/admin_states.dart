import 'package:icu_project/models/admin/admin_get_data_model.dart';

abstract class AdminStates{}

class InitialAdminState extends AdminStates {}

class AdminLoadingStates  extends AdminStates {}

class AdminScuseesStates  extends AdminStates {

  AdminData? adminData ;

  AdminScuseesStates(this.adminData);

}

class AdminEroorStates  extends AdminStates {
   final String? error ;

  AdminEroorStates(this.error);
}

class AdminUpdateLoadingStates  extends AdminStates {}

class AdminUpdateScuseesStates  extends AdminStates {

  AdminData? adminData ;

  AdminUpdateScuseesStates(this.adminData);

}

class AdminUpdateEroorStates  extends AdminStates {
  
  final String? error ;

  AdminUpdateEroorStates(this.error);
}


class LogoutLoadingState extends AdminStates {}

class LogoutScusessState extends AdminStates {
  // LoginModel loginModel;
  // LoginScusessState(this.loginModel);
}

class LogoutErrorState extends AdminStates {
  final String? error;

  LogoutErrorState(this.error);
}
