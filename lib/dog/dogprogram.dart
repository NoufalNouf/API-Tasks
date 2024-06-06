import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dogmodel.dart';

class dog extends StatefulWidget {
  const dog({super.key});

  @override
  State<dog> createState() => _dogState();
}

class _dogState extends State<dog> {

  Future<Dog> fetch() async{
    var res = await http.get(
      // Uri.parse("https://dog.ceo/api/breeds/image/random")
      Uri.parse("http://node.noufal.tech/newsfeed/getall")
    );
    return
        Dog.fromJson(jsonDecode(res.body));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(future: fetch(),
              builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              return
                  Column(
                    children: [
                      Container(
                        height: 250,
                        width: 250,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(snapshot.data!.message!)
                      
                          )
                        ),
                      ),
                      Text(snapshot.data!.status.toString())
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
