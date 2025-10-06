// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/active_admin_model.dart';
import 'package:icu_project/models/medicines_model.dart';
import 'package:icu_project/models/notifcation/get_noticatin_model.dart';
import '../../../models/admin/admin_get_data_model.dart';
import '../../../models/notifcation_tablet.dart';
import '../../../models/nursedetector.dart';
import '../../../models/notifcation/get_notification_details_model.dart';
import '../../../models/patient_details_tablet.dart';
import '../../../models/patient_user_model.dart';
import '../../../models/signup_nurse_doctor/signup_doctor_nurse_model.dart';
import '../../../models/user/doctor_model.dart';
import '../../../models/user/head_nursing_model.dart';
import '../../../models/user/nurses_model.dart';
import '../../../models/user/update_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/network/remote/dio.dart';
import 'doctor_states.dart';

class UserSignUpCubit extends Cubit<UserSignUpStates> {
  UserSignUpCubit() : super(InitialSignUpState());

  static UserSignUpCubit getCubit(Context) => BlocProvider.of(Context);

  late SignUpModel signUpModel;

  GetActiveAdminModel? adminModel;

  GetNotificationModel? getNotificationModel;

  NoticationDetails? notificationDetails;

  AcceptAdminModel? acceptAdmin;

  MedicinesModel? medicinesModel;

  AddMedicalTestModel? addMedicalTest;

  AddMedicalTestModel? addXray;

  NursesModel? nursesModel;

  DoctorsModel? doctorsModel;

  HeadNursingModel? headNursingModel;

  UpDateModel? upDateModel;

  PatientUserModel? patientUserModel;

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

  void userRegister({
    required String email,
    //required String userName,
    required String name,
    required String userName,
    required String phone,
    required String password,
    required String nationalID,
    required String gender,
    required String age,
    required String specialization,
    required String role,
    required String status,
    required String address,
  }) {
    emit(SignUpLoadingState());

    DioHelper.post(url: USERSIGNUP, requestBody: {
      'email': email,
      'role': role,
      'username': userName,
      'name': name,
      'phone': phone,
      'password': password,
      'nat_id': nationalID,
      'gender': gender,
      'age': age,
      'specialization': specialization,
      'address': address,
      'status': status,
    }).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          signUpModel = SignUpModel.fromJson(registerResponse);
          print(signUpModel.message);
          emit(SignUpScusessState(signUpModel));
        },
        (error) {
          // Registration failed
          emit(SignUpErrorState('An error occurred. Please try again.'));
        },
      );
      // return value.fold((l) {
      //   signUpModel = SignUpModel.fromJson(l);
      //   print(signUpModel.message);
      //   emit(SignUpScusessState(signUpModel));
      // }, (r) => null);
    }).catchError((error) {
      print(error.toString());
      emit(SignUpErrorState(error.toString()));
    });
  }

  void getActiveAdmins({required String typeEndpoint}) {
    emit(GetActiveAdminLoadingState());
    DioHelper.get(url: typeEndpoint).then((value) {
      return value.fold((l) {
        adminModel = GetActiveAdminModel.fromJson(l);
        emit(GetActiveAdminScusessState(adminModel));
      }, (r) => null);
    });
  }

  void postAcceptAdmin({required String? email}) {
    emit(AcceptAdminLoadingState());
    DioHelper.post(url: "accept_admin", requestBody: {"email": email})
        .then((value) {
      return value.fold((l) {
        acceptAdmin = AcceptAdminModel.fromJson(l);
        emit(AcceptAdminScusessState(acceptAdmin));
      }, (r) => null);
    });
  }

  void getAllNotification() {
    emit(GetNotificationLoadingStates());
    DioHelper.get(url: 'notifications/unread_notification').then((value) {
      return value.fold((l) {
        getNotificationModel = GetNotificationModel.fromJson(l);
        print(getNotificationModel);
        emit(GetNotificationScuseesStates(getNotificationModel));
      }, (r) => null);
    });
  }

  GetAllNotificationModel? getNotificationTabletModel;

  void getAllNotificationTablet() {
    emit(GetNotificationTabletLoadingStates());
    DioHelper.get(url: 'notifications/notifications_head_nursing/')
        .then((value) {
      return value.fold((l) {
        getNotificationTabletModel = GetAllNotificationModel.fromJson(l);
        print(getNotificationTabletModel);
        emit(GetNotificationTabletScuseesStates(getNotificationTabletModel));
      }, (r) => null);
    });
  }

  void getNotificationDetails({int? notifcationID}) {
    emit(GetNotificationDetailsLoadingStates());
    DioHelper.get(url: '$NOTIFICATION_DETAILS$notifcationID').then((value) {
      return value.fold((l) {
        notificationDetails = NoticationDetails.fromJson(l);
        print(notificationDetails);
        emit(GetNotificationDetailsScuseesStates(notificationDetails));
      }, (r) => null);
    });
  }

  patientDetailsModel? notificationDetailsTablet;

  void getNotificationDetailsTablet({int? notificationID}) {
    emit(GetNotificationDetailsTabletLoadingStates());
    DioHelper.get(url: '$NOTIFICATION_DETAILS_TABLET$notificationID')
        .then((value) {
      return value.fold((l) {
        notificationDetailsTablet = patientDetailsModel.fromJson(l);
        print(notificationDetailsTablet);
        emit(GetNotificationDetailsTabletScuseesStates(
            notificationDetailsTablet));
      }, (r) => null);
    });
  }

  void makeNotificationReed({int? idNotification}) {
    DioHelper.put(url: 'notifications/check_notification', requestBody: {
      "notification_id": idNotification,
    }).then((value) {
      // loading state
      return value.fold((l) {
        print(l.toString());
        //   succ
        // getNotificationModel = GetNotificationModel.fromJson(l);
        // print(getNotificationModel);
        emit(GetNotificationScuseesStates(getNotificationModel));
      }, (r) => null);
    });
  }

  void postAddMedicalTest({String? name, required String? patientID}) {
    emit(AddMedicalLoadingState());
    DioHelper.post(
        url: "medical_test/",
        requestBody: {"name": name, "patient": patientID}).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          addMedicalTest = AddMedicalTestModel.fromJson(registerResponse);
          print(addMedicalTest);
          emit(AddMedicalScusessState(addMedicalTest));
        },
        (error) {
          // Registration failed
          emit(AddMedicalErrorState('An error occurred. Please try again.'));
        },
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddMedicalErrorState(error.toString()));
    });
  }
  //     return value.fold((l) {
  //       addMedicalTest = AddMedicalTestModel.fromJson(l);
  //       print(addMedicalTest);
  //       emit(AddMedicalScusessState(addMedicalTest));
  //     }, (r) => null);
  //   });
  // }

  void postAddXray({String? name, required String? patientID}) {
    emit(AddXrayLoadingState());
    DioHelper.post(
        url: "rays/",
        requestBody: {"name": name, "patient": patientID}).then((value) {
      return value.fold(
        (registerResponse) {
          // Registration successful
          addXray = AddMedicalTestModel.fromJson(registerResponse);
          emit(AddXrayScusessState(addXray));
        },
        (error) {
          // Registration failed
          emit(AddXrayErrorState('An error occurred. Please try again.'));
        },
      );
    }).catchError((error) {
      print(error.toString());
      emit(AddXrayErrorState(error.toString()));
    });
  }
  //     return value.fold((l) {
  //       addXray = AddMedicalTestModel.fromJson(l);
  //       emit(AddXrayScusessState(addXray));
  //     }, (r) => null);
  //   });
  // }

  void getAllMedicines({required String typeEndpoint}) {
    emit(MedicinesLoadingState());
    DioHelper.get(
      url: typeEndpoint,
    ).then((value) {
      return value.fold((l) {
        medicinesModel = MedicinesModel.fromJson(l);
        emit(MedicinesScusessState(medicinesModel));
      }, (r) => null);
    });
  }

  bool isEnabled = true;

  void getNurses({required String typeEndpoint}) {
    emit(NurseStateLoading());
    DioHelper.get(
      url: typeEndpoint,
    ).then((value) {
      return value.fold((l) {
        nursesModel = NursesModel.fromJson(l);
        emit(NurseScusessState(nursesModel));
      }, (r) => null);
    });
  }

  void searchNurses({required String typeEndpoint, String? search}) {
    emit(SearchNurseStateLoading());
    DioHelper.get(url: "$typeEndpoint?name=$search", additionalHeaders: {
      'Authorization': 'Token ${CacheHelper.getData(key: "token")}',
    }).then((value) {
      return value.fold((l) {
        nursesModel = NursesModel.fromJson(l);
        emit(SearchNurseScusessState(nursesModel));
      }, (r) => null);
    });
  }

  void getDoctors({required String typeEndpoint}) {
    emit(DoctorStateLoading());
    DioHelper.get(
      url: typeEndpoint,
    ).then((value) {
      return value.fold((l) {
        doctorsModel = DoctorsModel.fromJson(l);
        emit(DoctorScusessState(doctorsModel));
      }, (r) => null);
    });
  }

  void searchDoctors({required String typeEndpoint, String? search}) {
    emit(SearchDoctorStateLoading());
    DioHelper.get(url: "$typeEndpoint?name=$search", additionalHeaders: {
      'Authorization': 'Token ${CacheHelper.getData(key: "token")}',
    }).then((value) {
      return value.fold((l) {
        doctorsModel = DoctorsModel.fromJson(l);
        emit(SearchDoctorScusessState(doctorsModel));
      }, (r) => null);
    });
  }

  void getHeadNursing({required String typeEndpoint}) {
    emit(HeadNursingStateLoading());
    DioHelper.get(
      url: typeEndpoint,
    ).then((value) {
      return value.fold((l) {
        headNursingModel = HeadNursingModel.fromJson(l);
        emit(HeadNursingScusessState(headNursingModel));
      }, (r) => null);
    });
  }

  void searchHeadNursing({required String typeEndpoint, String? search}) {
    emit(SearchHeadNursingStateLoading());
    DioHelper.get(url: "$typeEndpoint?name=$search", additionalHeaders: {
      'Authorization': 'Token ${CacheHelper.getData(key: "token")}',
    }).then((value) {
      return value.fold((l) {
        headNursingModel = HeadNursingModel.fromJson(l);
        emit(SearchHeadNursingScusessState(headNursingModel));
      }, (r) => null);
    });
  }

  void getPatientUser({required String typeEndpoint}) {
    emit(PatientUserStateLoading());
    DioHelper.get(
      url: typeEndpoint,
    ).then((value) {
      return value.fold((l) {
        patientUserModel = PatientUserModel.fromJson(l);
        emit(PatientUserScusessState(patientUserModel));
      }, (r) => null);
    });
  }

  void SearchPatientUser({required String typeEndpoint, String? search}) {
    emit(SearchPatientUserStateLoading());
    DioHelper.get(url: "$typeEndpoint?name=$search", additionalHeaders: {
      'Authorization': 'Token ${CacheHelper.getData(key: "token")}',
    }).then((value) {
      return value.fold((l) {
        patientUserModel = PatientUserModel.fromJson(l);
        emit(SearchPatientUserScusessState(patientUserModel));
      }, (r) => null);
    });
  }

  void updateProfile({
    required String name,
    required String username,
    required String phone,
    required String email,
    required String id,
    required String natId,
    required String specialization,
    required String role,
    required String gender,
    required String age,
    required String address,
    required String status,
  }) {
    emit(UpDateStateLoading());

    DioHelper.put(url: "user/$id", requestBody: {
      'name': name,
      'username': username,
      'phone': phone,
      'email': email,
      'address': address,
      "nat_id": natId,
      "specialization": specialization,
      "role": role,
      "gender": gender,
      "age": age,
      "status": status,
      "id": id,
    }).then(
      (value) {
        return value.fold((l) {
          upDateModel = UpDateModel.fromJson(l);
          emit(UpDateScusessState(upDateModel!));
        }, (r) => null);
      },
    );
  }

  AdminData? getNurseData;

  void getNurseProfileData() {
    emit(NurseDataLoadingStates());

    DioHelper.get(url: GET_ADMIN_DATA).then(
      (value) {
        return value.fold((l) {
          getNurseData = AdminData.fromJson(l);
          emit(NurseDataScuseesStates(getNurseData!));
        }, (r) => null);
      },
    ).catchError((error) {
      print(error.toString());
      emit(NurseDataEroorStates(error.toString()));
    });
  }

  NursingDetectorModel? getNursingDetectorData;

  void getNurseDetectorProfileData() {
    emit(NurseDetectorDataLoadingStates());

    DioHelper.get(url: GET_ALL_PATIENT_TABLET).then(
      (value) {
        return value.fold((l) {
          getNursingDetectorData = NursingDetectorModel.fromJson(l);
          emit(NurseDetectorDataScuseesStates(getNursingDetectorData!));
        }, (r) => null);
      },
    ).catchError((error) {
      print(error.toString());
      emit(NurseDetectorDataEroorStates(error.toString()));
    });
  }

  AdminData? getDoctorData;

  void getDoctorProfileData() {
    emit(DoctorDataLoadingStates());

    DioHelper.get(url: GET_ADMIN_DATA).then(
      (value) {
        return value.fold((l) {
          getDoctorData = AdminData.fromJson(l);
          emit(DoctorDataScuseesStates(getDoctorData!));
        }, (r) => null);
      },
    ).catchError((error) {
      print(error.toString());
      emit(DoctorDataEroorStates(error.toString()));
    });
  }
}

class AcceptAdminModel {
  String? message;

  AcceptAdminModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}

class AddMedicalTestModel {
  String? message;

  AddMedicalTestModel({this.message});

  AddMedicalTestModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }
}
