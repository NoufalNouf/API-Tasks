import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'coindeskmode.dart';

class coin extends StatefulWidget {
  const coin({super.key});

  @override
  State<coin> createState() => _coinState();
}

class _coinState extends State<coin> {
  
  
  Future<Coindesk> desk() async{
    var res = await http.get(
      Uri.parse("https://api.coindesk.com/v1/bpi/currentprice.json")
    );
    return Coindesk.fromJson(jsonDecode(res.body));
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          FutureBuilder(
              future: desk(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return
                      Column(
                        children: [
                          Text(snapshot.data!.time!.updated.toString()),
                          Text(snapshot.data!.time!.updatedISO.toString()),
                          Text(snapshot.data!.time!.updateduk.toString()),
                          Text(snapshot.data!.disclaimer.toString()),
                          Text(snapshot.data!.chartName.toString()),
                          Text(snapshot.data!.bpi!.uSD!.code.toString()),
                          Text(snapshot.data!.bpi!.uSD!.symbol.toString()),
                          Text(snapshot.data!.bpi!.uSD!.rate.toString()),
                          Text(snapshot.data!.bpi!.uSD!.description.toString()),
                          Text(snapshot.data!.bpi!.uSD!.rateFloat.toString()),
                          Text(snapshot.data!.bpi!.gBP!.code.toString()),
                          Text(snapshot.data!.bpi!.gBP!.symbol.toString()),
                          Text(snapshot.data!.bpi!.gBP!.rate.toString()),
                          Text(snapshot.data!.bpi!.gBP!.description.toString()),
                          Text(snapshot.data!.bpi!.gBP!.rateFloat.toString()),
                          Text(snapshot.data!.bpi!.eUR!.code.toString()),
                          Text(snapshot.data!.bpi!.eUR!.symbol.toString()),
                          Text(snapshot.data!.bpi!.eUR!.rate.toString()),
                          Text(snapshot.data!.bpi!.eUR!.description.toString()),
                          Text(snapshot.data!.bpi!.eUR!.rateFloat.toString()),
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
