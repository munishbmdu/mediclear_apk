import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/eye_test_screen3.dart';

class EyeTestScreen2 extends StatelessWidget {
  EyeTestScreen2({super.key,required this.medical_id});
  String medical_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Blindness',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
           leading: IconButton(onPressed:() {
                          
            Navigator.pop(context);
          }, icon:Icon(Icons.navigate_before,color: Colors.black,size: 35,)),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column( 
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
           
             Center(
               child: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 100,
                          child: Image.asset("assets/eye_icon1.png"),
                               
                                   ),
             ),
                                 SizedBox(
                    height: 10,
                                 ),
                                 Text("If You have color blindeness,it means you see the color different than most people.",style: GoogleFonts.poppins(fontSize: 18,color: Coloors.fontcolor),textAlign: TextAlign.center,),
                    Container(
                      width: 350,
                      child: TextButton(onPressed:() {
                        Navigator.push(context, MaterialPageRoute(builder:(context) =>ImageGuessingScreen(medical_id: medical_id,)));
                      }, 
                      style: TextButton.styleFrom(
                        backgroundColor: Coloors.fontcolor
                      ),
                      child:Text("Start Test",style: GoogleFonts.poppins(fontSize: 24,color: Colors.white),)),
                    )             
        ],
      ),
    );
  }
}


