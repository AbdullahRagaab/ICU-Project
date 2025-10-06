// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/nurse_screens/nurse_patients.dart';
import 'package:icu_project/shared/cuibt/states.dart';
import '../../modules/doctor_screens/doctor_home.dart';
import '../../modules/doctor_screens/doctor_notifications.dart';
import '../../modules/doctor_screens/doctor_patients.dart';
import '../../modules/nurse_screens/nurse_home.dart';
import '../../modules/nurse_screens/nurse_notifications.dart';
import '../network/end_points.dart';
import '../network/remote/dio.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialState());

  static AppCubit getCubit(Context) => BlocProvider.of(Context);

  bool isPassword = true;

  void isPasswordShown() {
    isPassword = !isPassword;
    emit(IsPasswordState());
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

  int currentIndex1 = 0;

  List<BottomNavigationBarItem> nurseBottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/patients.png',
        ),
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/home.png',
        ),
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/notification.png',
        ),
      ),
      label: '',
    ),
  ];

  List<Widget> nusreScreens = [
    const NursePatientScreen(),
    const NurseHomeScreen(),
    const NurseNotificationScreen(),
  ];

  void nurseBottomNavigationBarTap(int index) {
    currentIndex1 = index;
    emit(NurseBottomNavigationBarTapState());
  }

  int currentIndex2 = 0;

  List<BottomNavigationBarItem> doctorBottomNavigationBarItem = [
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/patients.png',
        ),
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/home.png',
        ),
      ),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Image(
        width: 26,
        height: 26,
        image: AssetImage(
          'assets/images/UI-UX-Icons/bottom-nav-bar/notification.png',
        ),
      ),
      label: '',
    ),
  ];

  List<Widget> doctorScreens = [
    const DoctorPatientScreen(),
    const DoctorHomeScreen(),
    const DoctorNotificationScreen(),
  ];

  void doctorBottomNavigationBarTap(int index) {
    currentIndex2 = index;
    emit(DoctorBottomNavigationBarTapState());
  }
}
