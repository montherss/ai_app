import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:test1/bloc/home_cubit.dart';
import 'package:test1/bloc/main/main_cubit.dart';
import 'package:test1/component/component.dart';
import 'package:test1/screen/home_screen.dart';

import '../authentication/authentication.dart';

class WorkPrint extends StatelessWidget {
  const WorkPrint({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
      return BlocConsumer<MainCubit,MainState>(
        listener: (context, state) {
          if(state is MainAddAllUSers){
            showTost("Login Suss", Colors.green);
          }if(state is MainUserAllReadyLogin){
            showTost("You are already logged in", Colors.deepOrange);
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(

              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text("Welcome Back ${cubit.userCubitHome!.userName}" ,style: GoogleFonts.abel(
                        fontSize: 20,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.bold,
                      )),
                    ),
                    Spacer(),

                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                FadeInLeft(
                  duration: Duration(milliseconds: 500),
                  child: Text("Scan QrCode To Login",
                      style: GoogleFonts.abel(
                        fontSize: 20,
                        color: Theme
                            .of(context)
                            .colorScheme
                            .primary,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 20,
                ),
                FadeInLeft(
                    duration: Duration(milliseconds: 800),
                    child: ConditionalBuilder
                      (
                        condition: state is! MainLoginNewUser,
                        builder: (context) => Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 3,
                                color: Theme.of(context).colorScheme.primary
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: QrImageView(
                              backgroundColor:Colors.white,
                              data: "GKZMBbTntkMvkuaOs6sGAW7CT9p1",
                              version: QrVersions.auto,
                              size: 100,
                              gapless: false,
                            ),
                          ),
                        ),
                        fallback: (context) => Center(child: CircularProgressIndicator(),),
                    )
                ),
              ],
            ),
          );
        },
      );
  }
}
