import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';
import '../admin_screens/cubit/doctor_states.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSignUpCubit>(
      create: (BuildContext context) =>
          UserSignUpCubit()..getAllMedicines(typeEndpoint: 'medicine/'),
      child: BlocConsumer<UserSignUpCubit, UserSignUpStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              // 1- Icon
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                color: const Color(0XFF2CBBA9),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
              // 2- App Bar Tittle
              title: defaultTextGabriola(
                text: 'Medicines',
                fontSize: 35,
              ),
            ),
            body: ConditionalBuilder(
              condition: state is MedicinesScusessState,
              builder: (context) => Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 40,
                ),
                child: ListView.builder(
                  itemBuilder: (context, index) => medicineScreenComponent(
                    medicineName: UserSignUpCubit.getCubit(context)
                        .medicinesModel!
                        .data![index]
                        .name!,
                  ),
                  itemCount: UserSignUpCubit.getCubit(context)
                      .medicinesModel!
                      .data!
                      .length,
                ),
              ),
              fallback: (context) => const Center(
                  child: CircularProgressIndicator(
                color: Color(0XFF229183),
              )),
            ),
          );
        },
      ),
    );
  }
}
