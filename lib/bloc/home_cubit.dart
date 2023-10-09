import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:test1/home/screen_1.dart';
import 'package:test1/home/screen_2.dart';
import 'package:test1/http/http_helper.dart';
import 'package:test1/models/Image_Respons.dart';
import 'package:test1/models/responsBody.dart';

import '../models/responsBodyV2.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context)=> BlocProvider.of(context);

  ResponseBodyV2? responseBodyV2 ;
  ResponseBody? responseBody ;
  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = new Random();
  int index = 0;
  List<String> message = [];
  List<String> sender = [] ;
  bool isVisible = false ;
  bool isVisibleSender = false ;
  int currentIndex = 0 ;
  List<Map<String , dynamic>> allMessageImage = [] ;
  void changeVisible (){
   isVisible  = !isVisible;
   emit(HomeChangeTimeVisibale());
  }
  void changeVisibleSender (){
    isVisibleSender  = !isVisibleSender;
    emit(HomeChangeTimeVisibaleSender());
  }
  List<Map<String , dynamic>> allMessage = [] ;
  void saveSenderMessage (String text){
    allMessage.add({
      "message":text,
      "role":"sender",
      "time":DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    });
  }
  void changeColore(){
    index = random.nextInt(3);
    emit(HomeChangeColorRandom());
  }
  void fireBaseTest(String email , String password)async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value){
      print(value.toString());
    }).catchError((onError){
      print(onError.toString());
    });
  }
  void getRespons(String text)async{
    emit(HomeGetDataFromApiLoading());
    await Crud.getDate(text: text).then((value){
      responseBody = ResponseBody.fromJson(value);
      allMessage.add({
        "message":responseBody!.choices![0].message!.content,
        "role":"recever",
        "time":DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      });
      emit(HomeGetDataFromApiSuss());
    }).catchError((onError){
      emit(HomeGetDataFromApiError(onError.toString()));
    });
  }

  void changeScreen (int screen){
    currentIndex = screen ;
    emit(HomeChangeScreen());
  }
  List<Widget> Screen =[
    Screen1(),
    Screen2(),
  ];
  ImageResponse? imageResponse ;
  void saveSenderImageChat(String text){
    allMessageImage.add({
      "message":text,
      "role":"sender",
      "time":DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
    });
  }
  void getImage(String text)async{
    emit(HomeGetDataFromApiImageLoading());
    await Crud.dallEAPI(prompt: text).then((value) {
      imageResponse = ImageResponse.fromJson(value);
      allMessageImage.add({
        "imageUrl":imageResponse!.data![0].url,
        "role":"recever",
        "time":DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()),
      });
      emit(HomeGetDataFromApiImageSuss());
    }).catchError((onError){
      print(onError.toString());
      emit(HomeGetDataFromApiImageError(onError.toString()));
    });
  }
}
