
import '../../../../models/admin/admin_get_data_model.dart';
import '../../../../models/nurse_reports/add_report.dart';
import '../../../../models/nurse_reports/edit_report.dart';
import '../../../../models/nurse_reports/nurse_get_all_reports.dart';

abstract class NurseReports {}

class InitialNurseReportsState extends NurseReports {}

class GetNurseReportsLoadingState extends NurseReports {}

class GetNurseReportsScusessState extends NurseReports {
  NurseAllReports? nurseReportsModel;
  GetNurseReportsScusessState(this.nurseReportsModel);
}

class GetNurseReportsErrorState extends NurseReports {
  final String? error;

  GetNurseReportsErrorState(this.error);
}

class AddReportLoadingState extends NurseReports {}

class AddReportScusessState extends NurseReports {
  AddReport? addReport;
  AddReportScusessState(this.addReport);
}

class AddReportErrorState extends NurseReports {
  final String? error;

  AddReportErrorState(this.error);
}

class UpdateReportLoadingState extends NurseReports {}

class UpdateReportScuseesState extends NurseReports {
  UpdateReport? updateReport;
  UpdateReportScuseesState(this.updateReport);
}

class UpdateReportErrorState extends NurseReports {
  final String? error;

  UpdateReportErrorState(this.error);
}

class DeleteReportLoadingState extends NurseReports {}

class DeleteReportScuseesState extends NurseReports {
  DeleteReportScuseesState();
}

class DeleteReportErrorState extends NurseReports {
  final String? error;

  DeleteReportErrorState(this.error);
}

class SignedInLoadingStates extends NurseReports {}

class SignedInScuseesStates extends NurseReports {
  AdminData? getAdminData;
  SignedInScuseesStates(this.getAdminData);
}

class SignedInEroorStates extends NurseReports {
  final String? error;

  SignedInEroorStates(this.error);
}
