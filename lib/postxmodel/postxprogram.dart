import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class client extends StatefulWidget {
  const client({super.key});

  @override
  State<client> createState() => _clientState();
}

class _clientState extends State<client> {


  TextEditingController nou1 = TextEditingController();
  TextEditingController nou2 = TextEditingController();
  TextEditingController nou3 = TextEditingController();
  TextEditingController nou4 = TextEditingController();
  TextEditingController nou5 = TextEditingController();
  TextEditingController nou6 = TextEditingController();
  TextEditingController nou7 = TextEditingController();
  TextEditingController nou8 = TextEditingController();


  Future<bool>? ready;


  Future<bool> data(String clientname, String phonenum, String address,
      String gst,
      String website, String email, String contactperson,
      String phonenumber) async {
    var result = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Client/InsertClient"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8'
        },
        body: jsonEncode(<String, dynamic>{

          "clientId": 0,
          "clientName": clientname,
          "phone": phonenum,
          "address": address,
          "gst": gst,
          "website": website,
          "email": email,
          "contactPerson": contactperson,
          "phoneNumber": phonenumber,
          "createdBy": 1
        }

        )
    );
    return jsonDecode(result.body)["success"];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (ready == null ? buildColoumn() : buildFuturebuilder()),
          )
        ],
      ),
    );
  }

  Column buildColoumn() {
    return Column(
      children: [
        TextFormField(controller: nou1,
          decoration: InputDecoration(label: Text("Client Name")),),
        TextFormField(
          controller: nou2, decoration: InputDecoration(label: Text("Phone")),),
        TextFormField(controller: nou3,
          decoration: InputDecoration(label: Text("Address")),),
        TextFormField(
          controller: nou4, decoration: InputDecoration(label: Text("GST")),),
        TextFormField(controller: nou5,
          decoration: InputDecoration(label: Text("Website")),),
        TextFormField(controller: nou6,
          decoration: InputDecoration(label: Text("E-Mail")),),
        TextFormField(controller: nou7,
          decoration: InputDecoration(label: Text("Contact Person")),),
        TextFormField(controller: nou8,
          decoration: InputDecoration(label: Text("Phone Number")),),

        ElevatedButton(onPressed: () {
          setState(() {
             ready = data(
                nou1.text,
                nou2.text,
                nou3.text,
                nou4.text,
                nou5.text,
                nou6.text,
                nou7.text,
                nou8.text);
          });
        },
            child: Text("SAVE")
        )
      ],
    );
  }

  FutureBuilder buildFuturebuilder() {
    return FutureBuilder(
        future: ready,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Text("Added Succesfully");
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );
  }
}