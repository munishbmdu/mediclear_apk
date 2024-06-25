import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:mediclear_labs/widgets/drawer/terms_conditions.dart';
import 'package:mediclear_labs/widgets/signup_text_form.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;

  void submit() {
    var Name = fullname.text.trim().toString();
    var Password = password.text.trim().toString();
    var Email = email.text.trim().toString();
    var Address = address.text.trim().toString();
    var Mobile = phoneNumber.text.trim().toString();
    var value = {
      'name': Name,
      'password': Password,
      'email': Email,
      'address': Address,
      'mobile_no': Mobile
    };
    registration(value);
    // setState(() {
    //   Navigator.push(context, MaterialPageRoute(builder:(context) => TestScreen(),));
    // });
  }

  final TextEditingController email = TextEditingController();

  final TextEditingController fullname = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController password = TextEditingController();
  final TextEditingController cpassword = TextEditingController();
  final TextEditingController address = TextEditingController();
  void validation(context) {
    if (fullname.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Please Enter your Name!'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (email.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Email is Empty!'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.text)) {
      const snackBar = SnackBar(
        content: Text('Not a valid Email!'),
        // behavior: SnackBarBehavior.floating,
        //backgroundColor: Colors.amber,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (address.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Address cannot be Empty!'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text('Password is Empty!'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (phoneNumber.text.length != 10) {
      const snackBar = SnackBar(
        content: Text('Enter valid PhoneNumber!'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (password.text.length < 8) {
      const snackBar = SnackBar(
        content: Text('Minimum length of password should be 8'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (cpassword.text != password.text) {
      const snackBar = SnackBar(
        content: Text('confirm password do not match with password'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (cpassword.text != password.text) {
      const snackBar = SnackBar(
        content: Text('confirm password do not match with password'),
        // behavior: SnackBarBehavior.floating,
        // backgroundColor: Colors.amber,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      submit();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Toptitle(title: "SignUp", subtitle: "Create an Account"),
            Container(
              // height:screenHeight/2 ,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyTextFormField(
                      title: "Full Name",
                      controler: fullname,
                      keyboardtype: TextInputType.text,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyTextFormField(
                      title: "Email",
                      controler: email,
                      keyboardtype: TextInputType.emailAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                      decoration: InputDecoration(
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 48, 6, 234))),
                          fillColor: Color.fromARGB(255, 228, 226, 239),
                          filled: true),
                      // validator: (value) {
                      //   if (value!.isEmpty || value.length < 10) {
                      //     return 'Please enter a valid 10-digit phone number';
                      //   }
                      //   return null;
                      // },
                    ),
                    // MyTextFormField(
                    //   title: "Phone Number",
                    //   controler: phoneNumber,
                    //   keyboardtype: TextInputType.number,
                    // ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyTextFormField(
                      title: "Address",
                      controler: address,
                      keyboardtype: TextInputType.streetAddress,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextFormField(
                      controller: password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 48, 6, 234))),
                          fillColor: Color.fromARGB(255, 228, 226, 239),
                          filled: true),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: MyPasswordTextFormField(
                        title: "Confirm Password", controller: cpassword),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TermsAndConditions(),
            SizedBox(
              height: 10,
            ),
            isLoading == false
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: screenHeight / 16,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Coloors.fontcolor,
                      ),
                      onPressed: () {
                        validation(context);
                      },
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (ctx) => LoginOptionsToggleButton()));
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Coloors.fontcolor),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future registration(Object value) async {
    final response = await http.post(
        Uri.parse("https://bmdublog.com/mediclear/api/Customer/register"),
        body: jsonEncode(value),
        headers: ({"Content-Type": "application/json; charset=UTF-8"}));
    //print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print(data);
      if (data['status'] == true) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginOptionsToggleButton()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${data['message']}")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${data['error']}')));
      }
    } else {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${data['error']}')));
    }
  }
}

class MyPasswordTextFormField extends StatefulWidget {
  TextEditingController controller;
  String title;
  MyPasswordTextFormField({required this.title, required this.controller});

  @override
  State<MyPasswordTextFormField> createState() =>
      _MyPasswordTextFormFieldState();
}

class _MyPasswordTextFormFieldState extends State<MyPasswordTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
          suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
              child: Icon(obscureText == true
                  ? Icons.visibility
                  : Icons.visibility_off)),
          hintText: widget.title,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 48, 6, 234))),
          fillColor: Color.fromARGB(255, 228, 226, 239),
          filled: true),
    );
  }
}

// class MyTextFormField extends StatelessWidget {
//    TextEditingController controller;
//   String title;
//  MyTextFormField({required this.title,required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return  TextFormField(
//                           controller:controller ,
//                        //   obscureText: true,
//                         decoration: InputDecoration(
//                           hintText: title,
//                           hintStyle: GoogleFonts.poppins(),
//                           border: OutlineInputBorder(
//                              borderRadius: BorderRadius.circular(10),
//                             borderSide: BorderSide.none
//                           ),
//                           fillColor:   Color.fromARGB(255, 228, 226, 239),
//                           filled: true
//                         ),
//                         );
//   }
// }

class Toptitle extends StatelessWidget {
  final title, subtitle;
  Toptitle({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      //height: screenHeight/3.7,
      //  width: screenWidth/1.08,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
                fontSize: 40,
                color: Coloors.fontcolor,
                fontWeight: FontWeight.bold),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 32,
                color: Coloors.fontcolor,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
