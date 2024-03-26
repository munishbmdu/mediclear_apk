import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/application_form/screens/form.dart';
import 'package:mediclear_labs/screens/login_page/login_page1.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wheretojump();
    //    Future.delayed(Duration(seconds: 3), () {
    //   // After the delay, navigate to the home screen
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(builder: (context) => LoginSignupScreen()),
    //   );
    // });
    // Timer(Duration(seconds: 5),(){
    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignupScreen()));
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 00,),
              Center(
                child: Container(
                    height: 350,
                    width: 350,
                    child: Image.asset('assets/mediclear.jpg')),
              ),
              // SizedBox(height: 80,),
              // Text('Mediclear',style: GoogleFonts.poppins(fontSize: 20,fontWeight: FontWeight.bold,color: Coloors.fontcolor),)
            ],
          ),

        ],
      ),
    );
  }
  Future wheretojump()async{
         var sharedpref=await SharedPreferences.getInstance();
         var isLoggedIn=sharedpref.getString('token');
         print(isLoggedIn);
         if(isLoggedIn==null){
             Future.delayed(Duration(seconds: 3), () {
      // After the delay, navigate to the home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginSignupScreen()),
      );
    });
    Timer(Duration(seconds:2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginSignupScreen()));
    });
         }
         else{
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>TestScreen()));
         }
  }
}



