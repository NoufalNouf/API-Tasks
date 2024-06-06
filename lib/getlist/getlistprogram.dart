import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getlistmodel.dart';

class getlist extends StatefulWidget {
  const getlist({super.key});

  @override
  State<getlist> createState() => _getlistState();
}

class _getlistState extends State<getlist> {

 Future<List<Data>> fetchdata() async {
   var res = await http.get(Uri.parse("https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
   var data = jsonDecode(res.body)["data"];
   return (data as List).map((obj) => Data.fromJson(obj)).toList();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetchdata(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<Data> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount:list.length ,
                        itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            leading: Text(list[index].iDYear.toString()),
                            title: Column(
                              children: [
                                Text(list[index].iDNation.toString()),
                                Text(list[index].population.toString()),
                              ],
                            ),
                          );
                        }
                    ),
                  );
                } else if(snapshot.hasError){
                  return Text("error");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
