import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/visual_test_screen2.dart';

class VisualEyeTest extends StatefulWidget {
  String medical_id;
  VisualEyeTest({super.key, required this.medical_id});

  @override
  State<VisualEyeTest> createState() => _VisualEyeTestState();
}

class _VisualEyeTestState extends State<VisualEyeTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Visual Testing',
          style: GoogleFonts.poppins(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: CircleAvatar(
              backgroundColor: Colors.red.shade400,
              radius: 100,

              //   child: Image.asset("assets/visual_test.png"),
              backgroundImage: AssetImage("assets/visual_test.png"),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Better vision also means more quality of life, as sight is our most important sensory organ",
            style: GoogleFonts.poppins(fontSize: 18, color: Coloors.fontcolor),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 350,
            child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisualTestScreen2(
                        medical_id: widget.medical_id,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(backgroundColor: Coloors.fontcolor),
                child: Text(
                  "Start Test",
                  style: GoogleFonts.poppins(fontSize: 24, color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
