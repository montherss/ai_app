import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../component/component.dart';

class SplashScreen extends StatefulWidget {
  final Widget firstScreen ;
  const SplashScreen({super.key , required this.firstScreen});
  @override
  State<SplashScreen> createState() => _SplashScreenState(firstScreen);
}



class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  final Widget first ;
  _SplashScreenState(this.first);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(Duration(seconds: 3) , (){
      NavegatAndFinish(context, first);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual , overlays: SystemUiOverlay.values);
    super.dispose();

  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: FadeInDown(child: Center(child: Icon(Icons.qr_code_2 , color:Theme.of(context).colorScheme.onPrimary ,size:  150,))),
    );
  }
}
