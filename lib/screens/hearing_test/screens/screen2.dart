import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/test_screen1.dart';

class Screen2 extends StatelessWidget {
  const Screen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset("assets/screen2.jpg",fit: BoxFit.fill,),
      
              Divider(
                thickness: 1,
                color: Colors.grey.shade300,
                indent: 20,
                endIndent: 20,
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text("Ensure that your headphone or earbuds are plugged in or paired",textAlign: TextAlign.center,style: GoogleFonts.roboto(color: Coloors.fontcolor,fontSize: 18),),
              ),
    
             
      
          ],
        ),
      ),
    );
  }
}