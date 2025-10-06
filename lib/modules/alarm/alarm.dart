import 'package:flutter/material.dart';
import '../../shared/components/components.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsetsDirectional.all(30),
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0XFF2CBBA9),
              Color(0XFF196A61),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 10),
                child: Row(
                  children: [
                    const Image(
                        image: AssetImage(
                            'assets/images/UI-UX-Icons/alarm/user.png')),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultTextSegoe(
                            text:
                                'Hello, its time to give medicine for patient\nin room 20',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                          defaultTextSegoe(
                            text: 'in room 20',
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 230,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  20,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade400,
                                  blurRadius: 6,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 35, end: 20, bottom: 30),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Image(
                                    image: AssetImage(
                                      'assets/images/UI-UX-Icons/patient-screen/other-icons/pill.png',
                                    ),
                                    width: 30,
                                    height: 30,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        defaultTextGabriola(
                                          text: 'Crocin Advance',
                                          fontSize: 30,
                                        ),
                                        defaultTextSegoe(
                                          text: '10mg , take 2 pills',
                                          fontSize: 18,
                                          color: const Color(0XFF6D6A6A),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 48,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2F1F1),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(
                                  20,
                                ),
                                topRight: Radius.circular(
                                  20,
                                ),
                              ),
                            ),
                            child: Center(
                              child: defaultTextSegoe(
                                text: '08:00 AM',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF2F1F1),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(
                              20,
                            ),
                            bottomRight: Radius.circular(
                              20,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(
                              top: 15,
                              start: 40,
                            ),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/UI-UX-Icons/alarm/skip.png'),
                                      width: 32,
                                      height: 32,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 5,
                                      ),
                                      child: defaultTextSegoe(
                                        text: 'SKIP',
                                        color: const Color(0XFF6D6A6A),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 100),
                                  child: Column(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/images/UI-UX-Icons/alarm/snooze.png'),
                                        width: 30,
                                        height: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                          top: 5,
                                        ),
                                        child: defaultTextSegoe(
                                          text: 'SNOOZE',
                                          color: const Color(0XFF6D6A6A),
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                          'assets/images/UI-UX-Icons/alarm/take.png'),
                                      width: 30,
                                      height: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                        top: 5,
                                      ),
                                      child: defaultTextSegoe(
                                        text: 'TAKE',
                                        color: const Color(0XFF6D6A6A),
                                        fontSize: 15,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
