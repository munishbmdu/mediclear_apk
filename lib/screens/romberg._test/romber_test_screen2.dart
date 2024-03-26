import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/romberg._test/romber_test_screen1.dart';
import 'package:mediclear_labs/screens/romberg._test/romber_test_screen3.dart';

class RomberTestScreen2 extends StatelessWidget {
   RomberTestScreen2({super.key,required this.medical_id});
  String medical_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:  AppBar(
        title: Text('MEDICLEAR',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
           leading: IconButton(onPressed:() {
                          
            Navigator.pop(context);
          }, icon:Icon(Icons.navigate_before,color: Colors.black,size: 35,)),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                
                  
                  child: Image.asset("assets/romberg_eye_image.gif")),
              ),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("1. Specify the materials needed, which typically include an open space .",style:  GoogleFonts.roboto(fontSize: 16,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("2. Emphasize the importance of safety, especially if someone might be at risk of falling. Have a spotter or assistant present.",style:   GoogleFonts.roboto(fontSize: 16,fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("3. Clearly explain the steps involved in the Romberg Test, including the initial stance, closing the eyes, and maintaining balance.",style:  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("4. Ensure good video quailty. Use proper lighting to make everything visible.",style:   GoogleFonts.roboto(fontSize: 16,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(text: "<< Previous", route: RomberTestScreen1(medical_id: medical_id,)),
                  
                    CustomElevatedButton(text: "Next >>", route:RombergTestScreen3(medical_id: medical_id)),
                  ],
                ),
      
            ],
          ),
        ),
      ),

    );;
  }
}