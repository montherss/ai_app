import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/bloc/main/main_cubit.dart';
import 'package:test1/component/component.dart';
import 'package:test1/models/user.dart';

class HomeScreen extends StatelessWidget {
  final UserHome userHome ;
  const HomeScreen({super.key , required this.userHome});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    cubit.userCubitHome = userHome ;
    return BlocConsumer<MainCubit , MainState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(Icons.light_mode , color: Colors.white,);
            }
            return const Icon(Icons.dark_mode);
          },
        );
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            title: FadeInLeft(
              child: Text("Lathe " , style:GoogleFonts.abel(
                fontSize: 30 ,
                color: Theme.of(context).colorScheme.primary ,
                fontWeight: FontWeight.bold,
              )),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage("${cubit.userCubitHome!.userImage}"),
                ),
              ),
            ],
          ),
          body: cubit.myScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            onTap: (index){
              cubit.changeCurrentIndex(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.person) , label: "Users"),
              BottomNavigationBarItem(icon: Icon(Icons.qr_code_2) , label: "QR"),
              BottomNavigationBarItem(icon: Icon(Icons.settings) , label: "Settings"),
            ],
          ),
        );
      },
    );
  }
}
