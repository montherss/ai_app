import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class Authentication{
  static final _auth = LocalAuthentication();
  static Future<bool> canAuth() async {
    try{

      return await _auth.canCheckBiometrics;
    }on PlatformException catch (e){
      print("Error $e");
      return false ;
    }

  }
  static Future<bool>auth()async{
   final isAvailable = await canAuth() ;
   try{
     return await _auth.authenticate(
         localizedReason: "Scan FingerPrint",
         options: AuthenticationOptions(
             stickyAuth:true ,
         )
     );
   }on PlatformException catch (e){
     print("Error $e");
     return false ;
   }
  }
}