import 'package:icu_project/models/active_admin_model.dart';
import 'package:icu_project/models/notifcation/get_noticatin_model.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import '../../../models/admin/admin_get_data_model.dart';
import '../../../models/notifcation_tablet.dart';
import '../../../models/nursedetector.dart';
import '../../../models/notifcation/get_notification_details_model.dart';
import '../../../models/patient/get_all_patients_model.dart';
import '../../../models/patient/get_doctor_name_model.dart';
import '../../../models/patient/get_nurse_name_model.dart';
import '../../../models/patient/patient_model.dart';
import '../../../models/medicines_model.dart';
import '../../../models/patient_details_tablet.dart';
import '../../../models/patient_user_model.dart';
import '../../../models/signup_nurse_doctor/signup_doctor_nurse_model.dart';
import '../../../models/user/doctor_model.dart';
import '../../../models/user/head_nursing_model.dart';
import '../../../models/user/nurses_model.dart';
import '../../../models/user/update_model.dart';

abstract class UserSignUpStates {}

class InitialSignUpState extends UserSignUpStates {}

class IsPasswordState extends UserSignUpStates {}

class LogoutLoadingState extends UserSignUpStates {}

class LogoutScusessState extends UserSignUpStates {
  // LoginModel loginModel;
  // LoginScusessState(this.loginModel);
}

class LogoutErrorState extends UserSignUpStates {
  final String? error;

  LogoutErrorState(this.error);
}
class SignUpLoadingState extends UserSignUpStates {}
class SignUpScusessState extends UserSignUpStates {
  SignUpModel? signUpModel;

  SignUpScusessState(this.signUpModel);
}

class SignUpErrorState extends UserSignUpStates {
  final String? error;

  SignUpErrorState(this.error);
}

class GetActiveAdminScusessState extends UserSignUpStates {
  GetActiveAdminModel? adminModel;

  GetActiveAdminScusessState(this.adminModel);
}

class GetActiveAdminErrorState extends UserSignUpStates {
  final String? error;

  GetActiveAdminErrorState(this.error);
}

class GetActiveAdminLoadingState extends UserSignUpStates {}

class AcceptAdminErrorState extends UserSignUpStates {
  final String? error;

  AcceptAdminErrorState(this.error);
}

class AcceptAdminLoadingState extends UserSignUpStates {}

class AcceptAdminScusessState extends UserSignUpStates {
  AcceptAdminModel? acceptAdminModel;

  AcceptAdminScusessState(this.acceptAdminModel);
}

class AddXrayLoadingState extends UserSignUpStates {}

class AddXrayScusessState extends UserSignUpStates {
  AddMedicalTestModel? addXray;

  AddXrayScusessState(this.addXray);
}

class AddXrayErrorState extends UserSignUpStates {
   final String? error;

  AddXrayErrorState(this.error);
}
class NewsGetSearchLoadingState extends UserSignUpStates {}

class NewsGetSearchSuccessState extends UserSignUpStates {}

class NewsGetSearchErrorState extends UserSignUpStates {
  final String error;

  NewsGetSearchErrorState(this.error);
}

class AddMedicalLoadingState extends UserSignUpStates {}

class AddMedicalScusessState extends UserSignUpStates {
  AddMedicalTestModel? addMedicalTest;

  AddMedicalScusessState(this.addMedicalTest);
}
class AddMedicalErrorState extends UserSignUpStates {
   final String? error;

  AddMedicalErrorState(this.error);
}

class InitialPatientState extends UserSignUpStates {}

class AddPatientStateLoading extends UserSignUpStates {}

class PatientScusessState extends UserSignUpStates {
  PatientModel? patientModel;

  PatientScusessState(this.patientModel);
}

class PatientErrorState extends UserSignUpStates {
  final String? error;

  PatientErrorState(this.error);
}

class InitialMedicinesState extends UserSignUpStates {}

class MedicinesScusessState extends UserSignUpStates {
  MedicinesModel? medicinesModel;

  MedicinesScusessState(this.medicinesModel);
}

class MedicinesErrorState extends UserSignUpStates {
  final String? error;

  MedicinesErrorState(this.error);
}

class MedicinesLoadingState extends UserSignUpStates {}

class PatientLoadingStates extends UserSignUpStates {}

class PatientScusessStates extends UserSignUpStates {
  PatientDataModel patientDataModel;

  PatientScusessStates(this.patientDataModel);
}

class SearchPatientLoadingStates extends UserSignUpStates {}

class SearchPatientScusessStates extends UserSignUpStates {
  PatientDataModel patientDataModel;

  SearchPatientScusessStates(this.patientDataModel);
}

class PatientErrorStates extends UserSignUpStates {}

class IsEnabledState extends UserSignUpStates {}

class PatientUpdateLoadingStates extends UserSignUpStates {}

class PatientUpdateScusessStates extends UserSignUpStates {
  PatientDataModel patientDataModel;

  PatientUpdateScusessStates(this.patientDataModel);
}

class PatientUpdateErrorStates extends UserSignUpStates {}

class InitialNursePatientState extends UserSignUpStates {}

class NursePatientLoading extends UserSignUpStates {}

class NursePatientSucsessState extends UserSignUpStates {
  AdminData? adminData;

  NursePatientSucsessState(this.adminData);
}

class InitialNurseState extends UserSignUpStates {}

class NurseStateLoading extends UserSignUpStates {}

class NurseScusessState extends UserSignUpStates {
  NursesModel? nursesModel;

  NurseScusessState(this.nursesModel);
}

class SearchNurseStateLoading extends UserSignUpStates {}

class SearchNurseScusessState extends UserSignUpStates {
  NursesModel? nursesModel;

  SearchNurseScusessState(this.nursesModel);
}

class HeadNursingStateLoading extends UserSignUpStates {}

class HeadNursingScusessState extends UserSignUpStates {
  HeadNursingModel? headNursingModel;

  HeadNursingScusessState(this.headNursingModel);
}

class SearchHeadNursingStateLoading extends UserSignUpStates {}

class SearchHeadNursingScusessState extends UserSignUpStates {
  HeadNursingModel? headNursingModel;

  SearchHeadNursingScusessState(this.headNursingModel);
}

class SearchDoctorStateLoading extends UserSignUpStates {}

class SearchDoctorScusessState extends UserSignUpStates {
  DoctorsModel? doctorsModel;
  SearchDoctorScusessState(this.doctorsModel);
}

class SearchPatientUserStateLoading extends UserSignUpStates {}

class SearchPatientUserScusessState extends UserSignUpStates {
  PatientUserModel? patientUserModel;
  SearchPatientUserScusessState(this.patientUserModel);
}

class InitialPatientUserState extends UserSignUpStates {}

class PatientUserStateLoading extends UserSignUpStates {}

class PatientUserScusessState extends UserSignUpStates {
  PatientUserModel? patientUserModel;

  PatientUserScusessState(this.patientUserModel);
}

class UpDateState extends UserSignUpStates {}

class UpDateStateLoading extends UserSignUpStates {}

class UpDateScusessState extends UserSignUpStates {
  UpDateModel? upDateModel;

  UpDateScusessState(this.upDateModel);
}

class InitialDoctorState extends UserSignUpStates {}

class DoctorStateLoading extends UserSignUpStates {}

class DoctorScusessState extends UserSignUpStates {
  DoctorsModel? doctorsModel;

  DoctorScusessState(this.doctorsModel);
}

class GetDoctorNameLoadingStates extends UserSignUpStates {}

class GetDoctorNameScusessStates extends UserSignUpStates {
  DoctorNameModel doctorNameModel;

  GetDoctorNameScusessStates(this.doctorNameModel);
}

class GetDoctorNameErrorStates extends UserSignUpStates {}

class GetNurseNameLoadingStates extends UserSignUpStates {}

class GetNurseNameScusessStates extends UserSignUpStates {
  NurseNameModel nurseNameModel;

  GetNurseNameScusessStates(this.nurseNameModel);
}

class GetNurseNameErrorStates extends UserSignUpStates {}

class NurseDataLoadingStates extends UserSignUpStates {}

class NurseDataScuseesStates extends UserSignUpStates {
  AdminData? nurseData;

  NurseDataScuseesStates(this.nurseData);
}

class NurseDataEroorStates extends UserSignUpStates {
  final String? error;

  NurseDataEroorStates(this.error);
}

class GetNotificationLoadingStates extends UserSignUpStates {}

class NurseDetectorDataLoadingStates extends UserSignUpStates {}

class NurseDetectorDataScuseesStates extends UserSignUpStates {
  NursingDetectorModel? nurseDetectorData;

  NurseDetectorDataScuseesStates(this.nurseDetectorData);
}

class NurseDetectorDataEroorStates extends UserSignUpStates {
  final String? error;

  NurseDetectorDataEroorStates(this.error);
}

class GetNotificationScuseesStates extends UserSignUpStates {
  GetNotificationModel? getNotificationModel;

  GetNotificationScuseesStates(this.getNotificationModel);
}

class GetNotificationDetailsLoadingStates extends UserSignUpStates {}

class GetNotificationDetailsScuseesStates extends UserSignUpStates {
  NoticationDetails? noticationDetails;

  GetNotificationDetailsScuseesStates(this.noticationDetails);
}


class GetNotificationDetailsTabletLoadingStates extends UserSignUpStates {}

class GetNotificationDetailsTabletScuseesStates extends UserSignUpStates {
  patientDetailsModel? notificationDetailsTablet;

  GetNotificationDetailsTabletScuseesStates(this.notificationDetailsTablet);
}

class DoctorDataLoadingStates extends UserSignUpStates {}

class GetNotificationTabletLoadingStates extends UserSignUpStates {}

class GetNotificationTabletScuseesStates extends UserSignUpStates {
  GetAllNotificationModel? getNotificationTabletModel;

  GetNotificationTabletScuseesStates(this.getNotificationTabletModel);
}

class DoctorDataScuseesStates extends UserSignUpStates {
  AdminData? doctorData;

  DoctorDataScuseesStates(this.doctorData);
}

class DoctorDataEroorStates extends UserSignUpStates {
  final String? error;

  DoctorDataEroorStates(this.error);
}
