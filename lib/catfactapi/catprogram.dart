import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'catmodel.dart';

class cat extends StatefulWidget {
  const cat({super.key});

  @override
  State<cat> createState() => _catState();
}

class _catState extends State<cat> {
  
  Future <CatApi> catt() async{
    var res = await http.get(
      Uri.parse("https://catfact.ninja/fact")
    );
    return  CatApi.fromJson(jsonDecode(res.body));
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          FutureBuilder(
              future: catt(),
              builder:(BuildContext context, snapshot){
                if(snapshot.hasData){
                  return
                    Column(
                      children: [
                        Text(snapshot.data!.fact.toString()),
                        Text(snapshot.data!.length.toString()),
                      ],
                    );
                 }

               else if(snapshot.hasError){
                 return
                     Text("${snapshot.error}");
           }

               return CircularProgressIndicator();
           }
          )
        ],
      ),
    );
  }
}


