// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/admin/admin_get_data_model.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_states.dart';

import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(InitialAdminState());

  static AdminCubit getCubit(Context) => BlocProvider.of(Context);

  AdminData? getAdminData;

  void getAdminProfileData() {
    emit(AdminLoadingStates());

    DioHelper.get(url: GET_ADMIN_DATA).then(
      (value) {
        return value.fold((l) {
          getAdminData = AdminData.fromJson(l);
          emit(AdminScuseesStates(getAdminData!));
        }, (r) => null);
      },
    )
    .catchError((error) {
      print(error.toString());
      emit(AdminEroorStates(error.toString()));
    });
  }

   void updateAdminData({
    required String name,
    required String phone,
    required String email,

  }){
     emit(AdminUpdateLoadingStates());

    DioHelper.put(url: UPDATE_ADMIN_DATA ,requestBody: {
      'name' : name ,
      'phone' : phone ,
      'email' : email ,
      
    }).then(
      (value) {
        return value.fold((l) {
          getAdminData = AdminData.fromJson(l);
          emit(AdminUpdateScuseesStates(getAdminData!));
        }, (r) => null);
      },
    )
    .catchError((error) {
      print(error.toString());
      emit(AdminUpdateEroorStates(error.toString()));
    });
  }

  void userLogout() {
    emit(LogoutLoadingState());
    DioHelper.post(
      url: LOGOUT,
    ).then((value) {
      return value.fold((l) {
        emit(LogoutScusessState());
      }, (r) => null);
    });
  }
}
