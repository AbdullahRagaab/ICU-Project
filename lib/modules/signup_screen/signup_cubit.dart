// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/signup_screen/signup_states.dart';
import '../../models/auth/login_model.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(InitialSignUpState());

  static SignUpCubit getCubit(Context) => BlocProvider.of(Context);

  late LoginModel loginModel;

  bool isPassword = true;

  void isPasswordShown() {
    isPassword = !isPassword;
    emit(IsPasswordState());
  }

  bool isConfirmPassword = true;

  void isConfirmPasswordShown() {
    isConfirmPassword = !isConfirmPassword;
    emit(IsConfirmPasswordState());
  }
  
  void userRegister({
    required String email,
    //required String userName,
    required String name,
    required String userName,
    required String phone,
    required String password,
  }) {
    emit(SignUpLoadingState());
    DioHelper.post(
      url: SIGNUP,
      requestBody: {
      'email': email,
      'username': userName,
      'name': name,
      'phone': phone,
      'password': password,
    }
    ).then((value) {
      return value.fold(
      (registerResponse) {
        // Registration successful
        loginModel = LoginModel.fromJson(registerResponse);
        print(loginModel.message);
        emit(SignUpScusessState(loginModel));
      },
      (error) {
        // Registration failed
        emit(SignUpErrorState('An error occurred. Please try again.'));
      },
    );
      // value.fold((l) {
      //   loginModel = LoginModel.fromJson(l);
      //   print(loginModel.message);
      //   emit(SignUpScusessState(loginModel));
      // }, (r) => null);
    }).catchError((error) {
    // Registration failed with an exception or network error
    emit(SignUpErrorState('An error occurred. Please try again.'));
  });
  }
}
