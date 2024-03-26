import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_screen2.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/romberg._test/romber_test_screen2.dart';

class RomberTestScreen1 extends StatelessWidget {
   RomberTestScreen1({super.key,required this.medical_id});
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("Please upload your video while standing with closed eyes",style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:22, color: Coloors.fontcolor),textAlign: TextAlign.center,)),
          SizedBox(
            height: 100,
          ),
          CustomElevatedButton(text: 'Next >>', route: RomberTestScreen2(medical_id: medical_id,),),
        ],
      ),
    );
  }
}