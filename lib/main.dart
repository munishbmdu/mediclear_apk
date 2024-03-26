import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mediclear_labs/screens/hearing_test/screens/about.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/faqs.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_test.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_test2.dart';

import 'package:mediclear_labs/screens/hearing_test/screens/history_page.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/home_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/view.dart';
import 'package:mediclear_labs/screens/hearing_test/widgets/graph.dart';

import 'package:mediclear_labs/screens/splash_screen/splash_screen.dart';
import 'package:mediclear_labs/widgets/drawer/test_history.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(color: Colors.white),
      ),
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeTab(),
    HistoryTab(),
    FaqsTab(),
    AboutTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Mediclear',
          style: GoogleFonts.roboto(
              fontSize: 22, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: TextStyle(color: Colors.black),
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.question_answer,
              color: Colors.black,
            ),
            label: 'FAQs',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.info,
              color: Colors.black,
            ),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
