import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void NavegatTo (context,Widget screen){
  Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
}
void NavegatAndFinish (context,Widget screen){
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => screen , ),(route)=>false);
}

void showTost(@required String msg , @required Color msgColor)=> Fluttertoast.showToast(
    msg:  msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 4,
    backgroundColor: msgColor,
    textColor: Colors.white,
    fontSize: 16.0
);

Widget myTextField({
  required TextEditingController controllers ,
  required Icon perfiexIcon ,
  required String text,
  Widget? sufiexIcon,
  required bool visibielty ,
  TextStyle? textStyle ,
  VoidCallback? suffiexIconFunction ,
  required TextInputType? textInputType ,
  required String? Function(String?)? validation ,

}) =>
    Container(
      margin: EdgeInsets.only(top: 40, left: 20, right: 20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
          ]),
      child: TextFormField(
        validator: validation,
        controller: controllers,
        style:textStyle ,
        obscureText:visibielty ,

        keyboardType: textInputType,
        decoration: InputDecoration(
          errorStyle: TextStyle(
            color: Colors.red
          ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.all(15),
            hintText: text,
            hintStyle: textStyle,
            prefixIcon: perfiexIcon,
            suffixIcon: IntrinsicHeight(
              child: Container(
                  width: 100,
                  child: sufiexIcon!= null ? Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FadeInLeft(
                            child: InkWell(onTap:suffiexIconFunction , child: sufiexIcon )),
                      ),
                    ],
                  ):SizedBox()
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            )),
      ),
    );

