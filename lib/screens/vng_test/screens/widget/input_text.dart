import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputText extends StatefulWidget {
  InputText({
    super.key,
    required this.text,
  });
  final String text;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade500)),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 8),
        child: Row(
          children: [
            TextField(
              decoration: InputDecoration(),
              controller: TextEditingController(),
              style: TextStyle(
                  color: Colors.grey.shade700,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
