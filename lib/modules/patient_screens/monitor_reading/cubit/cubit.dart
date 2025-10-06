// ignore_for_file: non_constant_identifier_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/models/monitor_image/monitor_image_model.dart';
import 'package:icu_project/modules/patient_screens/monitor_reading/cubit/states.dart';

import '../../../../shared/network/remote/dio.dart';

class MonitorReadCubit extends Cubit<MonitorReadStates> {
  MonitorReadCubit() : super(InitailMonitorReadState());

  static MonitorReadCubit getCubit(Context) => BlocProvider.of(Context);



  MonitorImageModel? monitorImageModel;

  void getMonitorRead({
    required String selectedDate,
  }) {
    emit(MonitorReadLoadingState());
    DioHelper.get(
      url: 'medical_test/monitor_images/',
      queryParameters: {'selected_date': selectedDate},
    ).then((value) {
      return value.fold((l) {
         monitorImageModel = MonitorImageModel.fromJson(l);
        emit(MonitorReadSucessState(monitorImageModel!));
      }, (r) => null);
    });
    // .catchError((onError) {
    //   emit(NursePillErrorState(onError));
    // });
  }
}
