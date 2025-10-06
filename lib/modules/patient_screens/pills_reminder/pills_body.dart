// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class PillsReminderBody extends StatefulWidget {
  String? medicineId;
  String? time;
  String? medicineName;
  String? details;
  bool? visable;
  void Function()? onPressed;
  bool isPressed = false;
  bool? showContainer = true;
  PillsReminderBody({
    Key? key,
    this.details,
    this.medicineName,
    this.onPressed,
    this.time,
    this.visable,
    this.medicineId,
    this.showContainer,
  }) : super(key: key);

  @override
  State<PillsReminderBody> createState() => _PillsReminderBodyState();
}

class _PillsReminderBodyState extends State<PillsReminderBody> {
  bool isPressed = false;
  bool showContainer = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PillsCubit, PillsStates>(
      listener: (context, state) {
        if (state is CheckMedicineSucessState) {
          Fluttertoast.showToast(
            msg: PillsCubit.getCubit(context).medicineCheck!.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 25,
            horizontal: 30,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: 340,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F1F1),
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
                        top: 50,
                        start: 20,
                        end: 20,
                      ),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultTextGabriola(
                                  text: widget.medicineName,
                                  fontSize: 30,
                                ),
                                defaultTextSegoe(
                                  text: widget.details,
                                  fontSize: 18,
                                  color: const Color(0XFF6D6A6A),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          IconButton(
                            onPressed: () {
                              if (isPressed) {
                                print('Already token');
                              } else {
                                setState(() {
                                  isPressed = !isPressed;
                                });
                                print('Ok');
                                PillsCubit.getCubit(context).checkMedicine(
                                    medicineId: widget.medicineId);
                              }
                            },
                            icon: Visibility(
                              visible: widget.visable!,
                              child: Image(
                                image: isPressed
                                    ? const AssetImage(
                                        'assets/images/UI-UX-Icons/check-marks/check_mark.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/UI-UX-Icons/check-marks/empty_checked_mark.png',
                                      ),
                                width: 30,
                                height: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 340,
                    height: 46,
                    decoration: const BoxDecoration(
                      color: Colors.white,
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
                        text: widget.time,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
