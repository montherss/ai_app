import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test1/bloc/home_cubit.dart';
import 'package:test1/bloc/main/main_cubit.dart';
import 'package:test1/component/component.dart';
import 'package:test1/fireBaseApi.dart';
import 'package:test1/local/shared_pref/cach_helper.dart';
import 'package:test1/models/user.dart';
import 'package:test1/screen/home_screen.dart';
import 'package:test1/screen/login_screen.dart';
import 'package:test1/screen/splash_screen.dart';
import 'package:test1/theme/myTheme.dart';
import 'firebase_options.dart';
import 'home/main_Screen.dart';
import 'notification/notification_dart.dart';
import 'package:timezone/data/latest.dart' as tz;



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await CacheHepler.init();
  // requestPermissionNotification();
  // NotificationService().initNotification();
  // fcmConfig();
  // requestPermissionNotification();
  // tz.initializeTimeZones();
   var isDark = CacheHepler.getData(key: "isDark");
  // var uId = CacheHepler.getData(key: "uId");
  // Widget? firstScreen ;
  // UserHome ? userHome ;
  // if(uId == null){
  //   firstScreen = LoginScreen();
  // }else{
  //   await FirebaseFirestore.instance.collection("users").doc(uId).get().then((value){
  //     userHome = UserHome.fromJson(value.data()!);
  //     firstScreen = HomeScreen(userHome: userHome!);
  //   }).catchError((onError){
  //     showTost("${onError.toString()}", Colors.red);
  //   });
  // }
  // if(isDark == null){
  //   isDarkTheme = true ;
  // }else{
  //   isDarkTheme = isDark ;
  // }
  // print(isDarkTheme);
  //

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  //final Widget firstScreen ;
  const MyApp({super.key });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeCubit()),
          //BlocProvider(create: (context) => MainCubit()..loginSussUser()),
        ],
        child:  MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme:  ThemeData(
            colorSchemeSeed:Colors.white ,
            useMaterial3: true,
          ),
          home:SplashScreen(firstScreen: MainScreen()),//TestScreen(),//
        ),
    );
  }
}
