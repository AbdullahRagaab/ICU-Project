import 'package:icu_project/models/pills_reminder/doctor_pills.dart';
import 'package:icu_project/models/pills_reminder/medicine_check.dart';
import '../../../../models/pills_reminder/nurse_pills.dart';

abstract class PillsStates {}

class InitailDoctorPillState extends PillsStates {}

class DoctorPillLoadingState extends PillsStates {}

class DoctorPillSucessState extends PillsStates {
  DoctorPillsModel doctorPills;
  DoctorPillSucessState(this.doctorPills);
}

class DoctorPillErrorState extends PillsStates {
  String error;
  DoctorPillErrorState(this.error);
}

class NursePillLoadingState extends PillsStates {}

class NursePillSucessState extends PillsStates {
  NursePillsModel nursePills;
  NursePillSucessState(this.nursePills);
}

class NursePillErrorState extends PillsStates {
  String error;
  NursePillErrorState(this.error);
}

class CheckMedicineLoadingState extends PillsStates {}

class CheckMedicineSucessState extends PillsStates {
  MedicineCheck medicineCheck;
  CheckMedicineSucessState(this.medicineCheck);
}

class CheckMedicineErrorState extends PillsStates {
  String error;
  CheckMedicineErrorState(this.error);
}
