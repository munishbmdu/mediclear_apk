import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/blood_pressure_test/Screens/blood_pressure_test.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';

class EarlierPostBloodPressueDetails extends StatefulWidget {
   EarlierPostBloodPressueDetails({super.key,required this.prelower,required this.preupper,required this.postlower,required this.postupper,required this.context });
   TextEditingController postlower;
  TextEditingController postupper;
  TextEditingController preupper;
  TextEditingController prelower;
  BuildContext context;


  @override
  State<EarlierPostBloodPressueDetails> createState() => _EarlierPostBloodPressueDetailsState();
}

class _EarlierPostBloodPressueDetailsState extends State<EarlierPostBloodPressueDetails> {
  
  
   int _currentIndex = 0;
  @override
  Widget build(context) {
    return  Column(
        children: [
          // Toggle Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text('Pre BP',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
             Radio(value: 0, groupValue: _currentIndex, onChanged:(value){
                 setState(() {
                   _currentIndex=value!;
                 });
             }),
             Text('Post BP',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
                Radio(value: 1, groupValue: _currentIndex, onChanged:(value){
                 setState(() {
                   _currentIndex=value!;
                 });
             }),
              
              // Switch(
              //   value: _currentIndex == 0,
              //   onChanged: (value) {
              //     setState(() {
              //       _currentIndex = value ? 0 : 1;
              //     });
              //   },
              // ),
              // Text('Post BP',textAlign: TextAlign.center, style:GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
            ],
          ),
          // Content based on the selected screen
          IndexedStack(
            index: _currentIndex,
            children: [
              // Screen 1
              buildScreen1Content(),

              // Screen 2
              buildScreen2Content(),
            ],
          ),
        ],
      
    );
  }

  Widget buildScreen1Content() {
    // You can call any widget or UI elements for Screen 1 here
    return Center(
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomeTextField("Lower BP",widget.prelower ),
          SizedBox(
            height: 20,
          ),
          CustomeTextField("Upper BP", widget.preupper),
          SizedBox(
            height: 20,
          ),
        
        ],
      )
    );
  }

  Widget buildScreen2Content() {
    // You can call any widget or UI elements for Screen 2 here
    return  Center(
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomeTextField("Lower BP",widget.postlower ),
          SizedBox(
            height: 20,
          ),
          CustomeTextField("Upper BP", widget.postupper),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                 ElevatedButton(onPressed:() {
             setState(() {
               
             });
          }, 
            style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Coloors.fontcolor
                ), 
          child:Text("Graph",style: GoogleFonts.roboto(color: Colors.white),)),
              ElevatedButton(onPressed:() {
                 SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                Navigator.push(context, MaterialPageRoute(builder:(context) => VertigoTest(val2: 1,),));
              }, 
                style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Coloors.fontcolor
                    ), 
              child:Text("Finish",style: GoogleFonts.roboto(color: Colors.white),)),
            ],
          ),
          
        ],
      )
    );
  }
}