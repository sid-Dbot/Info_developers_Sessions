import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class service with ChangeNotifier {
  Future sendData(info) async {
    return await http.post(Uri.parse("https://reqres.in/api/users"),
        body: jsonEncode(info),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
        });
  }

  // Future<void>_apply()async{
  //       var allData= {
  //         "name" : nameCOntroller.text,
  //         "job" : jobController.text,
  //       };

  //       var res = await OurApi().postData(allData);
  //       var body = jsonDecode(res.body);
  //       if(res.statusCode == 201){

  //       }
}