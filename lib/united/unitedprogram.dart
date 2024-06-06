import 'dart:convert';

import 'package:api/united/unitedmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class united extends StatefulWidget {
  const united({super.key});

  @override
  State<united> createState() => _unitedState();
}

class _unitedState extends State<united> {

  Future<List<United>> fetch() async{
    var res = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    var data = jsonDecode(res.body);
    print(data);
    return (data as List).map((obj) => United.fromJson(obj)).toList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          FutureBuilder(future: fetch(), 
              builder:(BuildContext context , snapshot){
               if(snapshot.hasData){
                 List<United> a = snapshot.data!;
                 return Container(
                   height: 800,
                   child: ListView.builder(
                       itemCount: a.length,
                       itemBuilder:(BuildContext context, int index){
                         return ListTile(
                           title: Column(
                             children: [
                               
                               Text(a[index].domains.toString()),
                             ],
                           )
                         );
                       }
                   ),
                 );
               }

               else if (snapshot.hasError){
                 return Text("${snapshot.error}");
               }

               return CircularProgressIndicator();

              }
          )

        ],
      ),
    );
  }
}
