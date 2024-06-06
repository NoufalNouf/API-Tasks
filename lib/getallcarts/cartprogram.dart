import 'dart:convert';
import 'dart:html';
import 'dart:js_interop_unsafe';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartmodel.dart';
import 'cartpassid.dart';

class getAllCarts extends StatefulWidget {
  const getAllCarts({super.key});

  @override
  State<getAllCarts> createState() => _getAllCartsState();
}

class _getAllCartsState extends State<getAllCarts> {
  
  Future<List<GetCarts>> fetch() async{
    var result = await http.get(Uri.parse("https://fakestoreapi.com/carts"));
    var data = jsonDecode(result.body);
    return
      (data as List).map((e) => GetCarts.fromJson(e)).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<GetCarts> lis = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                            itemCount: lis.length,
                            itemBuilder: (BuildContext context, int index){

                              return GestureDetector(
                                onTap: (){
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>
                                          getsinglecart(id:lis[index].id!,) ));
                                },
                                child: ListTile(
                                  leading: Text("ID : ${lis[index].id!.toString()}"),
                                  title:  Text("USER ID : ${lis[index].userId!.toString()}") ,
                                  trailing:  Text("DATE : ${lis[index].date!.toString()}"),
                                ),
                              );


                              // return  Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //   children: [
                              //     Text("ID : ${lis[index].id!.toString()}"),
                              //     Text("USER ID : ${lis[index].userId!.toString()}"),
                              //     Text("DATE : ${lis[index].date!.toString()}"),
                              //     // Text(lis[index].products!.pr.toString())
                              //   ],
                              // );

                            }
                        ),


                  );
                }
                else if(snapshot.hasError){
                  return
                      Text("Error");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
