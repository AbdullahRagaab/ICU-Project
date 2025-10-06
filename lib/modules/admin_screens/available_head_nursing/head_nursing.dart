// ignore_for_file: must_be_immutable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/available_head_nursing/head_nurse_data.dart';
import 'package:icu_project/modules/admin_screens/cubit/doctor_cubit.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_states.dart';
import 'add_head_nurse.dart';

class AvailableHeadNursingScreen extends StatefulWidget {
  const AvailableHeadNursingScreen({Key? key}) : super(key: key);

  @override
  State<AvailableHeadNursingScreen> createState() =>
      _AvailableHeadNursingScreenState();
}

class _AvailableHeadNursingScreenState
    extends State<AvailableHeadNursingScreen> {
  var searchController = TextEditingController();
  FocusNode focusNode = FocusNode();


  @override
  void initState() {
    UserSignUpCubit.getCubit(context).getHeadNursing(typeEndpoint: 'headnursing');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserSignUpCubit, UserSignUpStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = UserSignUpCubit.getCubit(context);

          return Scaffold(
            appBar: AppBar(
              // 1- Icon
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminHomeScreen(),
                    ),
                  );
                },
                color: const Color(0XFF2CBBA9),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 25,
                ),
              ),
              // 2- App Bar Tittle
              title: defaultTextGabriola(
                text: 'Head Nursing',
                fontSize: 35,
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 35,
                      end: 20,
                      top: 20,
                      bottom: 20,
                    ),
                    // 1- Making Search Bar And Add Doctors Icon
                    child: Row(
                      children: [
                        // 1- Search Bar Text Field
                         defaultTextFeild(
                          focusNode: focusNode,
                          width: 290,
                          controller: searchController,
                          type: TextInputType.name,
                          labelText: 'search',
                          borderRaduis: 10,
                          prefix: const AssetImage(
                            'assets/images/UI-UX-Icons/search/search1.png',
                          ),
                          onEditingComplete: () {
                            focusNode.unfocus();
                          },
                          onChangeFunction: (String? value) {
                            // Save the current cursor position
                            final cursorPosition =
                                searchController.selection.baseOffset;

                            // Update the text of the searchController
                            searchController.value = TextEditingValue(
                              text: value!,
                              selection: TextSelection.fromPosition(
                                TextPosition(offset: cursorPosition),
                              ),
                            );
                            UserSignUpCubit.getCubit(context).searchHeadNursing(
                                typeEndpoint: 'headnursing',
                                search: searchController.text);
                          },
                          submitFunction: (String? value) {
                            searchController.text = value!;
                            UserSignUpCubit.getCubit(context).searchHeadNursing(
                                typeEndpoint: 'headnursing',
                                search: searchController.text);
                          },
                        ),
                        // 2- Add Doctors Icon
                        Container(
                          padding: const EdgeInsetsDirectional.only(
                            start: 25,
                          ),
                          child: IconButton(
                            icon: const Image(
                              image: AssetImage(
                                'assets/images/UI-UX-Icons/add-users/add_user.png',
                              ),
                              width: 25,
                              height: 25,
                              opacity: AlwaysStoppedAnimation(
                                0.7,
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AddHeadNurse(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2- Making Doctor Profile
                  Expanded(
                    child: ConditionalBuilder(
                      condition: getCubit.headNursingModel?.data != null,
                      builder: (context) => ListView.builder(
                        itemBuilder: (context, index) =>
                            doctorAndNurseContainer(
                          onTapFunction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HeadNurseDataScreen(
                                    index: index,
                                    nat_id: getCubit
                                        .headNursingModel?.data?[index].natId,
                                    specialization: getCubit.headNursingModel
                                        ?.data?[index].specialization,
                                    name: getCubit
                                        .headNursingModel?.data?[index].name,
                                    email: getCubit
                                        .headNursingModel?.data?[index].email,
                                    address: getCubit
                                        .headNursingModel?.data?[index].address,
                                    age:
                                        getCubit.headNursingModel?.data?[index].age,
                                    gender: getCubit
                                        .headNursingModel?.data?[index].gender,
                                    phone: getCubit
                                        .headNursingModel?.data?[index].phone,
                                    status: getCubit
                                        .headNursingModel?.data?[index].status,
                                    id: getCubit.headNursingModel?.data?[index].id,
                                    username: getCubit
                                        .headNursingModel?.data?[index].username,
                                  ),
                                ));
                          },
                          image: getCubit.headNursingModel?.data?[index].gender ==
                                  "female"
                              ? 'assets/images/UI-UX-Photos/nurse.png'
                              : 'assets/images/UI-UX-Photos/doctor1.png',
                          name: getCubit.headNursingModel?.data?[index].name,
                          specialist: "Head Nurse",
                        ),
                        itemCount: getCubit.headNursingModel?.data?.length,
                      ),
                      fallback: (context) => const Center(
                        child:
                            CircularProgressIndicator(color: Color(0XFF196A61)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
