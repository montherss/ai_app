import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:test1/bloc/home_cubit.dart';
import 'package:test1/bloc/main/main_cubit.dart';
import 'package:test1/models/myArriveArray.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit cubit = MainCubit.get(context);
    return BlocConsumer<MainCubit , MainState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ConditionalBuilder(
                    condition: cubit.myArriveArray.isNotEmpty,
                    builder: (context) => ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) => userBulder(context , cubit.myArriveArray[index] , cubit),
                      separatorBuilder: (context, index) => SizedBox(height: 10,),
                      itemCount: cubit.myArriveArray.length,
                    ),
                    fallback: (context) => Center(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text("There is No User Login Yet !" , style: GoogleFonts.abel(color: Theme.of(context).colorScheme.primary , fontSize: 20 , fontWeight: FontWeight.bold)),
                          Lottie.asset("assets/lottie/empty.json" , repeat: false),
                        ],
                      ),
                    ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget userBulder(BuildContext context , MyArriveArray myArriveArray , MainCubit cubit){
  cubit.dur = cubit.dur+30;
  return Column(
    children: [
      FadeInLeft(
        duration: Duration(milliseconds: cubit.dur),
        child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade600,
                    spreadRadius: 3,
                    blurRadius: 10
                )
              ],
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage("${myArriveArray.userImageUrl}"),
                        radius: 45,
                      ),
                    ) ,
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("Name :- ${myArriveArray.userName}" , maxLines: 1 , overflow: TextOverflow.ellipsis,style: GoogleFonts.abel( fontSize: 18 , fontWeight: FontWeight.bold),)),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: 1.5,
                  color: Theme.of(context).colorScheme.primary,
                ) ,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.watch_later_outlined , color: Colors.grey,),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("${myArriveArray.userLoginTime}" , style: GoogleFonts.abel( fontSize: 15),)
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.calendar_month , color: Colors.grey),
                                SizedBox(
                                  width: 5,
                                ),
                                Text("${myArriveArray.userLoginTime}" , style: GoogleFonts.abel( fontSize: 15),)
                              ],
                            ),
                            Row(
                              children: [
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black45,
                                      radius: 10,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:myArriveArray.userState==1?Colors.green:myArriveArray.userState==2?Colors.yellow:Colors.red,
                                      radius: 9,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                myArriveArray.userState==1?Text("Login Suss", style: GoogleFonts.abel( fontSize: 16),):myArriveArray.userState==2?Text("Departure", style: GoogleFonts.abel( fontSize: 16),):Text("Absence", style: GoogleFonts.abel( fontSize: 16),)
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
        ),
      ),
    ],
  );
}