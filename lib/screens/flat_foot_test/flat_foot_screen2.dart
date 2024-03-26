import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen3.dart';

class FootTestScreen2 extends StatelessWidget {
  FootTestScreen2({super.key,required this.medical_id});
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
              Container(
              
              
                child: Image.asset("assets/foot_print_image.jpg")),
                SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("1. You can use a regular stamp pad or washable paint.",style:  GoogleFonts.roboto(fontSize: 19,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("2. Use a durable, large-sized paper or canvas to take the impressions",style:   GoogleFonts.roboto(fontSize: 19,fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("3. Now Capture the Impressions from the paper or canvas via Camera",style: GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                ),
                  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  child: Text("4. Finally Upload the Photograph and please check it should be visilble properly.",style:   GoogleFonts.roboto(fontSize: 19,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomElevatedButton(text: "<< Previous", route: FlatFootTestScreen1(medical_id: medical_id,)),
                  
                    CustomElevatedButton(text: "Next >>", route:FlatFootTestScreen3(medical_id: medical_id,)),
                  ],
                ),
      
            ],
          ),
        ),
      ),

    );
  }
}