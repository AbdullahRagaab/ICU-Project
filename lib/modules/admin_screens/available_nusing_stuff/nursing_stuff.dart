// ignore_for_file: must_be_immutable, unused_local_variable, body_might_complete_normally_nullable

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/admin_screens/admin_home/admin_home.dart';
import 'package:icu_project/modules/admin_screens/available_nusing_stuff/add_nurse.dart';
import 'package:icu_project/modules/admin_screens/available_nusing_stuff/nurse_data.dart';
import '../../../shared/components/components.dart';
import '../cubit/doctor_cubit.dart';
import '../cubit/doctor_states.dart';

class AvailableNurseStuffScreen extends StatefulWidget {
  const AvailableNurseStuffScreen({Key? key}) : super(key: key);

  @override
  State<AvailableNurseStuffScreen> createState() =>
      _AvailableNurseStuffScreenState();
}

class _AvailableNurseStuffScreenState extends State<AvailableNurseStuffScreen> {
  var searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    UserSignUpCubit.getCubit(context).getNurses(typeEndpoint: 'nurses');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getCubit = UserSignUpCubit.getCubit(context);

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
                text: 'Nurse Stuff',
                fontSize: 35,
              ),
            ),
            body: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16, end: 16),
              child: Column(
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
                            UserSignUpCubit.getCubit(context).searchNurses(
                                typeEndpoint: 'nurses',
                                search: searchController.text);
                          },
                          submitFunction: (String? value) {
                            searchController.text = value!;
                            UserSignUpCubit.getCubit(context).searchNurses(
                                typeEndpoint: 'nurses',
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
                                  builder: (context) => const AddNurse(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // 2- Making Nurse Profile
                  Expanded(
                    child: ConditionalBuilder(
                      condition: getCubit.nursesModel?.data != null &&
                          state is! NurseStateLoading,
                      builder: (context) => ListView.builder(
                        itemBuilder: (context, index) =>
                            doctorAndNurseContainer(
                          onTapFunction: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NurseDataScreen(
                                    index: index,
                                    id: getCubit.nursesModel?.data?[index].id
                                        .toString() as String,
                                    username: getCubit
                                        .nursesModel?.data?[index].username
                                        .toString() as String,
                                    name: getCubit
                                        .nursesModel?.data?[index].name
                                        .toString() as String,
                                    specialization: getCubit.nursesModel
                                        ?.data?[index].specialization
                                        .toString() as String,
                                    age: getCubit.nursesModel?.data?[index].age
                                        .toString() as String,
                                    address: getCubit
                                        .nursesModel?.data?[index].address
                                        .toString() as String,
                                    gender: getCubit
                                        .nursesModel?.data?[index].gender
                                        .toString() as String,
                                    nat_id: getCubit
                                        .nursesModel?.data?[index].natId
                                        .toString() as String,
                                    phone: getCubit
                                        .nursesModel?.data?[index].phone
                                        .toString() as String,
                                    email: getCubit
                                        .nursesModel?.data?[index].email
                                        .toString() as String,
                                    status: getCubit
                                        .nursesModel?.data?[index].status
                                        .toString() as String,
                                  ),
                                ));
                          },
                          image: getCubit.nursesModel?.data?[index].gender ==
                                      "female" ||
                                  getCubit.nursesModel?.data?[index].gender ==
                                      "Female"
                              ? 'assets/images/UI-UX-Photos/nurse.png'
                              : 'assets/images/UI-UX-Photos/doctor1.png',
                          name: getCubit.nursesModel?.data?[index].name,
                          specialist:
                              getCubit.nursesModel?.data?[index].specialization,
                        ),
                        itemCount: getCubit.nursesModel?.data?.length,
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
