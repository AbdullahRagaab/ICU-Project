// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, unused_local_variable, unused_element, unnecessary_this, avoid_print, deprecated_member_use, prefer_is_empty

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icu_project/modules/patient_screens/get_x_ray_and_medical_tests/zoom.dart';
import 'package:icu_project/shared/components/global_variables.dart';
import 'package:lottie/lottie.dart';
import '../../../models/get_x_ray/get_x_ray_model.dart';
import '../../../shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class GetXRayScreen extends StatefulWidget {
  const GetXRayScreen({Key? key}) : super(key: key);

  @override
  GetXRayScreenState createState() => GetXRayScreenState();
}

class GetXRayScreenState extends State<GetXRayScreen> {
  @override
  void initState() {
    super.initState();
    GetXRayCubit.getCubit(context).getXrayImages(patientID: patientId!);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetXRayCubit, GetXRayStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var getCubit = GetXRayCubit.getCubit(context);
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
                  text: 'X-Ray And Medical Tests',
                  fontSize: 35,
                ),
              ),
              body: ConditionalBuilder(
                  condition: getCubit.getXrayImageModel?.data != null,
                  fallback: (context) => const Center(
                        child:
                            CircularProgressIndicator(color: Color(0XFF196A61)),
                      ),
                  builder: (context) => getCubit
                              .getXrayImageModel?.data!.length ==
                          0
                      ? Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 150, bottom: 10),
                                child: Lottie.asset(
                                    'assets/images/UI-UX-Photos/77043-search-icon.json',
                                    width: 350,
                                    height: 350),
                              ),
                              defaultTextSegoe(
                                text: 'Not Defined Any XRays',
                                fontSize: 30,
                                color: const Color(0XFF229183),
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: getCubit.getXrayImageModel?.data!.length,
                          itemBuilder: (context, index) {
                            Data? currentData =
                                getCubit.getXrayImageModel?.data![index];
                            int? currentId = currentData!.id;
                            List<String> imageUrls = currentData.imagesUrl!;
                            print(imageUrls.length);
                            return Center(
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                  top: 30,
                                  bottom: 20,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 355,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF2F1F1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(
                                            10,
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
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          // 1- Name and Icon
                                          Padding(
                                            padding: const EdgeInsetsDirectional
                                                .only(
                                              start: 15,
                                              end: 20,
                                              top: 20,
                                            ),
                                            child: Row(
                                              children: [
                                                // 1- Name of X-Ray or Medical Test
                                                Expanded(
                                                  child: defaultTextSegoe(
                                                    text: currentData.name!,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                // Add Image Of X-Ray or Medical Test
                                              ],
                                            ),
                                          ),
                                          // 2- Adding Results
                                          Expanded(
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) =>
                                                  Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 15,
                                                ),
                                                child: Row(
                                                  children:
                                                      imageUrls.map((imageUrl) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (_) =>
                                                                ImageZoomScreen(
                                                                    imageUrl:
                                                                        imageUrl),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .only(right: 10),
                                                        width: 100,
                                                        height: 100,
                                                        child: Image.network(
                                                          imageUrl,
                                                          fit: BoxFit.cover,
                                                          errorBuilder:
                                                              (context, error,
                                                                  stackTrace) {
                                                            return Image
                                                                .network(
                                                              'https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg',
                                                              fit: BoxFit.cover,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              itemCount: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )));
        });
  }
}
