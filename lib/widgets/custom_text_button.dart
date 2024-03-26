import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';

class CustomTextButton extends StatefulWidget {
  CustomTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.colorr,
    this.fontcolor=Colors.black
  });
  late String text;
  Color ?colorr=Colors.white;
  Color ?fontcolor;
   final Function()? onTap;

  @override
  State<CustomTextButton> createState() => _CustomTextButtonState();
}

class _CustomTextButtonState extends State<CustomTextButton> {
  Color buttonColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return TextButton(
    onPressed:widget.onTap,
    style: TextButton.styleFrom(
      backgroundColor: widget.colorr,  
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0), 
        side: BorderSide(color:Coloors.fontcolor, width: 2.0),  
      ),
    ),
    child: Text(
      widget.text,
      style: GoogleFonts.poppins(fontSize: 16,color: widget.fontcolor), 

    ),
       );

  }
}