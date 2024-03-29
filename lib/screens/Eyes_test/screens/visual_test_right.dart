import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/api_domain.dart';
import '../../hearing_test/screens/vertigo_test.dart';

class VisualTestRight extends StatefulWidget {
  VisualTestRight({required this.medical_id});
  final String medical_id;

  @override
  _VisualTestRight createState() => _VisualTestRight();
}

class _VisualTestRight extends State<VisualTestRight> {
  List<Map<String, String>> imageList = [
    {'image': 'assets/n1.png', 'number': 'assets/n1.png'},
    {'image': 'assets/r22.png', 'number': 'assets/n2.png'},
    {'image': 'assets/r33.png', 'number': 'assets/n3.png'},
    {'image': 'assets/r44.png', 'number': 'assets/n4.png'},
    {'image': 'assets/r55.png', 'number': 'assets/n5.png'},
    {'image': 'assets/r66.png', 'number': 'assets/n6.png'},
    {'image': 'assets/r77.png', 'number': 'assets/n7.png'},
    {'image': 'assets/r88.png', 'number': 'assets/n8.png'},
    // {'image': 'assets/r9.png', 'number': 'assets/r9.png'},
    // {'image': 'assets/r10.png', 'number': 'assets/r10.png'},
  ];

  String currentImage = '';
  String correctAnswer = ''; // Number associated with the current image
  int result = 0;
  int counter = 0;

  List<String> buttonNumbers = [
    // 'assets/ritik1.png',
    // 'assets/ritik2.png' ,
    //  'assets/r3.png',
    //  'assets/r4.png',
    //  'assets/r5.png',
    //  'assets/r6.png',
    //  'assets/r7.png',
    //  'assets/r8.png',
    //  'assets/r9.png',
    //  'assets/r10.png'
  ];
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
      Uri.parse("${ApiDomain().url}righteyedistance"),
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
    var q1, q2, q3, q4, q5, q6, q7, q8;
    q1 = resultant[0];
    q2 = resultant[1];
    q3 = resultant[2];
    q4 = resultant[3];
    q5 = resultant[4];
    q6 = resultant[5];
    q7 = resultant[6];
    q8 = resultant[7];

    var value = {
      'q1': q1,
      'q2': q2,
      'q3': q3,
      'q4': q4,
      'q5': q5,
      'q6': q6,
      'q7': q7,
      'q8': q8,

      'medical_details_id': widget.medical_id,
      'test_type_id': 1,
      // Assuming 'results' is the key to store the result
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
    // Get a random image from the list
    Random random = Random();
    int randomNumber = random.nextInt(imageList.length);

    // Set the current image and its associated number
    setState(() {
      currentImage = imageList[randomNumber]['image']!;
      correctAnswer = imageList[randomNumber]['number']!;
    });

    // Create a list of three random numbers
    List<String> randomNumbers = [];
    for (int i = 0; i < 3; i++) {
      int randIndex = random.nextInt(imageList.length);
      randomNumbers.add(imageList[randIndex]['number']!);
    }

    // Shuffle the random numbers list
    randomNumbers.shuffle();

    // Ensure one of the random numbers matches the correct answer
    if (!randomNumbers.contains(correctAnswer)) {
      randomNumbers[random.nextInt(3)] = correctAnswer;
    }

    setState(() {
      buttonNumbers = randomNumbers;
    });
  }

  void checkGuess(String guess) {
    // Check if the guessed number matches the correct answer
    setState(() {
      result = (guess == correctAnswer) ? 1 : 2;
      resultant.add(guess == correctAnswer);
    });
    print("nannnn" + resultant.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Right Eye Testing Screen'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            height: 400,
            width: 400,
            // color: Colors.blue,
            child: Center(
              child: Image.asset(
                currentImage.toString(),
                // height: 400,
                // width: 400,
                // color: Colors.red,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            height: 60,
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Check if the guess is correct
                    checkGuess(buttonNumbers[index]);
                    // Set a new random image and buttons
                    setRandomImage();
                    // Reset the result
                    setState(() {
                      result = 0;
                    });
                    // Increment counter
                    counter++;
                    // Check if this is the last question
                    if (counter == 8) {
                      getResultScreen();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Container(
                      color: Colors.white,
                      width: 100,
                      height: 100,
                      child: Center(
                        child: Container(
                          height: 40,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Image.asset(
                            buttonNumbers[index],
                            height: 10,
                            width: 10,
                            // fit: BoxFit.cover,
                          ),
                          //  Image.asset(
                          //   imageList[index]['number'].toString(),
                          //   height: 400,
                          //   width: 400,
                          // ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
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
