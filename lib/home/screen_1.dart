import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:test1/bloc/home_cubit.dart';
import 'package:test1/component/component.dart';
import 'package:test1/models/responsBody.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    HomeCubit cubit = HomeCubit.get(context);

    //cubit.fireBaseTest("sal_monther@yahoo.com","0781310223");

    return BlocConsumer<HomeCubit , HomeState>(
      listener: (context, state) {
        if(state is HomeGetDataFromApiSuss){
          searchController.text = "";
        }
      },
      builder: (context, state) {

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cubit.allMessage.isEmpty? Expanded(child: Center(child: FadeInDown(child: Lottie.asset('assets/lottie/AI.json')))) :
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
                              if(cubit.allMessage[index]["role"] == "sender"){
                                return buildSender(cubit.allMessage[index] , cubit);
                              }else return buildResever(cubit.allMessage[index] , cubit);
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 15,),
                            itemCount: cubit.allMessage.length ,
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
                    controller: searchController,
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
                                      condition: state is! HomeGetDataFromApiLoading ,
                                      builder: (context) => InkWell(
                                        onTap: () {
                                          if(searchController.text.isEmpty){
                                            showTost("please Write Something ! ", Colors.red);
                                          }else {
                                            cubit.getRespons(searchController.text);
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            cubit.saveSenderMessage(searchController.text);
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

Widget buildRespons(ResponseBody responseBody , HomeCubit cubit){

  return Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.black,
      borderRadius: BorderRadius.circular(10).copyWith(topLeft: Radius.circular(0)),
    ),
    child: Text(responseBody.choices![0].message!.content! , style: GoogleFonts.abel(fontSize: 18 , fontWeight: FontWeight.bold ,color: Colors.white),
    ),
  );
}
Widget buildResever(Map<dynamic , dynamic> myMap , HomeCubit cubit )=> FadeInRight(
  child: Align(
    alignment: AlignmentDirectional.topEnd,
    child: InkWell(
      onTap: (){
        cubit.changeVisible() ;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10).copyWith(topRight: Radius.circular(0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 40, spreadRadius: 0.0)
                ]
            ),
            child: Text("${myMap["message"]}" , style: GoogleFonts.abel(fontSize: 18 , fontWeight: FontWeight.bold ,color: Colors.white),),
          ),
          cubit.isVisible==true?FadeInRight(child: Text("${myMap["time"]}" , style: TextStyle( color: Colors.black38 , fontSize: 12),)):SizedBox(),
        ],
      ),
    ),
  ),
);



Widget buildSender (Map<dynamic , dynamic> myMap ,HomeCubit cubit)=> FadeInLeft(
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