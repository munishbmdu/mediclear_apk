import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/test_screen1.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
   double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 170,
              width: 170,
              child: Image.asset("assets/screen3.jpg",fit: BoxFit.contain,)),
                 Divider(
                thickness: 1,
                color: Colors.grey.shade300,
                indent: 20,
                endIndent: 20,
              ),
               Slider(
          value: _currentSliderValue,
          max: 100,
          label: _currentSliderValue.round().toString(),
          inactiveColor: Colors.grey,
          activeColor: Coloors.fontcolor,
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
            });
    
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Text("Adjust the volume so you can hear all the three digits",style:  GoogleFonts.roboto(color: Coloors.fontcolor,fontSize: 18),textAlign: TextAlign.center,),
        ),
        //SizedBox(height: 200,),
    
        TextButton(
          onPressed: () {
            
          },
    
          child: Text("Can't hear anything?",style: TextStyle(color: Colors.grey.shade400,fontSize: 18),)),
         
          ],
        ),
      ),
    );
  }
}