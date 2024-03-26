import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';

class Screen1 extends StatelessWidget {
  const Screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 55),
          child: Text("Find a quite place for the test. Althought the test is accurate with slight to moderate ambient noise",textAlign:TextAlign.center ,style: GoogleFonts.roboto(fontSize:18,color:Coloors.fontcolor),),

        ),
        
      ],
    );
    
  }
}