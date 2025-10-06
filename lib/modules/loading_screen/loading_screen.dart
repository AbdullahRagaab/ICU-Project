// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:icu_project/modules/signin_screen/signin_screen.dart';
import 'package:icu_project/shared/network/local/cache_helper.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../shared/components/components.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 1- Making Logo Image Of App
          Container(
            alignment: Alignment.center,
            child: const Image(
              image: AssetImage('assets/images/UI-UX-Photos/welcome-page.png'),
              width: 151,
              height: 190,
            ),
          ),
          // 2- Making Name Of App
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10,
            ),
            child: defaultTextGabriola(
              text: 'Hospital System',
              textAlign: TextAlign.center,
              fontSize: 46,
            ),
          ),
          // 3- Making Linear Progress Bar
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 150,
              start: 20,
              end: 20,
            ),
            child: Container(
              height: 18,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: LinearPercentIndicator(
                onAnimationEnd: () {
                  CacheHelper.saveData(key: 'loading', value: true).then((value) {
                    if (value){
Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                          (route) => false,
                        );
                    }
                  });
                },
                animation: true,
                animationDuration: 5000,
                padding: const EdgeInsets.all(0),
                lineHeight: 18,
                barRadius: const Radius.circular(15),
                percent: 1,
                backgroundColor: const Color(0XFFF2F1F1),
                linearStrokeCap: LinearStrokeCap.roundAll,
                linearGradient: const LinearGradient(
                  colors: [
                    Color(0XFF2CBBA9),
                    Color(0XFF196A61),
                  ],
                ),
              ),
            ),
          ),
          // 4- Making Name Of loading
          Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10,
            ),
            child: defaultTextGabriola(
              text: 'Loading...',
              textAlign: TextAlign.center,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }
}
