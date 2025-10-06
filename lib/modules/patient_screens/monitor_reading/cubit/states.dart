
import '../../../../models/monitor_image/monitor_image_model.dart';

abstract class MonitorReadStates {}

class InitailMonitorReadState extends MonitorReadStates {}



class MonitorReadLoadingState extends MonitorReadStates {}

class MonitorReadSucessState extends MonitorReadStates {
  MonitorImageModel monitorImageModel;
  MonitorReadSucessState(this.monitorImageModel);
}

class MonitorReadErrorState extends MonitorReadStates {
  String error;
  MonitorReadErrorState(this.error);
}
