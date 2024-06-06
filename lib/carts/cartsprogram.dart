import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartsmodel.dart';
import 'getbyid.dart';

class carts extends StatefulWidget {
  const carts({super.key});

  @override
  State<carts> createState() => _cartsState();
}

class _cartsState extends State<carts> {

  Future<List<Products>> fetch() async{
    var result = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(result.body);
    return
      (data as List).map((obj) => Products.fromJson(obj)).toList();
  }

  @override
  Widget build(BuildContext context)


  {
    return Scaffold(

      body: Column(
        children: [
          FutureBuilder<List<Products>>
            (future: fetch(),
              builder: (BuildContext context, snapshot){
            if(snapshot.hasData){
              List<Products> nouf = snapshot.data!;
              return Container(
                height: 800,
                child: ListView.builder(
                    itemCount: nouf.length,
                    itemBuilder: (BuildContext context,  index){
                      return GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => getbyid(id: nouf[index].id!,)));
                        },
                        child: ListTile(
                          title: Text(nouf[index].description.toString()),
                        ),
                      );
                    }
                ),
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
