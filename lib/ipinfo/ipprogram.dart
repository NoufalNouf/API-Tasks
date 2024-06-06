import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ipmodel.dart';

class ipifo extends StatefulWidget {
  const ipifo({super.key});

  @override
  State<ipifo> createState() => _ipifoState();
}

class _ipifoState extends State<ipifo> {

  Future<Ipinfo> fetch() async{
    var res = await http.get(
      Uri.parse("https://ipinfo.io/161.185.160.93/geo")
    );
    
    return Ipinfo.fromJson(jsonDecode(res.body));
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
                  return
                      Column(
                        children: [
                          Text(snapshot.data!.ip.toString()),
                          Text(snapshot.data!.city.toString()),
                          Text(snapshot.data!.region.toString()),
                          Text(snapshot.data!.country.toString()),
                          Text(snapshot.data!.loc.toString()),
                          Text(snapshot.data!.org.toString()),
                          Text(snapshot.data!.postal.toString()),
                          Text(snapshot.data!.timezone.toString()),
                          Text(snapshot.data!.readme.toString()),
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
