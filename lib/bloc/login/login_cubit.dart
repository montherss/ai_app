import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test1/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);
  bool isVisible = true;
  bool isTrueValue = true;

  void changeTrueValue(bool isChect) {
    isTrueValue = !isTrueValue;
    emit(LoginChangeChageTrueValue());
  }

  void changeVisible() {
    isVisible = !isVisible;
    emit(LoginChangeVisible());
  }

  UserHome? userHome ;
  void signInUSingEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoding());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async{
          await FirebaseFirestore.instance.collection("users").doc(value.user!.uid).get().then((value2){
            userHome = UserHome.fromJson(value2.data()!);
          }).catchError((onError){
            print(onError.toString());
          });
          emit(LoginSuss(value , userHome!));
    })
        .catchError((onError) {
          print(onError.toString());
          emit(LoginError(onError.toString()));
    });
  }
}
