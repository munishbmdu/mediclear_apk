import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/application_form/screens/form.dart';

import 'package:mediclear_labs/screens/login_page/forgot_password.dart';
import 'package:mediclear_labs/screens/login_page/login_page1.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/signup_screen/signup.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginOptionsToggleButton extends StatefulWidget {
  const LoginOptionsToggleButton({super.key});

  @override
  State<LoginOptionsToggleButton> createState() =>
      _LoginOptionsToggleButtonState();
}

class _LoginOptionsToggleButtonState extends State<LoginOptionsToggleButton> {
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController resourcename = TextEditingController();
  TextEditingController batchno = TextEditingController();
  TextEditingController doctorpassword = TextEditingController();
  int selectedOption = 1;
  bool isloading = true;
  bool isloading2 = true;

  Future getCorporateLogin(Object value, String url) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse("https://qbacp.com/mediclear/api/Corporate/login"),
        body: jsonEncode(value),
        headers: ({"Content-Type": "application/json; charset=UTF-8"}));
    print(value);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var Token = data['token'];
      prefs.setString('token', Token);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Congratulations! You logged in sucessfully")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => TestScreen()));
    } else {
      final data = jsonDecode(response.body);
      // print(data['Unauthorized']);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data['Unauthorized']['error']}')));
    }
  }

  Future getLogin(Object value, String url) async {
    print("get is still calling");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse("https://qbacp.com/mediclear/api/Customer/login"),
        body: jsonEncode(value),
        headers: ({"Content-Type": "application/json; charset=UTF-8"}));
    print(value);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      var Token = data['data']['token'];
      prefs.setString('token', Token);
      print(data);
      if (data['status'] == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("${data['message']}")));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TestScreen()));
      }
    } else {
      final data = jsonDecode(response.body);
      print(data['Unauthorized']);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${data['Unauthorized']['error']}')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Toggle Button
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                    child: Text(
                  "Login here ",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Coloors.fontcolor,
                      fontSize: 22),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Customer Login',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Coloors.fontcolor),
                    ),
                    Radio(
                      value: 1,
                      activeColor: Coloors.fontcolor,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                    Text(
                      'Corperate Login',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Coloors.fontcolor),
                    ),
                    Radio(
                      activeColor: Coloors.fontcolor,
                      value: 2,
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              // Content based on the selected screen
              selectedOption == 1
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Welcome back you've",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              "been missed!",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MyTextFormField(
                                keyboard: TextInputType.phone,
                                title: "Phone",
                                controller: phone,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MyPasswordTextFormField(
                                title: "Password",
                                controller: password,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword(),
                                          ));
                                    },
                                    child: Text(
                                      "Forgot your password?",
                                      style: GoogleFonts.poppins(
                                          color: Coloors.fontcolor,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            isloading
                                ? MyButton(
                                    name: "Login as Customer",
                                    width: 320,
                                    height: 48,
                                    onPressedCallback: () {
                                      var Phone = phone.text.trim().toString();
                                      var Password =
                                          password.text.trim().toString();
                                      if (Phone == '' && Password == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Fill the above fields")));
                                      } else if (Phone == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Fill phone number")));
                                      } else if (Password == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Enter Password")));
                                      }
                                      // print(Phone);
                                      else {
                                        setState(() {
                                          isloading = false;
                                        });
                                        var value = {
                                          'mobile_no': Phone,
                                          'password': Password
                                        };
                                        print("get is calling");
                                        getLogin(value, 'Customer');
                                        print(value);
                                        print("get is called");

                                        Future.delayed(Duration(seconds: 1),
                                            () {
                                          setState(() {
                                            isloading = true;
                                          });
                                        });
                                      }
                                    })
                                : CircularProgressIndicator(),
                            SizedBox(
                              height: 25,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ));
                              },
                              child: Text(
                                "Create new Account",
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w500,
                                    color: Coloors.fontcolor),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "Welcome back you've",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            Text(
                              "been missed!",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: MyTextFormField(
                                title: "User id ",
                                controller: resourcename,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: MyPasswordTextFormField(
                                    title: "Password",
                                    controller: doctorpassword)),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            isloading2
                                ? MyButton(
                                    name: "Login as Corperate",
                                    width: 320,
                                    height: 48,
                                    onPressedCallback: () {
                                      var UserId =
                                          resourcename.text.trim().toString();
                                      var Password =
                                          doctorpassword.text.trim().toString();
                                      if (UserId == '' && Password == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Fill the above fields")));
                                      } else if (UserId == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Plaese Fill UserId")));
                                      } else if (Password == '') {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Plaese Fill Password")));
                                      } else {
                                        setState(() {
                                          isloading2 = false;
                                        });
                                        var value = {
                                          'user_id': UserId,
                                          'password': Password
                                        };
                                        getCorporateLogin(value, 'Corporate');
                                        Future.delayed(Duration(seconds: 2),
                                            () {
                                          setState(() {
                                            isloading2 = true;
                                          });
                                        });
                                        // Navigator.push(context, MaterialPageRoute(builder:(context) => MyForm(),));
                                      }
                                    },
                                  )
                                : CircularProgressIndicator(),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
