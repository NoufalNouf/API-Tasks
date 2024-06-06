import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'jokemodel.dart';

class joke extends StatefulWidget {
  const joke({super.key});

  @override
  State<joke> createState() => _jokeState();
}

class _jokeState extends State<joke> {

  Future<Joke> fetch() async{
    var res = await http.get(
      Uri.parse("https://official-joke-api.appspot.com/random_joke")
    );
    return
        Joke.fromJson(jsonDecode(res.body));
        
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, noufal){
                if(noufal.hasData){
                  return
                      Column(
                        children: [
                          Text(noufal.data!.type.toString()),
                          Text(noufal.data!.setup.toString()),
                          Text(noufal.data!.punchline.toString()),
                          Text(noufal.data!.id.toString()),
                        ],
                      );
                }

                else if(noufal.hasError){
                  return
                      Text("${noufal.error}");
                }

                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
