import '../../../../models/add_x_ray/add_xray_model.dart';

abstract class XRayStates {}

class InitialXRayState extends XRayStates {}

class AddXRayLoadingState extends XRayStates {}

class AddXRayScusessState extends XRayStates {
  AddXray addXray;
  AddXRayScusessState(this.addXray);
}

class AddXRayErrorState extends XRayStates {
  String error;
  AddXRayErrorState(this.error);
}


class AddMedicalTestLoadingState extends XRayStates {}

class AddMedicalTestScusessState extends XRayStates {
  AddXray addXray;
  AddMedicalTestScusessState(this.addXray);
}

class AddMedicalTestErrorState extends XRayStates {
  String error;
 AddMedicalTestErrorState(this.error);
}

