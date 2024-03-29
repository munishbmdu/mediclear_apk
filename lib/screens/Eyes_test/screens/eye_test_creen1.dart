import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/eye_test_screen2.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/visual_test_screen1.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';

class EyeTestScreen1 extends StatelessWidget {
  EyeTestScreen1({super.key, required this.medical_id});
  String medical_id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'MEDICLEAR',
            style: GoogleFonts.poppins(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VertigoTest(
                              id: medical_id,
                            )));
              },
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
                size: 35,
              )),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          // mainAxisAlignment:MainAxisAlignment.spaceAround ,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: EyeCard(),
            ),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EyeTestScreen2(
                                  medical_id: medical_id,
                                ),
                              ));
                          ;
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 45,
                          child: Image.asset("assets/eye_icon2.png"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Color Blindness",
                        style: GoogleFonts.poppins(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VisualEyeTest(
                                        medical_id: medical_id,
                                      )));
                          ;
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.shade400,
                          radius: 45,
                          // child: Image.asset("assets/visual_test.png"),
                          backgroundImage: AssetImage("assets/visual_test.png"),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Visual Testing",
                        style: GoogleFonts.poppins(),
                      )
                    ],
                  ),
                  //  InkWell(
                  //   onTap: () {
                  //  //   Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => EyeTestScreen2(),));
                  //   },
                  //    child: Column(
                  //      children: [
                  //        CircleAvatar(
                  //         backgroundColor: Colors.grey.shade400,
                  //         radius: 45,
                  //         child: Image.asset("assets/eye_icon1.png"),

                  //                  ),
                  //                  SizedBox(
                  //     height: 10,
                  //                  ),
                  //                  Text("OKN",style: GoogleFonts.poppins(),)
                  //      ],
                  //    ),
                  //  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              "Welcome to Eye's Text",
              style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Coloors.fontcolor),
            )
          ],
        ),
      ),
    );
  }
}

class EyeCard extends StatelessWidget {
  const EyeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Coloors.fontcolor,
      elevation: 5,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Text(
                    "EYE TEST",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    height: 100,
                    width: 200,
                    child: Image.asset("assets/eye_icon3.png"))
              ],
            ),
          ),

          // Container(
          // height: 100,
          // width: 100,
          // child: Image.asset("assets/eye_test.png"))
        ],
      ),
    );
  }
}
