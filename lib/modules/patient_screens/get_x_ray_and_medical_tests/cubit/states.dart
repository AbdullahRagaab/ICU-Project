
import '../../../../models/get_x_ray/get_medical_model.dart';
import '../../../../models/get_x_ray/get_x_ray_model.dart';

abstract class GetXRayStates {}

class InitialGetXRayState extends GetXRayStates {}

class GetXRayLoadingState extends GetXRayStates {}

class GetXRayScusessState extends GetXRayStates {
 GetXrayImageModel getXrayImageModel ;
 GetXRayScusessState(this.getXrayImageModel);
}


class GetMedicalLoadingState extends GetXRayStates {}

class GetMedicalScusessState extends GetXRayStates {
 GetMedicalImageModel getMedicalImageModel ;
 GetMedicalScusessState(this.getMedicalImageModel);
}