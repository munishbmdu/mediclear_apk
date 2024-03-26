import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';

class VisualTestScreen2 extends StatefulWidget {
  const VisualTestScreen2({super.key});

  @override
  State<VisualTestScreen2> createState() => _VisualTestScreen2State();
}

class _VisualTestScreen2State extends State<VisualTestScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('Visual Testing',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
           leading: IconButton(onPressed:() {
                          
            Navigator.pop(context);
          }, icon:Icon(Icons.navigate_before,color: Colors.black,size: 35,)),
        centerTitle: true,
        elevation: 2,
      ),
   body:Column(
  //  crossAxisAlignment: CrossAxisAlignment.center,
   children: [
    SizedBox(height: 100,),
    Center(child: Text("Keep Your Device at Arm's length",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
     Center(child: Text("See the top ring? Mark the corresponding ring on lower ring",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Coloors.fontcolor),softWrap: true,textAlign: TextAlign.center,)),
     SizedBox(height: 30,),
     Container(
      height: 350,
      width: MediaQuery.of(context).size.width*0.8,
       child: Image.asset("assets/visual.jpg"),
     ),
     SizedBox(height: 20,),
      Container(
        width: 150,
        child: ElevatedButton(onPressed: (){
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:Coloors.fontcolor
            ),
             child: Text("Let's begin",style: TextStyle(color: Colors.white),)),
      )
   ],
   )

    );
  }
}