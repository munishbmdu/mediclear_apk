import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_domain.dart';
import '../../hearing_test/screens/vertigo_test.dart';

class ImageGuessing extends StatefulWidget {
  ImageGuessing({required this.medical_id});
  final String medical_id;

  @override
  _ImageGuessingState createState() => _ImageGuessingState();
}

class _ImageGuessingState extends State<ImageGuessing> {
  List<Map<String, String>> imageList = [
    {'image': 'assets/img_42.png', 'number': '42'},
    {'image': 'assets/color_blindness.png', 'number': '74'},
    {'image': 'assets/img_12.png', 'number': '12'},
    {'image': 'assets/img_2.png', 'number': '2'},
    {'image': 'assets/img_6.png', 'number': '6'},
    {'image': 'assets/img_27.png', 'number': '27'},
    {'image': 'assets/img_5.jpg', 'number': '5'},
    {'image': 'assets/img_9.png', 'number': '9'},
    {'image': 'assets/img_10.jpg', 'number': '10'},
    {'image': 'assets/img_16.jpeg', 'number': '16'}
  ];

  String currentImage = '';
  String correctAnswer = ''; // Number associated with the current image
  int result = 0;
  int counter = 0;

  List<String> buttonNumbers = [];
  List<bool> resultant = [];

  @override
  void initState() {
    super.initState();
    setRandomImage();
    print(result);
  }

  Future getEyeTest(Object object) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    final response = await http.post(
      Uri.parse("${ApiDomain().url}eyecheckup"),
      body: jsonEncode(object),
      headers: ({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Image.asset("assets/eye_icon2.png"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Hurrah!!, Eye Test done sucessFully",
                    )
                  ],
                ),
              ),
            );
          });
    } else {
      var data = jsonDecode(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                height: 200,
                child: Column(
                  children: [
                    Image.asset("assets/eye_icon2.png"),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Test Failed",
                    )
                  ],
                ),
              ),
            );
          });
    }
  }

  void getResultScreen() {
    var q1, q2, q3, q4, q5, q6, q7, q8, q9, q10;
    q1 = resultant[0];
    q2 = resultant[1];
    q3 = resultant[2];
    q4 = resultant[3];
    q5 = resultant[4];
    q6 = resultant[5];
    q7 = resultant[6];
    q8 = resultant[7];
    q9 = resultant[8];
    q10 = resultant[9];
    var value = {
      'q1': q1,
      'q2': q2,
      'q3': q3,
      'q4': q4,
      'q5': q5,
      'q6': q6,
      'q7': q7,
      'q8': q8,
      'q9': q9,
      'q10': q10,
      'medical_details_id': widget.medical_id,
      'test_type_id': 1,
    };
    getEyeTest(value);
    // Navigate to the next screen after some delay
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => VertigoTest(
                  id: widget.medical_id,
                )),
      );
    });
  }

  void setRandomImage() {
    Random random = Random();
    int randomNumber = random.nextInt(imageList.length);
    setState(() {
      currentImage = imageList[randomNumber]['image']!;
      correctAnswer = imageList[randomNumber]['number']!;
    });

    List<String> randomNumbers = [];
    for (int i = 0; i < 3; i++) {
      int randIndex = random.nextInt(imageList.length);
      randomNumbers.add(imageList[randIndex]['number']!);
    }

    randomNumbers.shuffle();

    if (!randomNumbers.contains(correctAnswer)) {
      randomNumbers[random.nextInt(3)] = correctAnswer;
    }

    setState(() {
      buttonNumbers = randomNumbers;
    });
  }

  void checkGuess(String guess) {
    setState(() {
      result = (guess == correctAnswer) ? 1 : 2;
      resultant.add(guess == correctAnswer);
    });
    print("Nav" + resultant.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eye Testing Screen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            currentImage,
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              for (int i = 0; i < 3; i++)
                ElevatedButton(
                  onPressed: () {
                    // Check if the guess is correct
                    checkGuess(buttonNumbers[i]);
                    // Set a new random image and buttons
                    setRandomImage();
                    // Reset the result
                    setState(() {
                      result = 0;
                    });
                    // Increment counter
                    counter++;
                    // Check if this is the last question
                    if (counter == 10) {
                      getResultScreen();
                    }
                  },
                  child: Text(buttonNumbers[i]),
                ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            result == 1
                ? 'Correct Guess!'
                : result == 2
                    ? 'Incorrect Guess.'
                    : "Please select correct option",
          ),
        ],
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Text('This is the next screen.'),
      ),
    );
  }
}


















// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:mediclear_labs/constants/colors.dart';
// // import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
// // import 'package:mediclear_labs/screens/login_page/login_page1.dart';

// // class EyeTestScreen3 extends StatefulWidget {
// //    EyeTestScreen3({super.key,required this.question_no,required this.image});
// //   late int question_no;
// //   late String image;

// //   @override
// //   State<EyeTestScreen3> createState() => _EyeTestScreen3State();
// // }

// // class _EyeTestScreen3State extends State<EyeTestScreen3> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return EyeTest(context, 1,"assets/color_blindness.png", (){
// //      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>EyeTestScreen4()));

// //     },
// //     (){
// //       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>EyeTestScreen4()));

// //     }
// //     );
// //   }
// // }

// // class EyeTestScreen4 extends StatefulWidget {
// //   const EyeTestScreen4({super.key});

// //   @override
// //   State<EyeTestScreen4> createState() => _EyeTestScreen4State();
// // }

// // class _EyeTestScreen4State extends State<EyeTestScreen4> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return EyeTest(context, 1,"assets/eye_blindness3.png", (){
// //       Navigator.push(context, MaterialPageRoute(builder:(context) => VertigoTest(val1: 2,),));
// //     },(){
// //       Navigator.push(context, MaterialPageRoute(builder:(context) => VertigoTest(val1: 2,),));
// //     });
// //   }
// // }

// // Widget EyeTest(context, int question_no,String image, final  Function()? onpressed, final  Function()? ontap)
// // {
// //   return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         title: Text("Q. ${question_no}/4",style: GoogleFonts.poppins(fontSize: 24,color: Colors.black),),
// //         centerTitle: true,
// //         elevation: 0,
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.spaceAround,

// //         children: [
// //           Center(child: Text("What do you see in this image?",style: GoogleFonts.poppins(),)),
// //           CircleAvatar(
// //             radius:100,
// //             backgroundColor: Colors.white,
// //             backgroundImage: AssetImage(image),
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceAround,
// //             children: [
// //               CircleAvatar(
// //                 backgroundColor:Colors.grey.shade400,
// //                 radius: 30,
// //                 child: Text("1"),
// //               ),
// //                 InkWell(
// //                   onTap: ontap,
// //                   child: CircleAvatar(
// //                   backgroundColor: Colors.grey.shade400,
// //                   radius: 30,
// //                   child: Text("74"),
// //                               ),
// //                 ),
// //                 CircleAvatar(
// //                   radius: 30,
// //                 backgroundColor:Colors.grey.shade400,
// //                 child: Text("6"),
// //               ),

// //             ],
// //           ),
// //            Container(
// //                 width: 350,
// //                 child: ElevatedButton(onPressed:onpressed,
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: Coloors.fontcolor
// //                 ),
// //                 child: Text("Next",style: GoogleFonts.poppins(),)),
// //               )

// //         ],
// //       ),
// //     );
// // }

// // class FinalEyeTestScreen extends StatelessWidget {
// //   const FinalEyeTestScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         title: Text("Result",style: GoogleFonts.poppins(color: Coloors.fontcolor,fontSize: 24),),
// //         centerTitle: true,
// //       ),
// //       body: Column(
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         mainAxisAlignment: MainAxisAlignment.start,

// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.only(top: 100),
// //             child: Container(
// //               height: 110,

// //             child: Center(child: Image.asset("assets/eye_icon3.png"))),

// //           ),
// //           SizedBox(
// //             height: 70,
// //           ),
// //           CircleAvatar(
// //             backgroundColor: Colors.grey.shade200,
// //                radius: 70,

// //             child: Text("90%",style: GoogleFonts.poppins(fontSize: 20),),
// //           ),
// //           SizedBox(
// //             height: 60,
// //           ),
// //           MyButton(name: "Back To Vertigo Test", width: 320, height: 50, onPressedCallback: (){
// //             Navigator.pushReplacement(context, MaterialPageRoute(builder:(context) => VertigoTest(),));
// //           })
// //         ],
// //       ),
// //     );
// //   }
// // }
// // List<String> originalImageList = [
// //   'assets/img_42.png',
// //   'assets/color_blindness.png',
// //   'assets/img_12.png',
// //   'assets/img_2.png',
// //    'assets/img_6.png',
// //    'assets/img_27.png'
// //    ''
// // ];
// // List<int> buttonNumbers = [0, 1, 2, 3, 4, 5];
// // List<int> realButtonNumbers = [42, 74, 12, 2, 6, 27]; //

// // import 'dart:convert';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:mediclear_labs/constants/api_domain.dart';
// // import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart' as http;

// // class ImageGuessingScreen extends StatefulWidget {
// //   ImageGuessingScreen({required this.medical_id});
// //   String medical_id;
// //   @override
// //   _ImageGuessingScreenState createState() => _ImageGuessingScreenState();
// // }

// // class _ImageGuessingScreenState extends State<ImageGuessingScreen> {
// //   List<String> imageList = [
// //     'assets/img_42.png',
// //     'assets/color_blindness.png',
// //     'assets/img_12.png',
// //     'assets/img_2.png',
// //     'assets/img_6.png',
// //     'assets/img_27.png'
// //   ];

// //   String currentImage = '';
// //   int correctAnswer = 0; // Index of the correct answer
// //   int result = 0;
// //   int counter = 0;

// //   List<int> buttonNumbers = [];
// //   List<int> realbuttonNumbers = [42, 74, 12, 2, 6, 27];
// //   List<bool> resultant = [];

// //   @override
// //   void initState() {
// //     super.initState();
// //     // Call the function to set a random image initially
// //     setRandomImage();
// //     print(result);
// //   }

// //   Future getEyeTest(Object object) async {
// //     final SharedPreferences pref = await SharedPreferences.getInstance();
// //     var token = pref.getString("token");
// //     final response = await http.post(
// //       Uri.parse("${ApiDomain().url}eyecheckup"),
// //       body: jsonEncode(object),
// //       headers: ({
// //         'Content-Type': 'application/json; charset=UTF-8',
// //         'Authorization': 'Bearer $token'
// //       }),
// //     );
// //     if (response.statusCode == 200) {
// //       var data = jsonDecode(response.body);
// //       showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               content: Container(
// //                 height: 200,
// //                 child: Column(
// //                   children: [
// //                     Image.asset("assets/eye_icon2.png"),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     Text(
// //                       "Hurrah!!, Eye Test done sucessFully",
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             );
// //           });
// //     } else {
// //       var data = jsonDecode(response.body);
// //       showDialog(
// //           context: context,
// //           builder: (context) {
// //             return AlertDialog(
// //               content: Container(
// //                 height: 200,
// //                 child: Column(
// //                   children: [
// //                     Image.asset("assets/eye_icon2.png"),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     Text(
// //                       "Test Failed",
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             );
// //           });
// //     }
// //   }

// //   void getResultScreen() {
// //     var q1, q2, q3, q4, q5, q6;
// //     q1 = resultant[0];
// //     q2 = resultant[1];
// //     q3 = resultant[2];
// //     q4 = resultant[3];
// //     q5 = resultant[4];
// //     q6 = resultant[5];
// //     var value = {
// //       'q1': q1,
// //       'q2': q2,
// //       'q3': q3,
// //       'q4': q4,
// //       'q5': q5,
// //       'q6': q6,
// //       'medical_details_id': widget.medical_id,
// //       'test_type_id': 1
// //     };
// //     getEyeTest(value);
// //     Future.delayed(Duration(seconds: 5), () {
// //       Navigator.pushReplacement(
// //           context,
// //           MaterialPageRoute(
// //               builder: (context) => VertigoTest(
// //                     id: widget.medical_id,
// //                   )));
// //     });
// //   }

// //   void setRandomImage() {
// //     // Get a random image from the list
// //     Random random = Random();
// //     int randomNumber = random.nextInt(imageList.length);

// //     // Create a list of numbers from 0 to 5 (for 6 buttons)
// //     buttonNumbers = List<int>.generate(6, (index) => index);
// //     print("Goldy" + buttonNumbers.toString());

// //     // Shuffle the button numbers list
// //     buttonNumbers.shuffle();

// //     setState(() {
// //       currentImage = imageList[randomNumber];
// //       // Choose one index as the correct answer
// //       correctAnswer = randomNumber; // Randomly choose 0, 1, or 2
// //     });
// //   }

// //   void checkGuess(int guess) {
// //     // Check if the guessed index matches the correct answer
// //     setState(() {
// //       result = (guess == correctAnswer) ? 1 : 2;
// //       resultant.add(guess == correctAnswer);
// //       print("Nav" + resultant.toString());
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Eye Testing Screen'),
// //       ),
// //       body: Column(
// //         mainAxisAlignment: MainAxisAlignment.center,
// //         crossAxisAlignment: CrossAxisAlignment.center,
// //         children: [
// //           Image.asset(
// //             currentImage,
// //             height: 200,
// //             width: 200,
// //           ),
// //           // SizedBox(height: 20),
// //           // ElevatedButton(
// //           //   onPressed: () {
// //           //     // Set a new random image
// //           //     setRandomImage();
// //           //     // Reset the result
// //           //     setState(() {
// //           //       result = 0;
// //           //     });
// //           //   },
// //           //   child: Text('Get New Image'),
// //           // ),
// //           SizedBox(height: 20),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct
// //                   // Set a new random image

// //                   checkGuess(buttonNumbers[0]);
// //                   // Set a new random image

// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print("Bdmu"+counter.toString());
// //                   setRandomImage();
// //                   // Reset the result
// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[0]]}'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct
// //                   // Set a new random image

// //                   checkGuess(buttonNumbers[1]);
// //                   // Set a new random image
// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print(counter);
// //                   setRandomImage();
// //                   // Reset the result

// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[1]]}'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct
// //                   // Set a new random image

// //                   checkGuess(buttonNumbers[2]);
// //                   // Set a new random image
// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print(counter);
// //                   setRandomImage();
// //                   // Reset the result
// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[2]]}'),
// //               ),
// //             ],
// //           ),
// //           SizedBox(
// //             height: 20,
// //           ),
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct

// //                   checkGuess(buttonNumbers[3]);

// //                   // Set a new random image
// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print(counter);
// //                   setRandomImage();
// //                   // Reset the result

// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[3]]}'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct

// //                   checkGuess(buttonNumbers[4]);
// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print(counter);
// //                   setRandomImage();

// //                   // Reset the result
// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[4]]}'),
// //               ),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Check if the guess is correct
// //                   checkGuess(buttonNumbers[5]);
// //                   if (counter == 5) {
// //                     getResultScreen();
// //                   }
// //                   counter++;
// //                   print(counter);
// //                   setRandomImage();

// //                   // Reset the result
// //                   setState(() {
// //                     result = 0;
// //                   });
// //                 },
// //                 child: Text('${realbuttonNumbers[buttonNumbers[5]]}'),
// //               ),
// //             ],
// //           ),
// //           SizedBox(height: 20),

// //           Text(result == 1
// //               ? 'Correct Guess!'
// //               : result == 2
// //                   ? 'Incorrect Guess.'
// //                   : "Please select correct option"),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class ResultSCreen extends StatefulWidget {
// //   const ResultSCreen({super.key});

// //   @override
// //   State<ResultSCreen> createState() => _ResultSCreenState();
// // }

// // class _ResultSCreenState extends State<ResultSCreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold();
// //   }
// // }


// import 'dart:convert';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mediclear_labs/constants/api_domain.dart';
// import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;

// class ImageGuessingScreen extends StatefulWidget {
//   ImageGuessingScreen({required this.medical_id});
//   String medical_id;
//   @override
//   _ImageGuessingScreenState createState() => _ImageGuessingScreenState();
// }

// class _ImageGuessingScreenState extends State<ImageGuessingScreen> {
//   List<String> imageList = [
//     'assets/img_42.png',
//     'assets/color_blindness.png',
//     'assets/img_12.png',
//     'assets/img_2.png',
//     'assets/img_6.png',
//     'assets/img_27.png',
//     'assets/img_16.jpeg',
//     'assets/img_10.jpg',
//     'assets/img_9.png',
//     'assets/img_5.jpg',
//   ];
//   List<int> realbuttonNumbers = [
//     42,
//     74,
//     12,
//     2,
//     6,
//     27,
//     16,
//     10,
//     9,
//     5,
//   ];

//   String currentImage = '';
//   int correctAnswer = 0; // Index of the correct answer
//   int result = 0;
//   int counter = 0;

//   List<int> buttonNumbers = [];

//   List<bool> resultant = [];

//   @override
//   void initState() {
//     super.initState();
//     setRandomImage();
//     print(result);
//   }

//   Future getEyeTest(Object object) async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();
//     var token = pref.getString("token");
//     final response = await http.post(
//       Uri.parse("${ApiDomain().url}eyecheckup"),
//       body: jsonEncode(object),
//       headers: ({
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token'
//       }),
//     );
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Container(
//                 height: 200,
//                 child: Column(
//                   children: [
//                     Image.asset("assets/eye_icon2.png"),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Hurrah!!, Eye Test done sucessFully",
//                     )
//                   ],
//                 ),
//               ),
//             );
//           });
//     } else {
//       var data = jsonDecode(response.body);
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Container(
//                 height: 200,
//                 child: Column(
//                   children: [
//                     Image.asset("assets/eye_icon2.png"),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       "Test Failed",
//                     )
//                   ],
//                 ),
//               ),
//             );
//           });
//     }
//   }

//   void getResultScreen() {
//     var q1, q2, q3, q4, q5, q6, q7, q8, q9, q10;
//     q1 = resultant[0];
//     q2 = resultant[1];
//     q3 = resultant[2];
//     q4 = resultant[3];
//     q5 = resultant[4];
//     q6 = resultant[5];
//     q7 = resultant[6];
//     q8 = resultant[7];
//     q9 = resultant[8];
//     q10 = resultant[9];
//     var value = {
//       'q1': q1,
//       'q2': q2,
//       'q3': q3,
//       'q4': q4,
//       'q5': q5,
//       'q6': q6,
//       'q7': q7,
//       'q8': q8,
//       'q9': q9,
//       'q10': q10,
//       'medical_details_id': widget.medical_id,
//       'test_type_id': 1
//     };
//     getEyeTest(value);
//     Future.delayed(Duration(seconds: 5), () {
//       Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => VertigoTest(
//                     id: widget.medical_id,
//                   )));
//     });
//   }

//   void setRandomImage() {
//     Random random = Random();
//     int randomNumber = random.nextInt(imageList.length);

//     buttonNumbers = List<int>.generate(9, (index) => index);
//     print(buttonNumbers);

//     buttonNumbers.shuffle();

//     setState(() {
//       currentImage = imageList[randomNumber];
//       correctAnswer = randomNumber;
//     });
//   }

//   void checkGuess(int guess) {
//     // Check if the guessed index matches the correct answer
//     setState(() {
//       result = (guess == correctAnswer) ? 1 : 2;
//       resultant.add(guess == correctAnswer);
//       print(resultant);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Eye Testing Screen'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             currentImage,
//             height: 200,
//             width: 200,
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   checkGuess(buttonNumbers[0]);

//                   if (counter == 3) {
//                     getResultScreen();
//                   }
//                   counter++;
//                   print(counter);
//                   setRandomImage();
//                   // Reset the result
//                   setState(() {
//                     result = 0;
//                   });
//                 },
//                 child: Text('${realbuttonNumbers[buttonNumbers[0]]}'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   checkGuess(buttonNumbers[1]);
//                   if (counter == 3) {
//                     getResultScreen();
//                   }
//                   counter++;
//                   print(counter);
//                   setRandomImage();
//                   // Reset the result

//                   setState(() {
//                     result = 0;
//                   });
//                 },
//                 child: Text('${realbuttonNumbers[buttonNumbers[1]]}'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   checkGuess(buttonNumbers[2]);
//                   // Set a new random image
//                   if (counter == 3) {
//                     getResultScreen();
//                   }
//                   counter++;
//                   print(counter);
//                   setRandomImage();
//                   // Reset the result
//                   setState(() {
//                     result = 0;
//                   });
//                 },
//                 child: Text('${realbuttonNumbers[buttonNumbers[2]]}'),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           SizedBox(height: 20),
//           Text(result == 1
//               ? 'Correct Guess!'
//               : result == 2
//                   ? 'Incorrect Guess.'
//                   : "Please select correct option"),
//         ],
//       ),
//     );
//   }
// }

// class ResultSCreen extends StatefulWidget {
//   const ResultSCreen({super.key});

//   @override
//   State<ResultSCreen> createState() => _ResultSCreenState();
// }

// class _ResultSCreenState extends State<ResultSCreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }