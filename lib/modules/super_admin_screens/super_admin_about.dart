// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/components.dart';
import '../admin_screens/cubit/admin_cubit.dart';
import '../admin_screens/cubit/admin_states.dart';

class SuperAdminAboutScreen extends StatefulWidget {
  const SuperAdminAboutScreen({Key? key}) : super(key: key);

  @override
  State<SuperAdminAboutScreen> createState() => _SuperAdminAboutScreenState();
}

class _SuperAdminAboutScreenState extends State<SuperAdminAboutScreen> {
  var nameController = TextEditingController();

  var rollController = TextEditingController();

  var emailController = TextEditingController();

  @override
  void initState() {
    AdminCubit.getCubit(context).getAdminProfileData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {},
      builder: (context, state) {
    return ConditionalBuilder(
      condition: AdminCubit.getCubit(context).getAdminData != null,
      builder: (context) =>  Scaffold(
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
            text: 'About Me',
            fontSize: 35,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsetsDirectional.only(
            top: 60,
            start: 15,
          ),
          child: Column(
            children: [
              // 1- Name
              defaultAboutMeInformation(
                controller: nameController,
                mainText: 'Name',
                data: AdminCubit.getCubit(context).getAdminData?.data?.name,
              ),
              const SizedBox(
                height: 30,
              ),
              // 2- Roll
              defaultAboutMeInformation(
                controller: rollController,
                mainText: 'Roll',
                data: AdminCubit.getCubit(context).getAdminData?.data?.role,
              ),
              const SizedBox(
                height: 30,
              ),
              // 3- Email
              defaultAboutMeInformation(
                controller: emailController,
                mainText: 'Email',
                data: AdminCubit.getCubit(context).getAdminData?.data?.email,
              ),
              const SizedBox(
                height: 30,
              ),
              // 3- Email
              defaultAboutMeInformation(
                controller: emailController,
                mainText: 'Phone',
                data: AdminCubit.getCubit(context).getAdminData?.data?.phone,
              ),
            ],
          ),
        ),
      ),
      fallback: (context) => const Center(
        child: CircularProgressIndicator(color: Color(0XFF196A61)),
      ),
    );
  },
    );
  }
}