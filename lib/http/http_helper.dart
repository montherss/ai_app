import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/constant.dart';

Map<String , String> myheaders = {
  'Content-Type':' application/json',
  'Authorization':'Bearer $API_KEY',
} ;
class Crud{
   static Future<Map> getDate({required String text}) async {
    Map<String,dynamic>bodyRequest = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {
          "role": "system",
          "content": "You are a helpful assistant."
        },
        {
          "role": "user",
          "content":'$text'
        }
      ]
    };
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrl);
      http.Response res = await client.post(url,headers: myheaders,body:jsonEncode(bodyRequest));
      if (res.statusCode == 200 || res.statusCode == 201) {
        String cont = jsonDecode(res.body)['choices'][0]['message']['content'];
        cont = cont.trim();
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      throw(e.toString());
    }
  }
   static Future<Map> dallEAPI({required String prompt})async{
    Map<String , dynamic> myBody = {
        "prompt": "$prompt",
        "n": 1,
        "size": "1024x1024"
    };
    try{
      var client = http.Client();
      Uri url = Uri.parse(linkUrlImage);
      http.Response res = await client.post(url,headers: myheaders,body:jsonEncode(myBody));
      if (res.statusCode == 200 || res.statusCode == 201) {
        Map<String , dynamic> respons = jsonDecode(res.body);
        client.close();
        return respons;
      } else {
        throw('Error');
      }
    }catch(e){
      throw(e.toString());
    }
  }
}