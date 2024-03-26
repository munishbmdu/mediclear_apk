import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/fakuda_unterberger_test/screens/fakuda_unterberger_test_screen2.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';

class FakudaUnterbergerTestScreen1 extends StatelessWidget {
  FakudaUnterbergerTestScreen1({super.key,required this.medical_id});
  String medical_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/fakuda_test.jpg"),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("1. The Fukuda-Unterberger test requires you to march with your eyes closed.",style:  GoogleFonts.roboto(fontSize: 19,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                  ),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("2. Emphasize the importance of safety, especially if someone might be at risk of falling. Have a spotter or assistant present",style:   GoogleFonts.roboto(fontSize: 19,fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                  ),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("3. Draw straight line and walk with closed eyes and record the video",style: GoogleFonts.roboto(fontSize: 19, fontWeight: FontWeight.bold, color: Coloors.fontcolor),textAlign:TextAlign.start ,),
                  ),
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("4. Finally Upload the video and please check it should be visilble properly.",style:   GoogleFonts.roboto(fontSize: 19,color: Coloors.fontcolor,fontWeight: FontWeight.bold),textAlign:TextAlign.start ,),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomElevatedButton(text: "<< Previous", route:VertigoTest() ),
                    
                      CustomElevatedButton(text: "Next >>", route:FakudaUnterbergerTestScreen2(medical_id: medical_id,)),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
