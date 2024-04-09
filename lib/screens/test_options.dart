import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/eye_test_screen3.dart';
import 'package:mediclear_labs/screens/Eyes_test/screens/visual_test.dart';
import 'package:mediclear_labs/screens/application_form/screens/form.dart';
import 'package:mediclear_labs/screens/application_form/widgets/notification.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/graph_screen.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/register_customers_details/register_customers_details.dart';
import 'package:mediclear_labs/screens/vng_test/screens/screen/certificate.dart';
import 'package:mediclear_labs/widgets/custom_text_button.dart';
import 'package:mediclear_labs/widgets/drawer/feedback.dart';
import 'package:mediclear_labs/widgets/drawer/payment_history.dart';
import 'package:mediclear_labs/widgets/drawer/reset_password.dart';
import 'package:mediclear_labs/widgets/drawer/test_history.dart';
import 'package:mediclear_labs/widgets/drawer/user_profile.dart';
import 'package:mediclear_labs/widgets/legal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Future getCompany(Object value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    final response = await http.post(
      Uri.parse("${ApiDomain().url}corporate-company-list"),
      body: jsonEncode(value),
      headers: ({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print(data);

      return data['company'];
    } else if (response.statusCode == 404) {
      var data = jsonDecode(response.body);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("${data['message']} ")));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));
      });
    } else {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please check batch number")));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));
      });
    }
  }

  String comapny_id = "";

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return WillPopScope(
      onWillPop: () async {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final value = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Are you sure?',
                  style: GoogleFonts.poppins(color: Coloors.fontcolor),
                ),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'you want to exit?',
                  style: GoogleFonts.poppins(color: Colors.blueGrey),
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Coloors.fontcolor),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Coloors.fontcolor),
                    onPressed: () async {
                      await preferences.remove("token");
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
              )
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
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "MEDICLEAR",
            style: GoogleFonts.poppins(
                fontSize: 24,
                color: Coloors.fontcolor,
                fontWeight: FontWeight.bold),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: FutureBuilder(
                    future: ApiDomain().getProfileData(),
                    builder: (context, snapshot) {
                      return snapshot.data['type'] == "customer"
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            User_Profile()));
                              },
                              child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Coloors.fontcolor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: snapshot.data[
                                                      "customer_profile_image"] !=
                                                  "customer profile not updated"
                                              ? NetworkImage(
                                                  snapshot.data[
                                                      'customer_profile_image'],
                                                )
                                              : null,
                                          child: snapshot.data[
                                                      "customer_profile_image"] ==
                                                  "customer profile not updated"
                                              ? Icon(Icons.person)
                                              : null,
                                          backgroundColor: Colors.grey,
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              snapshot.data['name'].toString(),
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            //    Text("Logged in via ${snapshot.data['mobile_no']}",style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),),
                                            Text(
                                              "ID: ${snapshot.data['unique_id']}",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            )
                          : Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Coloors.fontcolor),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage: snapshot.data[
                                                  "customer_profile_image"] !=
                                              "customer profile not updated"
                                          ? NetworkImage(
                                              snapshot.data[
                                                  'customer_profile_image'],
                                            )
                                          : null,
                                      child: snapshot.data[
                                                  "customer_profile_image"] ==
                                              "customer profile not updated"
                                          ? Icon(Icons.person)
                                          : null,
                                      backgroundColor: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          snapshot.data['name'].toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                        //  Text("Logged in via ${snapshot.data['mobile_no']}",style: GoogleFonts.poppins(fontSize: 12,color: Colors.white),),
                                        Text(
                                          "ID: ${snapshot.data['unique_id']}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ));
                    }),
              ),
              listTile(
                  title: 'Home',
                  icon: Icons.home,
                  callback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TestScreen()));
                  }),
              FutureBuilder(
                  future: ApiDomain().getProfileData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container();
                    return snapshot.data['type'].toString().toLowerCase() ==
                            "customer".toLowerCase()
                        ? listTile(
                            title: 'Verified Certificate',
                            icon: Icons.messenger_outline,
                            callback: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    TextEditingController Certificate =
                                        TextEditingController();
                                    return AlertDialog(
                                      content: Container(
                                        height: 250,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Please Enter Your certificate Number",
                                              style: GoogleFonts.poppins(),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8),
                                                child: TextFormField(
                                                  controller: Certificate,
                                                  decoration: InputDecoration(
                                                      hintText: "********4223",
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  String data =
                                                      Certificate.text.trim();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          CertificatePage(
                                                              certificate:
                                                                  data),
                                                    ),
                                                  );
                                                  // _sendDataToAPI(data);
                                                },
                                                child: Text(
                                                  "Submit",
                                                  style: GoogleFonts.poppins(),
                                                ))
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            })
                        : Container();
                  }),
              listTile(
                  title: 'Registered Consumers',
                  icon: Icons.person,
                  callback: () {
                    TextEditingController batch = TextEditingController();
                    TextEditingController Company = TextEditingController();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Alert!"),
                            content: Container(
                              height: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Enter Your Batch No.",
                                    style: GoogleFonts.poppins(),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Coloors.fontcolor)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: TextFormField(
                                        controller: batch,
                                        decoration: InputDecoration(
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  FutureBuilder(
                                      future: ApiDomain().getProfileData(),
                                      builder: (context, snapshot) {
                                        if (!snapshot.hasData ||
                                            snapshot.hasError)
                                          return CircularProgressIndicator();
                                        return snapshot.data['type']
                                                    .toString()
                                                    .toLowerCase() !=
                                                "customer".toLowerCase()
                                            ? Column(
                                                children: [
                                                  Text(
                                                    "Enter Company Id",
                                                    style:
                                                        GoogleFonts.poppins(),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: Coloors
                                                                .fontcolor)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                      child: TextFormField(
                                                        controller: Company,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        onTap: () {
                                                          //    getCompany({"batch_no":batch.text.toString()});
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return AlertDialog(
                                                                    title: Text(
                                                                      "Please select Your Company",
                                                                      style: GoogleFonts
                                                                          .poppins(),
                                                                    ),
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          200,
                                                                      child:
                                                                          FutureBuilder(
                                                                              future: getCompany({
                                                                                'batch_no': batch.text.toString()
                                                                              }),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasError || !snapshot.hasData)
                                                                                  return Center(
                                                                                    child: CircularProgressIndicator(),
                                                                                  );
                                                                                return ListView.builder(
                                                                                    itemCount: snapshot.data.length,
                                                                                    itemBuilder: (context, index) {
                                                                                      return ListTile(
                                                                                        title: Text("${snapshot.data[index]['company_name']}"),
                                                                                        subtitle: Text(
                                                                                          "Company Id: ${snapshot.data[index]['company_id']}",
                                                                                          style: GoogleFonts.poppins(
                                                                                            color: Coloors.fontcolor,
                                                                                          ),
                                                                                        ),
                                                                                        onTap: () {
                                                                                          Company.text = snapshot.data[index]['company_name'];
                                                                                          comapny_id = snapshot.data[index]['company_id'];
                                                                                          Navigator.pop(context);
                                                                                        },
                                                                                      );
                                                                                    });
                                                                              }),
                                                                    ));
                                                              });
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            : Container();
                                      }),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    print(batch.text.trim());
                                    if (batch.text.trim() != "")
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DetailsScreenForRegisterCustomers(
                                                    batch_no: batch.text.trim(),
                                                    company_id: comapny_id,
                                                  )));
                                    //showBottomSheet(context: context, builder:(context){
                                    //   return Container(
                                    //     child: Text("Please enter Your Batch Number"),
                                    //   );
                                    // });
                                  },
                                  child: Text(
                                    "submit",
                                    style: GoogleFonts.poppins(),
                                  )),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Cancel",
                                    style: GoogleFonts.poppins(),
                                  )),
                            ],
                          );
                        });
                  }),
              listTile(
                  title: 'Test History',
                  icon: Icons.history_outlined,
                  callback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TextHistory()));
                  }),
              FutureBuilder(
                  future: ApiDomain().getProfileData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container();
                    return snapshot.data['type'] == "customer"
                        ? listTile(
                            title: 'Payment History',
                            icon: Icons.password_outlined,
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentHistory()));
                            })
                        : Container();
                  }),
              listTile(
                  title: 'Complain & feedback',
                  icon: Icons.message_outlined,
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedBack(),
                        ));
                  }),
              listTile(
                  title: 'Notification',
                  icon: Icons.notification_add,
                  callback: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => notifcation()));
                  }),
              FutureBuilder(
                  future: ApiDomain().getProfileData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.hasError)
                      return Container();
                    return snapshot.data['type'] == "customer"
                        ? listTile(
                            title: 'Reset Password',
                            icon: Icons.password_outlined,
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => reset_password()));
                            })
                        : Container();
                  }),
              listTile(
                title: "Terms & Conditions",
                icon: (Icons.report),
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => termsandCondition()));
                },
              ),
              Divider(
                height: 2,
                color: Colors.grey.shade400,
              ),
              listTile(
                  title: 'Logout',
                  icon: Icons.logout_outlined,
                  callback: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Alert',
                              style: GoogleFonts.poppins(),
                            ),
                            content: Text('Are you sure exit?'),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await preferences.remove('token');
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            '/login',
                                            (route) => false);
                                        // Navigator.pushReplacement(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             LoginOptionsToggleButton()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Coloors.fontcolor),
                                      child: Text(
                                        'Yes',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Coloors.fontcolor),
                                      child: Text(
                                        'No',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              )
                            ],
                          );
                        });
                    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>mainPage()));
                  }),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Image.asset("assets/display_test.png")),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Available Test:",
                  style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
                ),
              ),

              Container(
                width: 250,
                child: CustomTextButton(
                  text: "Vertigo checkup",
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>

                          // VertigoTest(),

                          MyForm(),
                      //     HearingTestGraphSCreen(
                      //   medical_id: "",
                      // ),
                    ));
                  },
                ),
              ),
              // Container(
              //   width: 250,
              //   child: CustomTextButton(
              //     text: "Corporate checkup",
              //     onTap: () {},
              //   ),
              // ),
              // Container(
              //   width: 250,
              //   child: CustomTextButton(
              //     text: "Telecome checkup",
              //     onTap: () {},
              //   ),
              // ),

              // Container(
              //   width: 250,
              //   child: CustomTextButton(
              //     text: "FirstAid Training ",
              //     onTap: () {},
              //   ),
              // ),
              // Text("Hellooo")
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendDataToAPI(String data) async {
    final url = Uri.parse('https://qbacp.com/mediclear/api/get-report');
    final response = await http.post(
      url,
      body: jsonEncode({'certification': data}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Data sent successfully');
      print(response.body);
    } else {
      print('Failed to send data: ${response.statusCode}');
    }
  }
}
