import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'getsingleproducts.dart';
import 'modal.dart';
class getAllProducts extends StatefulWidget {
  const getAllProducts({super.key});

  @override
  State<getAllProducts> createState() => _getAllProductsState();
}

class _getAllProductsState extends State<getAllProducts> {

  Future<List<GetAllProducts>> fetchdata() async {
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((e) => GetAllProducts.fromJson(e)).toList();
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
                  List<GetAllProducts> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                      itemCount: list.length,
                        itemBuilder: (context, int index){
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    getSingleProduct(id: list[index].id!,)));
                          },
                          child: ListTile(
                            leading: Container(
                              height: 600,
                              width: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(list[index].image!),
                                  fit: BoxFit.fill
                                )
                              ),
                            ),
                            title: Column(
                              children: [
                                Text(list[index].id!.toString()),
                                Text(list[index].price!.toString()),
                                Text(list[index].title.toString()),
                                Text(list[index].description!.toString()),
                                Text(list[index].category!.toString()),
                                Text(list[index].rating!.rate.toString()),
                                Text(list[index].rating!.count.toString()),
                              ],
                            ),
                          ),
                        );
                        }
                    ),
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
