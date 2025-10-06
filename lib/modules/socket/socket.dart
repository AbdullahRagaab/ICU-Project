// ignore_for_file: library_prefixes, unused_import, depend_on_referenced_packages, avoid_print

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketData with ChangeNotifier {
  void connectToSocket() {
    IO.Socket socket = IO.io(
      'https://icu-monitor.onrender.com',
      IO.OptionBuilder()
          .enableAutoConnect()
          .setTransports(['websocket'])
          .setExtraHeaders({'foo': 'bar'})
          .build(),
    );
    socket.connect();
    socket.onConnect((_) {
      print('connect========================================================================');
      socket.emit('icu', 'test');
    });
    socket.on('icu', (data) {
      print(data);

      // Extract values from the data
      ecg = data['ecg'].toString();
      resp = data['resp'].toString();
      spo2 = data['spo2'].toString();
      co2 = data['co2'].toString();
      ibp = data['ibp'].toString();
      nibp = data['nibp'].toString();

      print(ecg);
      print(resp);
      print(spo2);
      print(co2);
      print(ibp);
      print(nibp);

      // Notify listeners of the state change
      notifyListeners();
    });
    socket.onDisconnect((_) => print('disconnect+++++++++++++++++++++++++++++++++++++++++++++++++++'));
    socket.on('fromServer', (_) => print(_));
  }
}



// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final socketData = Provider.of<SocketData>(context);

//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           children: [
//             // 1- First Row
//             Consumer<SocketData>(
//               builder: (context, data, _) {
//                 return Row(
//                   children: [
//                     PatientMonitorReads(
//                       image: const AssetImage(
//                         'assets/images/UI-UX-Icons/patient-screen/monitor-icons/ECG.png',
//                       ),
//                       type: 'ECG',
//                       value: data.ecg.toString(),
//                     ),
//                     const SizedBox(
//                       width: 44,
//                     ),
//                     PatientMonitorReads(
//                       image: const AssetImage(
//                         'assets/images/UI-UX-Icons/patient-screen/monitor-icons/RESP.png',
//                       ),
//                       type: 'RESP',
//                       value: data.resp.toString(),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             // 1- Second Row
//             Consumer<SocketData>(
//               builder: (context, data, _) {
//                 return Row(
//                   children: [
//                     PatientMonitorReads(
//                       image: const AssetImage(
//                         'assets/images/UI-UX-Icons/patient-screen/monitor-icons/SPO2.png',
//                       ),
//                       type: 'SPO2',
//                       value: data.spo2.toString(),
//                     ),
//                     const SizedBox(
//                       width: 44,
//                     ),
//                     PatientMonitorReads(
//                       image: const AssetImage(
//                         'assets/images/UI-UX-Icons/patient-screen/monitor-icons/CO2.png',
//                       ),
//                       type: 'CO2',
//                       value: data.co2.toString(),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }