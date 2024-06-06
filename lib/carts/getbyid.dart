import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartsmodel.dart';
class getbyid extends StatefulWidget {

  final int id;

  const getbyid({super.key, required this.id});

  @override
  State<getbyid> createState() => _getbyidState();
}

class _getbyidState extends State<getbyid> {

  Future<Products> gt() async{
    int id = widget.id;
    var result = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    return Products.fromJson(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder
            (future: gt(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.description.toString())
                    ],
                  );
                }

                else if (snapshot.hasError){
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
