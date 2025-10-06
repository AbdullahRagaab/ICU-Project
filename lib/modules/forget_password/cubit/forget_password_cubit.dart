// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/auth/forget_password_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio.dart';
import 'forget_password_states.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordStates> {
  ForgetPasswordCubit() : super(InitialLoginState());

  static ForgetPasswordCubit getCubit(context) => BlocProvider.of(context);

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
  ForgetPasswordModel? forgetPasswordModel;

  void userSendCode({
    required String email,
  }) {
    emit(ForgetPasswordLoadingState());
    DioHelper.post(
      url: FORGET,
      requestBody: {
        'email': email,
      },
    ).then((value) {
       return value.fold(
      (loginResponse) {
        // Login successful
        forgetPasswordModel = ForgetPasswordModel.fromJson(loginResponse);
        print(forgetPasswordModel!.message);
        emit(ForgetPasswordScusessState(forgetPasswordModel!));
      },
      (error) {
        // Login failed
        emit(ForgetPasswordErrorState('An error occurred. Please try again.'));
      },
    );
    }).catchError((error) {
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }

  void userSubmitCode({
    required String email,
    required String otp,
  }) {
    emit(SubmitCodeLoadingState());
    DioHelper.post(
      url: VERIFY,
      requestBody: {
        'email': email,
        'otp': otp,
      },
    ).then((value) {
       return value.fold(
       (loginResponse) {
        // Login successful
         forgetPasswordModel = ForgetPasswordModel.fromJson(loginResponse);
        print(forgetPasswordModel!.message);
        emit(SubmitCodeScusessState(forgetPasswordModel!));
      },
      (error) {
        // Login failed
        emit(SubmitCodeErrorState('An error occurred. Please try again.'));
      },
    );
      // return value.fold((l) {
      //   forgetPasswordModel = ForgetPasswordModel.fromJson(l);
      //   print(forgetPasswordModel!.message);
      //   emit(SubmitCodeScusessState(forgetPasswordModel!));
      // }, (r) => null);
    })
    .catchError((error) {
      emit(SubmitCodeErrorState(error.toString()));
    });
  }

  void userChangePassword({
    required String email,
    required String password,
  }) {
    emit(ChangePasswordLoadingState());
    DioHelper.post(
      url: CHANGE_PASSWORD,
      requestBody: {
        'email': email,
        'password': password,
      },
    ).then((value) {
       return value.fold(
      (loginResponse) {
        // Login successful
         forgetPasswordModel = ForgetPasswordModel.fromJson(loginResponse);
        print(forgetPasswordModel!.message);
        emit(ChangePasswordScusessState(forgetPasswordModel!));
      },
      (error) {
        // Login failed
        emit(ChangePasswordErrorState('An error occurred. Please try again.'));
      },
    );
      // return value.fold((l) {
      //   forgetPasswordModel = ForgetPasswordModel.fromJson(l);
      //   print(forgetPasswordModel!.message);
      //   emit(ChangePasswordScusessState(forgetPasswordModel!));
      // }, (r) => null);
    })
    .catchError((error) {
      emit(ChangePasswordErrorState(error.toString()));
    });
  }
}
