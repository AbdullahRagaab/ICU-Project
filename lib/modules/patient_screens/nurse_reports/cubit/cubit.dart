// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/nurse_reports/cubit/states.dart';
import '../../../../models/admin/admin_get_data_model.dart';
import '../../../../models/nurse_reports/add_report.dart';
import '../../../../models/nurse_reports/edit_report.dart';
import '../../../../models/nurse_reports/nurse_get_all_reports.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio.dart';

class NurseReportsCubit extends Cubit<NurseReports> {
  NurseReportsCubit() : super(InitialNurseReportsState());

  static NurseReportsCubit getCubit(Context) => BlocProvider.of(Context);

  NurseAllReports? nurseReportsModel;

  AddReport? addReport;

  UpdateReport? updateReport;

  void getAllNurseReports({
    required String patientID,
  }) {
    emit(GetNurseReportsLoadingState());

    DioHelper.get(url: 'report/$patientID/$GET_ALL_NURSE_REPORTS').then(
      (value) {
        return value.fold((l) {
          nurseReportsModel = NurseAllReports.fromJson(l);
          emit(GetNurseReportsScusessState(nurseReportsModel!));
        }, (r) => null);
      },
    );
    // .catchError((error) {
    //   print(error.toString());
    //   emit(PatientErrorState(error.toString()));
    // });
  }

  void AddNurseReport({
    required String title,
    required String patientID,
    // required List<String> doctorID
  }) {
    emit(AddReportLoadingState());

    DioHelper.post(url: ADD_REPORT, requestBody: {
      'title': title,
      'patient': patientID,
      // 'doctor': doctorID,
    }).then(
      (value) {
        return value.fold(
          (registerResponse) {
            // Registration successful
            addReport = AddReport.fromJson(registerResponse);
            emit(AddReportScusessState(addReport));
          },
          (error) {
            // Registration failed
            emit(AddReportErrorState('An error occurred. Please try again.'));
          },
        );
      },
    ).catchError((error) {
      print(error.toString());
      emit(AddReportErrorState(error.toString()));
    });
  }
  //     return value.fold((l) {
  //       addReport = AddReport.fromJson(l);
  //       emit(AddReportScusessState(addReport));
  //     }, (r) => null);
  //   });
  // }

  void updateNurseReport(
      {required String title,
      required int id,
      required String patientID,
      required List<String> doctorID}) {
    emit(UpdateReportLoadingState());

    DioHelper.put(url: '$UPDATE_Report$id', requestBody: {
      'title': title,
      'patient': patientID,
      'doctor': doctorID,
    }).then(
      (value) {
        return value.fold(
          (registerResponse) {
            // Registration successful
            updateReport = UpdateReport.fromJson(registerResponse);
            emit(UpdateReportScuseesState(updateReport!));
          },
          (error) {
            // Registration failed
            emit(
                UpdateReportErrorState('An error occurred. Please try again.'));
          },
          // return value.fold((l) {
          //   updateReport = UpdateReport.fromJson(l);
          //   emit(UpdateReportScuseesState(updateReport!));
          // }, (r) => null);
        );
      },
    ).catchError((error) {
      print(error.toString());
      emit(UpdateReportErrorState(error.toString()));
    });
  }

  AdminData? getAdminData;

  void getAdminProfileData() {
    emit(SignedInLoadingStates());

    DioHelper.get(url: GET_ADMIN_DATA).then((value) {
      return value.fold((l) {
        getAdminData = AdminData.fromJson(l);
        emit(SignedInScuseesStates(getAdminData!));
      }, (r) => null);
    });
    //.catchError((error) {
    //   print(error.toString());
    //   emit(SignedInEroorStates(error.toString()));
    // });
  }
}
