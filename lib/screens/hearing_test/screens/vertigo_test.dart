import 'dart:convert';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/main.dart';
import 'package:mediclear_labs/screens/BPPV_test/bppv_testscreen1.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/eye_test_creen1.dart';
import 'package:mediclear_labs/screens/blood_pressure_test/Screens/blood_pressure_test.dart';
import 'package:mediclear_labs/screens/fakuda_unterberger_test/screens/fakuda_unterberger_test_screen1.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/home_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/test_screen1.dart';
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/register_customers_details/register_customers_details.dart';
import 'package:mediclear_labs/screens/romberg._test/romber_test_screen1.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:mediclear_labs/screens/vng_test/screens/vng_test_screen1.dart';
import 'package:mediclear_labs/widgets/custom_text_button.dart';
import 'package:mediclear_labs/widgets/legal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class VertigoTest extends StatefulWidget {
  VertigoTest(
      {super.key,
      this.val1,
      this.val2 = 0,
      this.val3,
      this.val4,
      this.val5,
      this.val6,
      this.val7,
      this.val8,
      this.id = "",
      this.batch_no = "",
      this.company_id = ""});
  // late String name;
  String id;
  int? val1;
  int? val2;
  int? val3;
  int? val4;
  int? val5;
  int? val6;
  int? val7;
  int? val8;
  String batch_no;
  String company_id;

  @override
  State<VertigoTest> createState() => _VertigoTestState();
}

class _VertigoTestState extends State<VertigoTest> {
  List itemList2 = [];
  Future getBanner() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    final response = await http.post(Uri.parse("${ApiDomain().url}banner"),
        headers: ({
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['banner'];
    } else {
      Text("Something went wrong");
    }
  }

  @override
  void initState() {
    super.initState();
    AutoOrientation.portraitAutoMode();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    print(widget.batch_no);
    return WillPopScope(
      onWillPop: () async {
        // SharedPreferences preferences = await SharedPreferences.getInstance();
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Are you sure?',
              style: TextStyle(color: Colors.blueGrey),
            ),
            content: Text(
              'Do you want to exit?',
              style: TextStyle(color: Colors.blueGrey),
            ),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: appcolor.redColor),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // backgroundColor: ,
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2)))),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailsScreenForRegisterCustomers(
                                batch_no: widget.batch_no,
                                company_id: widget.company_id,
                              )));
                },
                child: Text(
                  'Yes',
                  style: TextStyle(color: appcolor.redColor),
                ),
              ),
            ],
          ),
        );
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          // leading: IconButton(onPressed: (){

          //           // Navigator.push(context, route)
          //     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>()));
          //         }, icon:Icon(Icons.navigate_before,color: Colors.black,size: 35,)),
          centerTitle: true,
          title: Text(
            "MEDICLEAR",
            style: GoogleFonts.roboto(
                color: Coloors.fontcolor,
                fontWeight: FontWeight.bold,
                fontSize: 25),
          ),
          backgroundColor: Colors.white,
          toolbarHeight: 70,
          actions: [
            Image.asset("assets/mediclear.jpg"),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),

              FutureBuilder(
                  future: getBanner(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError || !snapshot.hasData)
                      return CarouselSlider(
                        items: itemList,
                        options: CarouselOptions(
                          height: 170.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          //  aspectRatio: 16 / 9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          // viewportFraction: 1,
                        ),
                      );
                    return CarouselSlider.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index, realIndex) {
                        return Container(
                          //child: Image.network(snapshot.data[index]['url']),
                          decoration: BoxDecoration(
                              color: Coloors.fontcolor,
                              border: Border.all(color: Colors.black),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      snapshot.data[index]['url']))),
                        );
                      },
                      options: CarouselOptions(
                        height: 170.0,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        //  aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        // viewportFraction: 1,
                      ),
                    );
                  }),
              SizedBox(
                height: 20,
              ),
              Text(
                "Please Select AnyOne of the test",
                style:
                    GoogleFonts.roboto(fontSize: 22, color: Coloors.fontcolor),
              ),
              SizedBox(
                height: 20,
              ),

              FutureBuilder(
                  future: test_button_validation("bp"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "Check for Blood pressure ",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Check for Blood pressure ",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BloodPressureTestCreen1(
                                            id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Check for Blood pressure ",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),

              //  Container(
              //   width: 280,
              //    child: CustomTextButton(text: "Measure Height", onTap:() {

              //          },),
              //  ),
              FutureBuilder(
                  future: test_button_validation("rt"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "Romberg Test",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Romberg Test",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RomberTestScreen1(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Romberg Test",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),

              FutureBuilder(
                  future: test_button_validation("eyecheckup"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "Eye Checkup",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Eye Checkup",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EyeTestScreen1(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Eye Checkup",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),
              FutureBuilder(
                  future: test_button_validation("hearingtest"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: " Hearing Test",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Hearing Test",
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          IndicatorWithScreens(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Hearing Test",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                // setState(() {});
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           IndicatorWithScreens(
                                //             medical_id: widget.id,
                                //           )),
                                // );
                              },
                            ),
                          );
                  }),
              FutureBuilder(
                  future: test_button_validation("flatfoot"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "FlatFoot Test",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "FlatFoot Test",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FlatFootTestScreen1(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "FlatFoot Test",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),

              //   widget.val4==null?
              // Container(
              //   width: 280,
              //   child: CustomTextButton(text: "Hearing Test", onTap:() {
              //       Navigator.pushReplacement(context,
              //                     MaterialPageRoute(builder: (context) => IndicatorWithScreens()),
              //                     );

              //   },),
              // ):Container(
              //   width: 280,
              //   child: CustomTextButton(text: "Hearing Test",colorr: Colors.grey,onTap:() {
              //     setState(() {

              //     });
              //       Navigator.pushReplacement(context,
              //                     MaterialPageRoute(builder: (context) => IndicatorWithScreens()),
              //                     );

              //   },),
              // ),

              //  Container(
              //   width: 280,
              //   child: CustomTextButton(text: "BPPV", onTap:() {

              //   },),
              // )
              //  widget.val5==null?
              //  Container(
              //   width: 280,
              //   child: CustomTextButton(text: "Romberg Test", onTap:() {
              //     Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => RomberTestScreen1(),));
              //   },),
              // ):  Container(
              //   width: 280,
              //   child: CustomTextButton(text: "Romberg Test", colorr: Colors.grey,onTap:() {
              //     Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) => RomberTestScreen1(),));
              //   },),
              // ),

              FutureBuilder(
                  future: test_button_validation("fukuda"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "Fakuda-Unterberger Test",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Fakuda-Unterberger Test",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          FakudaUnterbergerTestScreen1(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "Fakuda-Unterberger Test",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),

              widget.val7 == null
                  ? Container(
                      width: 280,
                      child: CustomTextButton(
                        text: "Videonystagmography Test",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VngTestScreen1(),
                              ));
                        },
                      ),
                    )
                  : Container(
                      width: 280,
                      child: CustomTextButton(
                        text: "Videonystagmography Test",
                        colorr: Colors.grey,
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VngTestScreen1(),
                              ));
                        },
                      ),
                    ),
              //   SizedBox(height: 20,),
              FutureBuilder(
                  future: test_button_validation("bppv"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container(
                        width: 280,
                        child: CustomTextButton(
                          text: "BPPV Test",
                          colorr: Colors.white,
                          onTap: () {},
                        ),
                      );
                    return snapshot.data == 0
                        ? Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "BPPV Test",
                              colorr: Colors.white,
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BppvTestScreen1(
                                            medical_id: widget.id,
                                          )),
                                );
                              },
                            ),
                          )
                        : Container(
                            width: 280,
                            child: CustomTextButton(
                              text: "BPPV Test",
                              colorr: Coloors.fontcolor,
                              fontcolor: Colors.white,
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: Container(
                                          height: 140,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "You have completed this test. Please contact to our team for performing this test again.",
                                                  softWrap: true,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Coloors
                                                                    .fontcolor),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                            ),
                          );
                  }),
              SizedBox(
                height: 20,
              ),

              TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Instructions'),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  '1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                ),
                                Text(
                                  '2. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                Text(
                                  '3. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                ),
                                Text(
                                  '4. Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                                ),
                                Text(
                                  '5. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                ),
                                Text(
                                  '6. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                                ),
                                // Add more terms and conditions as needed
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     setState(() {
                            //      //  termsAccepted = true; // Set termsAccepted to true on Accept
                            //     });
                            //     Navigator.of(context).pop(); // Close the dialog
                            //   },
                            //   child: Text('Accept'),
                            // ),
                          ],
                        );
                      },
                    );
                  },
                  child: Text("Read Instructions"))
            ],
          ),
        ),
      ),
    );
  }

  Future test_button_validation(String features) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    final response = await http.post(
      Uri.parse("${ApiDomain().url}check-access-test"),
      body: jsonEncode({
        'medical_details_id': widget.id,
        'test_type_id': 1,
        'features': features
      }),
      headers: ({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      print(response);

      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: id,val2: data['consumer_test_report']['test_type_id'],)));

      return data;
    } else {
      var data = jsonDecode(response.body);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                  child: Center(
                child: Text("Something went wrong!"),
              )),
            );
          });
    }
  }
}

final List<Widget> itemList = [
  Card(
    shadowColor: Colors.transparent,
    elevation: 5,
    child: Container(
      decoration: BoxDecoration(
          color: Coloors.fontcolor,
          border: Border.all(color: Colors.black),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: AssetImage(
            "assets/testing1.jpg",
          ))),
    ),
  ),
  Card(
    elevation: 5,
    child: Container(
      decoration: BoxDecoration(
          color: Coloors.fontcolor,
          border: Border.all(color: Colors.black),
          shape: BoxShape.rectangle,
          image: DecorationImage(
              image: AssetImage(
            "assets/display_test.png",
          ))),
    ),
  ),

  //Image.asset("assets/testing1.jpg",),
];
