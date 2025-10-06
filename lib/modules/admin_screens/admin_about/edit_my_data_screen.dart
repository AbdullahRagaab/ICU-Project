// ignore_for_file: must_be_immutable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../shared/components/components.dart';
import '../cubit/admin_cubit.dart';
import '../cubit/admin_states.dart';

class AdminEditMyDataScreen extends StatefulWidget {
  String? name, roll, email, phone;
  AdminEditMyDataScreen(
      {Key? key, this.name, this.roll, this.email, this.phone})
      : super(key: key);

  @override
  State<AdminEditMyDataScreen> createState() => _AdminEditMyDataScreenState();
}

class _AdminEditMyDataScreenState extends State<AdminEditMyDataScreen> {
  var nameController = TextEditingController();
  var rollController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AdminCubit.getCubit(context).getAdminProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is AdminUpdateScuseesStates) {
          AdminCubit.getCubit(context).getAdminProfileData();
          Fluttertoast.showToast(
            msg: "Data Updated Sucessfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black45,
            textColor: Colors.white,
            fontSize: 16.0,
          ).then((value) => Navigator.pop(context));
        }
      },
      builder: (context, state) {
        var getAdminCubit = AdminCubit.getCubit(context);
        if (state is AdminUpdateLoadingStates) {
          nameController.text =
              getAdminCubit.getAdminData?.data?.name.toString() as String;
          rollController.text =
              getAdminCubit.getAdminData?.data?.role.toString() as String;
          emailController.text =
              getAdminCubit.getAdminData?.data?.email.toString() as String;
          phoneController.text =
              getAdminCubit.getAdminData?.data?.phone.toString() as String;
        }
        nameController.text = widget.name!;
        rollController.text = widget.roll!;
        emailController.text = widget.email!;
        phoneController.text = widget.phone!;
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
              text: 'Edit My Data',
              fontSize: 35,
            ),
          ),
          body: ConditionalBuilder(
            condition: state is! AdminLoadingStates,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(color: Color(0XFF196A61)),
            ),
            builder: (context) => Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsetsDirectional.only(
                top: 60,
                start: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // 1- Name
                    defaultAboutMeInformation(
                      controller: nameController,
                      mainText: 'Name',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 2- Roll
                    defaultAboutMeInformation(
                      controller: rollController,
                      mainText: 'Roll',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 3- Email
                    defaultAboutMeInformation(
                      controller: emailController,
                      mainText: 'Email',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // 4- Phone
                    defaultAboutMeInformation(
                      controller: phoneController,
                      mainText: 'Phone',
                      enabled: true,
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                    // 5- Edit Button
                    secondaryDefaultButton(
                      buttonFunction: () {
                        getAdminCubit.updateAdminData(
                          name: nameController.text,
                          phone: phoneController.text,
                          email: emailController.text,
                        );
                      },
                      buttonText: 'Save',
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
