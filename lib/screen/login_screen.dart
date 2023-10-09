import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test1/bloc/login/login_cubit.dart';
import 'package:test1/local/shared_pref/cach_helper.dart';

import '../component/component.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginSuss){
            showTost( "Welcom ${state.user.user!.email}", Colors.green);
            CacheHepler.setData("uId",state.userHome.userId);
            NavegatAndFinish(context , HomeScreen(userHome: state.userHome,));
          }if(state is LoginError){
            showTost( "${state.error}", Colors.red);
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.deepOrange,
                    Colors.deepPurple,
                  ]),
                ),
                child: SafeArea(
                    child: Padding(
                     padding: const EdgeInsets.only(top: 40, left: 25),
                     child: Text(
                    "Hello\nLog in !",
                    style: GoogleFonts.abel(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )),
              ),
              Container(
                margin: EdgeInsets.only(top: 175),
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child:Form(
                    key: formKey ,
                    child:  Column(
                      children: [
                        myTextField(
                          controllers: nameController,
                          perfiexIcon: Icon(Icons.email),
                          text: "Enter Your Email",
                          textStyle: GoogleFonts.abel(
                              color: Colors.grey, fontWeight: FontWeight.bold),
                          textInputType: TextInputType.emailAddress,
                          validation: (value) {
                            if(value==null||value.isEmpty){
                              cubit.changeTrueValue(false);
                              return "Please Enter Your Email !";
                            }
                            cubit.changeTrueValue(true);
                          },
                          sufiexIcon: cubit.isTrueValue?Icon(Icons.check , color: Colors.green,):Icon(Icons.close , color:  Colors.red,),
                          visibielty: false,
                        ),
                        myTextField(
                            controllers: passwordController,
                            perfiexIcon: Icon(Icons.lock),
                            text: "Enter Your Password",
                            textStyle: GoogleFonts.abel(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            textInputType: TextInputType.visiblePassword,
                            validation: (value) {
                              if(value==null||value.isEmpty){
                                return "Please Enter Your Password !";
                              }

                            },
                            visibielty: cubit.isVisible,
                            sufiexIcon: cubit.isVisible
                                ? Icon(Icons.visibility)
                                : Icon(Icons.visibility_off),
                            suffiexIconFunction: () {
                              cubit.changeVisible();
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                "Forget Password ?",
                                style: GoogleFonts.abel(
                                    color:
                                    Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
                                ],
                                gradient: LinearGradient(
                                  colors:[
                                    Colors.deepOrange,
                                    Colors.deepPurple,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: ConditionalBuilder(
                                condition: state is! LoginLoding,
                                builder: (context) =>  MaterialButton(
                                  onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      cubit.signInUSingEmailAndPassword(email: nameController.text, password: passwordController.text);
                                      FocusScope.of(context).unfocus();
                                    }else {
                                    }
                                  },
                                  child: Text(
                                    "login",
                                    style: GoogleFonts.abel(color: Colors.white ,fontWeight: FontWeight.bold , fontSize: 25 ),
                                  ),
                                ),
                                fallback: (context) => Center(child: CircularProgressIndicator(),),
                            )
                          ),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ],
          ));
        },
      ),
    );
  }
}
