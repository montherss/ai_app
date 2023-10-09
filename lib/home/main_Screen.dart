import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/bloc/home_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Chat-GPT" , style: GoogleFonts.abel(fontSize: 25 , fontWeight: FontWeight.bold ))),
            elevation: 0,
          ),
          body: cubit.Screen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap:(index){
              cubit.changeScreen(index);
            },
            type: BottomNavigationBarType.fixed,
            items: [

              BottomNavigationBarItem(icon: Icon(Icons.chat) , label: "Chat"),
              BottomNavigationBarItem(icon: Icon(Icons.image) , label: "Image Generator"),
            ],
          ),
        );
      },
    );
  }
}
