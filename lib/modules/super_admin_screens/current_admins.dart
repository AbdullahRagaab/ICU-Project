import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_states.dart';
import '../../shared/components/components.dart';
import '../admin_screens/cubit/doctor_cubit.dart';

class CurrentAdminScreen extends StatefulWidget {
  const CurrentAdminScreen({Key? key}) : super(key: key);

  @override
  State<CurrentAdminScreen> createState() => _CurrentAdminScreenState();
}

class _CurrentAdminScreenState extends State<CurrentAdminScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserSignUpCubit>(
      create: (BuildContext context) => UserSignUpCubit()..getActiveAdmins(typeEndpoint: "active_admin"),
      child: BlocConsumer<UserSignUpCubit, UserSignUpStates>(

        listener: (context, state) {
          
        },
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
                text: 'Current Admins',
                fontSize: 35,
              ),
            ),
            body: ConditionalBuilder(
              condition: state is GetActiveAdminScusessState ,
              builder: (context) =>  Padding(
                padding: const EdgeInsetsDirectional.only(
                  top: 40,
                ),
                child: ListView.builder(

                  itemBuilder: (context, index) => currentAndPendingAdminBody(
                    isSelected: false,
                    adminName: UserSignUpCubit.getCubit(context).adminModel?.data?[index].name,
                    suffixIcon: const AssetImage(
                      'assets/images/UI-UX-Icons/check-marks/check_mark.png',
                    ),
                  ),
                  itemCount: UserSignUpCubit.getCubit(context).adminModel!.data!.length,
                ),
              ),
              fallback: (context) => const Center(child: CircularProgressIndicator( color: Color(0XFF196A61))),

            ),
          );
        },
      ),
    );
  }
}
