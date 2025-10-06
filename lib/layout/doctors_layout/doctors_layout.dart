import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/cuibt/cubit.dart';
import '../../shared/cuibt/states.dart';

class DoctorsLayout extends StatelessWidget {
  const DoctorsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var getCubit = AppCubit.getCubit(context);
        return Scaffold(
          bottomNavigationBar: SizedBox(
            height: 55,
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: const Color(0XFFDED6D6),
              type: BottomNavigationBarType.fixed,
              currentIndex: getCubit.currentIndex2,
              onTap: (index) {
                getCubit.doctorBottomNavigationBarTap(index);
              },
              items: getCubit.doctorBottomNavigationBarItem,
            ),
          ),
          body: getCubit.doctorScreens[getCubit.currentIndex2],
        );
      },
    );
  }
}
