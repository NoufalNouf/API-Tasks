import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'agifymodel.dart';

class agify extends StatefulWidget {
  const agify({super.key});

  @override
  State<agify> createState() => _agifyState();
}

class _agifyState extends State<agify> {

  Future<Agify> ajee() async{
    var res = await http.get(
      Uri.parse("https://api.agify.io?name=meelad")
    );
    return Agify.fromJson(jsonDecode(res.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          
          FutureBuilder(future: ajee(),
              builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              return
                  Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.age.toString()),
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
