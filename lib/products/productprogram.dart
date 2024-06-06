// import 'dart:convert';
//
// import 'package:api/products/productmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class product extends StatefulWidget {
//   const product({super.key});
//
//   @override
//   State<product> createState() => _productState();
// }
//
// class _productState extends State<product> {
//
//   Future<List<Pro>> fetch() async{
//     var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
//     var data = jsonDecode(res.body);
//     return (data as List).map((e) => Pro())
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           FutureBuilder(
//               future: future,
//               builder: builder
//           )
//         ],
//       ),
//     );
//   }
// }
