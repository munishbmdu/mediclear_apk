import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/screen1.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/screen2.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/screen3.dart';

class IndicatorWithScreens extends StatefulWidget {
  IndicatorWithScreens({super.key, required this.medical_id});
  String medical_id;

  @override
  State<IndicatorWithScreens> createState() => _IndicatorWithScreensState();
}

class _IndicatorWithScreensState extends State<IndicatorWithScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.black,
              size: 35,
            )),
        centerTitle: true,
        elevation: 0,
      ),
      body: ScreenPager(
        medical_id: widget.medical_id,
      ),
    );
  }
}

class ScreenPager extends StatefulWidget {
  ScreenPager({super.key, required this.medical_id});
  String medical_id;
  @override
  _ScreenPagerState createState() => _ScreenPagerState();
}

class _ScreenPagerState extends State<ScreenPager> {
  PageController _controller = PageController(initialPage: 0);
  int currentPage = 0;
  final int pageCount = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void nextPage() {
    if (currentPage < pageCount - 1) {
      _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Divider(
              thickness: 2,
              color: Colors.grey.shade400,
            ),
            IndicatorDots(count: pageCount, currentPage: currentPage),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: pageCount,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: screens[index],
                  );
                },
              ),
            ),
            currentPage != 2
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.navigate_before_outlined,
                            size: 45,
                            color: Coloors.fontcolor,
                          ),
                          onPressed: previousPage,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.navigate_next_outlined,
                            size: 45,
                            color: Coloors.fontcolor,
                          ),
                          onPressed: nextPage,
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HearingTestGraphSCreen(
                                    medical_id: widget.medical_id,
                                  ),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Coloors.fontcolor),
                          child: Text(
                            "Move For the test",
                            style: GoogleFonts.roboto(),
                          )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class IndicatorDots extends StatelessWidget {
  final int count;
  final int currentPage;

  IndicatorDots({required this.count, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        count,
        (index) {
          return Padding(
            padding: EdgeInsets.all(5.0),
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (currentPage == index) ? Colors.green : Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<dynamic> screens = [
  Screen1(),
  Screen2(),
  Screen3(),
  //HearingTestGraphSCreen()
];
