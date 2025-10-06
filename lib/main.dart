// ignore_for_file: must_be_immutable, deprecated_member_use, avoid_print, library_prefixes, unused_element, depend_on_referenced_packages
import 'package:icu_project/modules/notification/alarm.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/layout/doctors_layout/doctors_layout.dart';
import 'package:icu_project/layout/nurse_stuff_layout/nurse_stuff_layout.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/cubit/admin_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import 'package:icu_project/modules/admin_screens/cubit/patient_cubit.dart';
import 'package:icu_project/modules/patient_screens/pills_reminder/cubit/cubit.dart';
import 'package:icu_project/modules/signin_screen/signin_screen.dart';
import 'package:icu_project/shared/cuibt/cubit.dart';
import 'package:icu_project/shared/cuibt/observer.dart';
import 'package:icu_project/shared/network/local/cache_helper.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';
import 'modules/loading_screen/loading_screen.dart';
import 'package:icu_project/modules/super_admin_screens/super_admin_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'modules/notification/intialize_notification.dart';
import 'modules/patient_screens/add_x_ray_and_medical_tests/cubit/cubit.dart';
import 'modules/patient_screens/doctor_reports/cubit/cubit.dart';
import 'modules/patient_screens/get_x_ray_and_medical_tests/cubit/cubit.dart';
import 'modules/patient_screens/monitor_reading/cubit/cubit.dart';
import 'modules/patient_screens/nurse_reports/cubit/cubit.dart';
import 'modules/socket/socket.dart';
import 'modules/tablet_app/patient_notification.dart';

Future<void> _firebaseMessagingBackGroungHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.getInitialMessage();
  // Run OnBackground
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackGroungHandler);
  Alarm alarm = Alarm();
  alarm.initInfo();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await FirebaseMessaging.instance.getToken().then(
    (token) {
      PushNotificationScreen.mToken = token;
      print("**************My Token Is ${PushNotificationScreen.mToken}");
      CacheHelper.saveData(key: 'device_token', value: token!);
    },
  );
  SocketData socketData = SocketData();
  socketData.connectToSocket();

  bool? isLoading = CacheHelper.getData(key: 'loading') ?? false;
  Widget? startWidget;
  dynamic token = CacheHelper.getData(key: 'token');
  dynamic deviceToken = CacheHelper.getData(key: 'device_token');
  print('*********************************************************');
  print('My Device Token Is :');
  print(deviceToken);
  print('*********************************************************');

  if (isLoading != null) {
    if (token != null) {
      if (CacheHelper.getData(key: "role") == "superuser" ||
          CacheHelper.getData(key: "role") == "super") {
        startWidget = const SuperAdminHomeScreen();
      } else if (CacheHelper.getData(key: "role") == "admin") {
        startWidget = const AdminHomeScreen();
      } else if (CacheHelper.getData(key: "role") == "nurse") {
        startWidget = const NurseStuffLayout();
      } else if (CacheHelper.getData(key: "role") == "doctor") {
        startWidget = const DoctorsLayout();
      }else if (CacheHelper.getData(key: "role") == "headnursing") {
        startWidget = const NurseDirectorNotificationScreen();
      } else {
        startWidget = SignInScreen();
      }
    } else {
      startWidget = const LoadingScreen();
    }
  }
  runApp(
    ChangeNotifierProvider(
      create: (context) => SocketData(),
      child: MyApp(startWidget),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp(this.startWidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
            create: (BuildContext context) => UserSignUpCubit()
              ..getPatientUser(typeEndpoint: 'patient_user/')),
        BlocProvider(
          create: (BuildContext context) => PatientCubit()
            ..getDoctorName()
            ..getNurseName(),
        ),
        BlocProvider(
          create: (BuildContext context) => AdminCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => NurseReportsCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => DoctorReportsCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => PillsCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => XRayCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => GetXRayCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => MonitorReadCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          return ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, child!),
            maxWidth: 1200,
            minWidth: 450,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
            breakpointsLandscape: [
              const ResponsiveBreakpoint.resize(560, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(812, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1024, name: TABLET),
              const ResponsiveBreakpoint.resize(1120, name: DESKTOP),
            ],
          );
        },
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Color(0XFFF2F1F1),
              statusBarIconBrightness: Brightness.dark,
            ),
            iconTheme: IconThemeData(
              color: Color(0XFF2CBBA9),
            ),
            backgroundColor: Color(0XFFF2F1F1),
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
            actionsIconTheme: IconThemeData(
              color: Colors.black,
            ),
          ),
          // timePickerTheme: const TimePickerThemeData(
          //   dialHandColor: Color(0XFF196A61),
          //   dayPeriodTextColor: Color(0XFF196A61),
          //   hourMinuteTextColor: Color(0XFF196A61),
          //   entryModeIconColor: Color(0XFF196A61),
          // ),
          scaffoldBackgroundColor: const Color(0XFFF2F1F1),
        ),
        home: startWidget,
      ),
    );
  }
}


