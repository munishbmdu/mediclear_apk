import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/login_page/login_page1.dart';
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/signup_screen/signup.dart';
import 'package:mediclear_labs/widgets/custom_text_button.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Coloors.fontcolor),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Toptitle(title: "Verify Email", subtitle:"Reset Your Password!"),
                Container(
                height:screenHeight/2 ,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                  
                    SizedBox(
                      height: 10,
                    ),
                    Text("Enter Your Email and instructions is sent to you",style: GoogleFonts.poppins(color: Colors.black,fontSize: 16,),
                    textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child:MyTextFormField(title: "Email", controller:email)
                    ),
                      SizedBox(
                      height: 40,
                    ),
               MyButton(name: "Send Instructions", width: 330, height: 50, onPressedCallback: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginOptionsToggleButton()));
               }),SizedBox(
                height: 50,
               ),
                   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Remember password? ",
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),),
                    GestureDetector(
                      onTap:() {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LoginOptionsToggleButton()));
                      },
                      child: Text("Login",style: TextStyle(
                        fontSize: 16,
                        color: Coloors.fontcolor
                      ),),
                    )
                  ],
                )
                  
                  ],
                ),
                
                ),
         
                   
               
                 
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget circleimage(){
return CircleAvatar(
  radius: 55,
  backgroundColor: Colors.white,
  child: Image.asset("assets/reset_image.png"),
);

}