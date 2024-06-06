import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class employee extends StatefulWidget {
  const employee({super.key});

  @override
  State<employee> createState() => _employeeState();
}

class _employeeState extends State<employee> {


  TextEditingController em = TextEditingController();
  TextEditingController m = TextEditingController();
  TextEditingController u = TextEditingController();
  TextEditingController p = TextEditingController();
  TextEditingController cp = TextEditingController();

  Future<bool>? success;
  
  Future<bool> func(String employeename ,String mobilenum ,String username ,
                    String password ,String confirmpassword ,) async{
    var result = await http.post(
        Uri.parse("http://catodotest.elevadosoftwares.com/Employee/InsertEmployee"),
      headers: <String,String>{
        'Content-Type' : 'application/json; charset=utf-8'
      },
       body: jsonEncode(<String,dynamic>{

         "employeeId": 0,
         "employeeName": "Sangeetha",
         "mobile": "7865663",
         "userName": "Testing",
         "password": "Test",
         "confirmPassword": "Test",
         "createdBy": 1

       })
    );
    return
        jsonDecode(result.body)["success"];
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: (success == null ? buildColumn() : buildFuturebuilder() ),
          )
        ],
      ),
    );
  }

 Column buildColumn() {
    return
        Column(
          children: [
            TextFormField(controller: em,decoration: InputDecoration(label: Text("Employee Name")),),
            TextFormField(controller: m,decoration: InputDecoration(label: Text("Mobile Number")),),
            TextFormField(controller: u,decoration: InputDecoration(label: Text("User Name")),),
            TextFormField(controller: p,decoration: InputDecoration(label: Text("Password")),),
            TextFormField(controller: cp,decoration: InputDecoration(label: Text("Confirm Password")),),

            ElevatedButton(onPressed: ()
            {
              setState(() {
                success = func(em.text, m.text, u.text, p.text, cp.text);
              });
            },
                child: Text("CREATE"))
          ],
        );
 }

 FutureBuilder buildFuturebuilder() {
    return
        FutureBuilder(
            future: success,
            builder: (BuildContext context, snapshot){
              if (snapshot.hasData){
                return Text("Added Successfully");
              }
              else if (snapshot.hasError){
                return Text("Error");
              }
              return CircularProgressIndicator();
            }
        );
 }



}
