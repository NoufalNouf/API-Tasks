import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'cartmodel.dart';
class getsinglecart extends StatefulWidget {

  final int id;

  const getsinglecart({super.key , required this.id});

  @override
  State<getsinglecart> createState() => _getsinglecartState();
}

class _getsinglecartState extends State<getsinglecart> {

  Future<GetCarts> fet() async {
    final int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/carts/$id"));
    return
      GetCarts.fromJson(jsonDecode(res.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            FutureBuilder(
                future: fet(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    return ListTile(
                      leading: Text("ID : ${snapshot.data!.id!.toString()}"),
                      title: Text(
                          "USER ID : ${snapshot.data!.userId!.toString()}"),
                      trailing: Text(
                          "DATE : ${snapshot.data!.date!.toString()}"),
                    );
                  }

                  else if (snapshot.hasError) {
                    return
                      Text("Error");
                  }
                  return CircularProgressIndicator();
                }
            ),
          ]
      ),

    );
  }
}