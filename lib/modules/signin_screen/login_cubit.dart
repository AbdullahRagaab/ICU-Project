// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/auth/login_model.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());

  static LoginCubit getCubit(context) => BlocProvider.of(context);

  bool isPassword = true;

  void isPasswordShown() {
    isPassword = !isPassword;
    emit(IsPasswordState());
  }

  LoginModel? loginModel;

  void userLogin({
    required String email,
    required String password,
    required String deviceToken,
  }) {
    emit(LoginLoadingState());

    DioHelper.post(
      url: LOGIN,
      requestBody: {
        'username': email,
        'password': password,
        'device_token': deviceToken,
      },
    ).then((value) {
       return value.fold(
      (loginResponse) {
        // Login successful
        loginModel = LoginModel.fromJson(loginResponse);
        print(loginModel!.message);
        print(loginModel!.token);
        emit(LoginScusessState(loginModel!));
      },
      (error) {
        // Login failed
        emit(LoginErrorState('An error occurred. Please try again.'));
      },
    );
      // return value.fold((l) {
      //   loginModel = LoginModel.fromJson(l);
      //   print(loginModel!.message);
      //   print(loginModel!.token);
      //   emit(LoginScusessState(loginModel!));
      // }, (r) => null);
    })
    .catchError((error) {
      emit(LoginErrorState(error.toString()));
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
