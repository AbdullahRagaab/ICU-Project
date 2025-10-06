import 'package:icu_project/models/patient/get_doctor_name_model.dart';

import '../../../models/patient/get_nurse_name_model.dart';

abstract class NurseAndDoctorNameStates{}

class InitialState extends NurseAndDoctorNameStates {}

class DoctorLoadingStates  extends NurseAndDoctorNameStates {}

class DoctorScuseesStates  extends NurseAndDoctorNameStates {

  DoctorNameModel? doctorNameModel ;

  DoctorScuseesStates(this.doctorNameModel);

}

class DoctorErorrStates  extends NurseAndDoctorNameStates {}

class NurseLoadingStates  extends NurseAndDoctorNameStates {}

class NurseScuseesStates  extends NurseAndDoctorNameStates {

  NurseNameModel? nurseNameModel ;

  NurseScuseesStates(this.nurseNameModel);

}

class NurseErorrStates  extends NurseAndDoctorNameStates {}