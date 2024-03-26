import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/BPPV_test/bppv_textscreen2.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_screen2.dart';

class BppvTestScreen1 extends StatelessWidget {
   BppvTestScreen1({super.key,required this.medical_id});
  String medical_id;





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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset("assets/bppv.png"),
          SizedBox(
            height: 30,
          ),
          Center(child: Text("Turn your head 45 degree to one side and the quickly lie on your back,with your head off the side of the table and ,maintain the 45 degree head turn for atleast 30 sec",textAlign: TextAlign.center, style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:22, color: Coloors.fontcolor),)),
          SizedBox(
            height: 100,
          ),
          CustomElevatedButton(text: 'Next >>', route: BppvTestScreen2(medical_id: medical_id,),),
        ],
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
   CustomElevatedButton({
    super.key,required this.text,required this.route
  });
  late String text;
  late Widget route;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:() {
      Navigator.of(context).push(MaterialPageRoute(builder:(context) => route,));
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Coloors.fontcolor
    ),
     child:Text(text,style:  GoogleFonts.poppins(fontSize: 20,color: Colors.white),));
  }
}