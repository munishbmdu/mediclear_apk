import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/signup_screen/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupScreen extends StatelessWidget {
  const LoginSignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 78, 64, 64),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 15),
              child: Container(
                child: Image.asset("assets/mediclear.jpg"),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Text(
                    "Har sehatmand shuruaat Mediclear ke saath!",
                    style: GoogleFonts.poppins(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        color: Coloors.fontcolor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  " A Healthy Tomorrow Begins Today \nExplore medical tests in your phone",
                  style: GoogleFonts.poppins(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyButton(
                  name: "Login",
                  width: 120,
                  height: 45,
                  onPressedCallback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginOptionsToggleButton(),
                        ));
                  },
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ));
                    },
                    child: Text(
                      "Register",
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  String title;
  TextEditingController controller;
  var keyboard;

  MyTextFormField(
      {required this.title,
      required this.controller,
      this.obsecure = false,
      this.keyboard});
  bool obsecure;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //  obscureText: obsecure,
      controller: controller,
      keyboardType: keyboard,
      decoration: InputDecoration(
          hintText: title,
          hintStyle: GoogleFonts.poppins(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 48, 6, 234))),
          fillColor: Color.fromARGB(255, 228, 226, 239),
          filled: true),
    );
  }
}

class MyButton extends StatelessWidget {
  MyButton(
      {super.key,
      required this.name,
      required this.width,
      required this.height,
      required this.onPressedCallback});
  late String name;
  late double width;
  late double height;
  final VoidCallback onPressedCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressedCallback,
        child: Text(
          name,
          style: GoogleFonts.poppins(
              color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
            backgroundColor: Coloors.fontcolor,
            elevation: 8),
      ),
    );
  }
}
