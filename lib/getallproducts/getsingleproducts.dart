import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modal.dart';
class getSingleProduct extends StatefulWidget {
  final int id;
  const getSingleProduct({super.key, required this.id});

  @override
  State<getSingleProduct> createState() => _getSingleProductState();
}

class _getSingleProductState extends State<getSingleProduct> {

  Future<GetAllProducts> fetch() async {
    int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    return GetAllProducts.fromJson(jsonDecode(res.body));
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
                  return ListTile(
                    title: Column(
                      children: [
                        Text(snapshot.data!.id.toString()),
                        Text(snapshot.data!.price.toString()),
                        Text(snapshot.data!.title.toString()),
                        Text(snapshot.data!.description.toString()),
                        Text(snapshot.data!.category.toString()),
                        Text(snapshot.data!.rating!.rate.toString()),
                        Text(snapshot.data!.rating!.count.toString()),

                        Container(
                          height: 400,
                          width: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot.data!.image!),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),


                      ],
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
