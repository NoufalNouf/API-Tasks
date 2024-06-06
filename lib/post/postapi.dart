import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class postapieg extends StatefulWidget {
  const postapieg({super.key});

  @override
  State<postapieg> createState() => _postapiegState();
}

class _postapiegState extends State<postapieg> {

  Future<bool>? success;
  
  Future<bool> add(String categoryname, String description) async {
    var result = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Category/InsertCategory"),
            headers: <String,String>{
          'Content-Type' : 'application/json; charset=utf-8',

    },
    body:jsonEncode(<String,dynamic>{

      "categoryId": 0,
      "category": categoryname,
      "description": description,
      "createdBy": 1
    })
    );
    return jsonDecode(result.body)['success'];

  } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
