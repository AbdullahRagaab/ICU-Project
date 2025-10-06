// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/pills_reminder/doctor_pills.dart';
import 'package:icu_project/models/pills_reminder/medicine_check.dart';
import 'package:icu_project/modules/patient_screens/pills_reminder/cubit/states.dart';
import 'package:icu_project/shared/network/end_points.dart';
import 'package:icu_project/shared/network/remote/dio.dart';
import '../../../../models/pills_reminder/nurse_pills.dart';

class PillsCubit extends Cubit<PillsStates> {
  PillsCubit() : super(InitailDoctorPillState());

  static PillsCubit getCubit(Context) => BlocProvider.of(Context);

  DoctorPillsModel? doctorPillsModel;

  void getDoctorPills({
    required String patientID,
    required String selectedDate,
  }) {
    emit(DoctorPillLoadingState());
    DioHelper.get(
      url: '$GET_DOCTOR_PIILS/$patientID',
      queryParameters: {'selected_date': selectedDate},
    ).then((value) {
      return value.fold((l) {
        doctorPillsModel = DoctorPillsModel.fromJson(l);
        emit(DoctorPillSucessState(doctorPillsModel!));
      }, (r) => null);
    });
    // .catchError((onError) {
    //   emit(DoctorPillErrorState(onError));
    // });
  }

  NursePillsModel? nursePillsModel;

  void getNursePills({
    required String patientID,
    required String selectedDate,
  }) {
    emit(NursePillLoadingState());
    DioHelper.get(
      url: '$GET_NURSE_PIILS/$patientID',
      queryParameters: {'selected_date': selectedDate},
    ).then((value) {
      return value.fold((l) {
        nursePillsModel = NursePillsModel.fromJson(l);
        emit(NursePillSucessState(nursePillsModel!));
      }, (r) => null);
    });
    // .catchError((onError) {
    //   emit(NursePillErrorState(onError));
    // });
  }

  MedicineCheck? medicineCheck;
  void checkMedicine({String? medicineId}) {
    emit(CheckMedicineLoadingState());
    DioHelper.put(url: CHECK_MEDICINE, requestBody: {
      'medicine_id': medicineId,
    }).then(
      (value) {
        return value.fold((l) {
          medicineCheck = MedicineCheck.fromJson(l);
          emit(CheckMedicineSucessState(medicineCheck!));
        }, (r) => null);
      },
    ).catchError(
      (error) {
        emit(CheckMedicineErrorState(error));
      },
    );
  }
}
