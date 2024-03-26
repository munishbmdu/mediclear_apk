import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends StatelessWidget {
  String title;
  TextInputType keyboardtype;
  TextEditingController controler = TextEditingController();
  MyTextFormField(
      {required this.title,
      required this.controler,
      required this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //   obscureText: true,
      controller: controler,
      keyboardType: keyboardtype,

      decoration: InputDecoration(
          hintText: title,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 48, 6, 234))),
          fillColor: Color.fromARGB(255, 228, 226, 239),
          filled: true),
    );
  }
}
