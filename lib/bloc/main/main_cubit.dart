
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test1/local/shared_pref/cach_helper.dart';
import 'package:test1/models/user.dart';
import 'package:test1/screen/setting.dart';
import 'package:test1/screen/users.dart';
import 'package:test1/screen/work_print.dart';
import 'package:test1/theme/myTheme.dart';

import '../../models/myArriveArray.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());
  static MainCubit get(context) => BlocProvider.of(context);
  int currentIndex = 1;
  bool isDark = isDarkTheme!;
  int daialog = 0 ;
  UserHome? userCubitHome ;
  int dur = 50;
  void changeTheme() {
    isDark = !isDark;
    CacheHepler.setData("isDark", isDark);
    emit(MainChangeTheme());
  }
  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(MainChangeNavBar());
  }
  List<Widget> myScreen = [
    Users(),
    WorkPrint(),
    SettingsScreen(),
  ];
  List<Map<String, dynamic>>myMap = [];
  List<MyArriveArray> myArriveArray = [];
  void loginSussUser(){
    myArriveArray = [] ;
     FirebaseFirestore.instance.collection("GKZMBbTntkMvkuaOs6sGAW7CT9p1").snapshots().listen((event) {
       for (var change in event.docChanges) {
         switch (change.type) {
           case DocumentChangeType.added:
             emit(MainLoginNewUser());
             //print("New Countries: ${change.doc.data()}");
             myArriveArray.add(MyArriveArray.fromJson(change.doc.data()!));
             emit(MainAddAllUSers());
             break;
           case DocumentChangeType.modified:
            // print("Modified Countries: ${change.doc.data()}");
             emit(MainUserAllReadyLogin());
             break;
           case DocumentChangeType.removed:
            // print("Removed Countries: ${change.doc.data()}");
             break;
         }
       }
    });
  }
/* void fireRegsterLisner() async {
    final commentsRef = FirebaseDatabase.instance.ref("users/post");
    commentsRef.onChildAdded.listen((event) {
     print("Hi All");
    });
    commentsRef.onChildChanged.listen((event) {
      print("Has Been Change");
    });
    commentsRef.onChildRemoved.listen((event) {
      print("Has Been Remove");
    });
  }
  void addLogin ()async{
    DatabaseReference postListRef = FirebaseDatabase.instance.ref().child("users");
    DatabaseReference newPostRef = postListRef.push();
    String key = newPostRef.path;
    newPostRef.set({
      "name":"Post For Data",
      "time":"2023-02-23",
      "user_id":"132313213",
      "user_name":"797977979",
    });
  }*/
}