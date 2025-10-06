

import 'package:icu_project/models/doctor_reports/edit_report.dart';

import '../../../../models/admin/admin_get_data_model.dart';
import '../../../../models/doctor_reports/add_medicine.dart';
import '../../../../models/doctor_reports/add_report.dart';
import '../../../../models/doctor_reports/doctor_get_all_reports.dart';
import '../../../../models/medicines_model.dart';

abstract class DoctorReports {}

class InitialDoctorReportsState extends DoctorReports {}

class GetDoctorReportsLoadingState extends DoctorReports {}

class GetDoctorReportsScusessState extends DoctorReports {
  DoctorAllReports? doctorReportsModel;
  GetDoctorReportsScusessState(this.doctorReportsModel);
}

class GetDoctorReportsErrorState extends DoctorReports {
  final String? error;

  GetDoctorReportsErrorState(this.error);
}

class AddDoctorReportLoadingState extends DoctorReports {}

class AddDoctorReportScusessState extends DoctorReports {
  AddDoctorReport? addDoctorReport;
  AddDoctorReportScusessState(this.addDoctorReport);
}

class AddDoctorReportErrorState extends DoctorReports {
  final String? error;

  AddDoctorReportErrorState(this.error);
}

class UpdateDoctorReportLoadingState extends DoctorReports {}

class UpdateDoctorReportScuseesState extends DoctorReports {
  UpdateDoctorReport? updateDoctorReport;
  UpdateDoctorReportScuseesState(this.updateDoctorReport);
}

class UpdateDoctorReportErrorState extends DoctorReports {
  final String? error;

  UpdateDoctorReportErrorState(this.error);
}



class SignedInLoadingStates extends DoctorReports {}

class SignedInScuseesStates extends DoctorReports {
  AdminData? getAdminData;
  SignedInScuseesStates(this.getAdminData);
}

class SignedInEroorStates extends DoctorReports {
  final String? error;

  SignedInEroorStates(this.error);
}


class AddDoctorMedicineLoadingState extends DoctorReports {}

class AddDoctorMedicineScusessState extends DoctorReports {
  AddDoctorMedicine? addDoctorMedicine;
  AddDoctorMedicineScusessState(this.addDoctorMedicine);
}

class AddDoctorMedicineErrorState extends DoctorReports {
  final String? error;

  AddDoctorMedicineErrorState(this.error);
}

class GetMedicinesLoadingState extends DoctorReports {}

class GetMedicinesScusessState extends DoctorReports {
    MedicinesModel? medicinesModel;

  GetMedicinesScusessState(this.medicinesModel);
}
