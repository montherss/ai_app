import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../bloc/home_cubit.dart';
import '../component/component.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = HomeCubit.get(context);
    var imageSearchController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             cubit.allMessageImage.isEmpty? Expanded(child: Center(child: FadeInDown(child: Lottie.asset('assets/lottie/Ai_Image.json')))) :
              // cubit.responseBody?.choices==null?Center(child: Text(""),) : buildRespons(cubit.responseBody! , cubit) ,
              Expanded(
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ListView.separated(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              if(cubit.allMessageImage[index]["role"] == "sender"){
                                return buildSenderImage(cubit.allMessageImage[index] , cubit);
                              }else return buildReseverImage(cubit.allMessageImage[index] , cubit);
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 15,),
                            itemCount: cubit.allMessageImage.length ,
                          )
                        ],
                      )
                  )
              ),
              FadeInDown(
                child: Container(
                  margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
                  ]),
                  child: TextField(
                    controller: imageSearchController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.all(15),
                        hintText: "Write Something .....",
                        suffixIcon: IntrinsicHeight(
                          child: Container(
                            width: 100,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 0.2,
                                  width: 2,
                                ),
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ConditionalBuilder(
                                      condition: state is! HomeGetDataFromApiImageLoading ,
                                      builder: (context) => InkWell(
                                        onTap: () {
                                          if(imageSearchController.text.isEmpty){
                                            showTost("please Write Something ! ", Colors.red);
                                          }else {
                                            cubit.getImage(imageSearchController.text);
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            cubit.saveSenderImageChat(imageSearchController.text);
                                          }
                                        },
                                        child: Icon(
                                          Icons.send,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      fallback: (context) => Center(child:  CircularProgressIndicator(),),
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}


Widget buildSenderImage (Map<dynamic , dynamic> myMap ,HomeCubit cubit)=> FadeInLeft(
  child: Align(
    alignment: AlignmentDirectional.topStart,
    child: InkWell(
      onTap: (){
        cubit.changeVisibleSender();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10).copyWith(topLeft: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
                ]
            ),
            child: Text( "${myMap["message"]}" ,style: GoogleFonts.abel(fontSize: 18 , fontWeight: FontWeight.bold ,color: Colors.white),),
          ),
          cubit.isVisibleSender==true?FadeInLeft(child: Text("${myMap["time"]}" , style: TextStyle( color: Colors.black38 , fontSize: 12),)):SizedBox(),
        ],
      ),
    ),
  ),
);

Widget buildReseverImage (Map<dynamic , dynamic> myMap ,HomeCubit cubit)=>  FadeInRight(
  child: Align(
    alignment: AlignmentDirectional.topEnd,
    child: InkWell(
      onTap: (){
       // cubit.changeVisible() ;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            width: double.infinity,
            height: 500,
            decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10).copyWith(topRight: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
                ]
            ),
            child: CachedNetworkImage(
                imageUrl: myMap["imageUrl"] ,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider ,fit: BoxFit.fill ,
                    ),
                  ),
                ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator(color: Colors.white,),),
              errorWidget: (context, url, error) => Icon(Icons.contact_support),
            )
          ),
          //cubit.isVisible==true?FadeInRight(child: Text("${myMap["time"]}" , style: TextStyle( color: Colors.black38 , fontSize: 12),)):SizedBox(),
        ],
      ),
    ),
  ),
);