import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/main.dart';
import 'package:mediclear_labs/screens/application_form/widgets/datetime.dart';
import 'package:mediclear_labs/screens/application_form/widgets/drop_down_menu.dart';
import 'package:mediclear_labs/screens/application_form/widgets/notification.dart';
import 'package:mediclear_labs/screens/login_page/login_toggle_button.dart';
import 'package:mediclear_labs/screens/payment_screen/upi_screen.dart';
import 'package:mediclear_labs/screens/register_customers_details/register_customers_details.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/widgets/camera.dart';
import 'package:mediclear_labs/screens/application_form/widgets/galary_signature.dart';
import 'package:mediclear_labs/screens/application_form/widgets/geneder_checkbox.dart';
import 'package:mediclear_labs/screens/application_form/widgets/past_medical_history.dart';
import 'package:mediclear_labs/screens/application_form/widgets/phone_number_enter.dart';
import 'package:mediclear_labs/widgets/drawer/payment_history.dart';
import 'package:mediclear_labs/widgets/drawer/feedback.dart';
import 'package:mediclear_labs/widgets/drawer/reset_password.dart';
import 'package:mediclear_labs/widgets/drawer/terms_conditions.dart';
import 'package:mediclear_labs/widgets/drawer/test_history.dart';
import 'package:mediclear_labs/widgets/drawer/user_profile.dart';
import 'package:mediclear_labs/widgets/legal.dart';
import 'package:mediclear_labs/widgets/signature.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import 'package:url_launcher/url_launcher.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController clientAdhharController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController clientAccountController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  bool question1 = false;
  bool question2 = false;
  bool question3 = false;
  bool question4 = false;
  bool question5 = false;
  bool question6 = false;
  bool question7 = false;
  bool isLoading = true;

  String opt1 = "";
  String opt2 = "";

  String opt3 = "";
  String opt4 = "";

  String opt5 = "";
  String opt6 = "";

  String opt7 = "";
  List pre1 = [];
  List pre2 = [];
  List pre3 = [];
  List prep4 = [];
  List complaint = [];

  bool question8 = false;
  bool questionn1 = false;
  bool questionn2 = false;
  bool questionn3 = false;
  bool questionn4 = false;
  bool questionn5 = false;
  bool questionn6 = false;
  bool questionn7 = false;
  bool questionn8 = false;
  bool pastquestion1 = false;
  bool pastquestion2 = false;
  bool pastquestion3 = false;
  bool pastquestion4 = false;
  bool pastquestion5 = false;
  bool termsAccepted = false;
  List<int> options = [1, 2, 3];
  File? imageFile;
  File? imageFile2;
  var comapny_id = "";
  var value;
  var type;

  late String name = "";
  _makingPhoneCall() async {
    var url = Uri.parse("tel:9667371301");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showSignatureDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Coloors.fontcolor),
              onPressed: () {
                setState(() {
                  _controller.clear();
                  _signatureBytes = null;
                });
              },
              child: const Text('Clear'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Coloors.fontcolor),
              onPressed: () {
                setState(() {
                  _controller.undo();
                });
              },
              child: const Text('undo'),
            ),
            ElevatedButton(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Coloors.fontcolor),
              onPressed: () {
                SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                _controller.toPngBytes().then((signatureBytes) {
                  setState(() {
                    _signatureBytes = signatureBytes;
                  });
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Done'),
            ),
          ],
          content: Container(
            height: 200,
            width: 1000,
            child: Signature(
              controller: _controller,
              height: 200,
              width: 1000,
              backgroundColor: Colors.grey.shade300,
            ),
          ),
        );
      },
    );
  }

  int notification_count = 0;
  // Future getNotificationCount()async {
  //     final SharedPreferences pref= await SharedPreferences.getInstance();
  //   var token=pref.getString("token");
  //   final response=await http.post(Uri.parse("${ApiDomain().url}newnotification"),
  //   headers: ({
  //    'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token'
  //   }),
  //   );
  //   if(response.statusCode==200)
  //   {
  //     var data=jsonDecode(response.body);
  //     notification_count=data['notifications'];
  //   }

  // }

  void _showTermsAndConditionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Terms and Conditions'),
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
            ElevatedButton(
              onPressed: () {
                setState(() {
                  termsAccepted = true; // Set termsAccepted to true on Accept
                });
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Accept'),
            ),
          ],
        );
      },
    );
  }
  //

  @override
  void dispose() {
    nameController.dispose();
    companyController.dispose();
    locationController.dispose();
    clientAccountController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    //  getNotificationCount();
    super.initState();
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Uint8List? _signatureBytes;

  @override
  Widget build(BuildContext context) {
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
                  'Do you want to exit?',
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
                        backgroundColor: Coloors.fontcolor,
                        shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TestScreen()));
                    },
                    child: Text(
                      'Yes',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Coloors.fontcolor,
                        shape: BeveledRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(2)))),
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      'No',
                      style: GoogleFonts.poppins(color: Colors.white),
                    ),
                  ),
                ],
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          foregroundColor: Colors.white,
          // leading: IconButton(onPressed:() {

          // }, icon: Icon(Icons.menu)),
          toolbarHeight: 60,
          backgroundColor: Colors.white30,

          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 0),
              child: Container(
                height: 80,
                width: 70,
                child: Image.asset("assets/mediclear.jpg"),
              ),
            ),
            Stack(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => notifcation(),
                          ));
                    },
                    child: Icon(
                      Icons.notifications,
                      size: 30,
                    )),
                // Positioned(
                //            right: 0,
                //            top: -1,
                //            child: Container(

                //              decoration: BoxDecoration(

                //                shape: BoxShape.circle,
                //                color: Colors.green,
                //              ),
                //              child: Padding(
                //                padding: const EdgeInsets.all(4.0),
                //                child: Text(
                //    "${notification_count<9?notification_count:"9+"}",
                //  style: TextStyle(color: Colors.white,fontSize: 12),
                //                ),
                //              ),
                //            ),
                //          ),
                StreamBuilder(
                    stream: Stream.periodic(Duration(seconds: 5))
                        .asyncMap((i) => ApiDomain().getNotificationCount()),
                    // future:ApiDomain().getNotificationCount(),
                    builder: (context, snapshot) {
                      print(snapshot.data);
                      if (!snapshot.hasData || snapshot.hasError)
                        return Positioned(
                          right: 0,
                          top: -2,
                          child: Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                            child: Text(
                              notification_count.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        );
                      notification_count = snapshot.data;
                      return Positioned(
                        right: 0,
                        top: -2,
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                          ),
                          child: Text(
                            "${notification_count < 9 ? notification_count : "9+"}",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      );
                    })
              ],
            ),
            IconButton(
                onPressed: () {
                  _makingPhoneCall();
                },
                icon: Icon(Icons.call_outlined)),
          ],
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
                      type = snapshot.data['type'];
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
                                        Text(
                                          "Logged in via ${snapshot.data['mobile_no']}",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
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
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Submit"))
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
                                  Text("Enter Your Batch No."),
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
                                                  Text("Enter Company Id"),
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
                                                                    ),
                                                                    content:
                                                                        Container(
                                                                      height:
                                                                          250,
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
                                                                                          style: TextStyle(color: Coloors.fontcolor),
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
                                  child: Text("submit")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancel")),
                            ],
                          );
                        });
                  }),
              listTile(
                  title: ' Test History',
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
                    return snapshot.data['type'].toString().toLowerCase() ==
                            "customer".toLowerCase()
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
                    return snapshot.data['type'].toString().toLowerCase() ==
                            "customer".toLowerCase()
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
                            title: Text('Alert'),
                            content: Text('Are you sure exit?'),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        await preferences.remove('token');
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginOptionsToggleButton()));
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Coloors.fontcolor),
                                      child: Text('Yes')),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Coloors.fontcolor),
                                      child: Text('No')),
                                ],
                              )
                            ],
                          );
                        });
                  }),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 205,
                            child: TextFormField(
                              controller: nameController,
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: GoogleFonts.poppins()),
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 205,

                                child: TextFormField(
                                  //  initialValue:"",
                                  controller: batchController,
                                  decoration: InputDecoration(
                                      hintText: 'Batch number',
                                      hintStyle: GoogleFonts.poppins()),
                                  keyboardType: TextInputType.emailAddress,

                                  //
                                ),

                                //
                              ),
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        highlightColor: Colors.transparent,
                        enableFeedback: false,
                        onTap: () async {
                          Map<Permission, PermissionStatus> statuses = await [
                            Permission.storage,
                            Permission.camera,
                          ].request();
                          if (statuses[Permission.storage]!.isGranted &&
                              statuses[Permission.camera]!.isGranted) {
                            showImagePicker(context);
                          } else {
                            print('no permission provided');
                          }
                        },
                        child: imageFile == null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                ),
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.person_add_alt,
                                      size: 80,
                                    )),
                              )
                            : Stack(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Image.file(
                                        imageFile!,
                                        height: 110.0,
                                        width: 110.0,
                                        fit: BoxFit.fill,
                                      )),
                                  Positioned(
                                      top: -15,
                                      right: -10,
                                      child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              imageFile = null;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Coloors.fontcolor,
                                          )))
                                ],
                              ),
                      ),
                    ],
                  ),

                  FutureBuilder(
                      future: ApiDomain().getProfileData(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.hasError)
                          return Container();
                        return snapshot.data['type'] != "customer"
                            ? TextField(
                                controller: companyController,
                                onTap: () {
                                  getCompany(value = {
                                    "batch_no": batchController.text.toString()
                                  });
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text(
                                              "Please select Your Company",
                                              style: GoogleFonts.poppins(),
                                            ),
                                            content: Container(
                                              height: 200,
                                              child: FutureBuilder(
                                                  future: getCompany(value = {
                                                    'batch_no': batchController
                                                        .text
                                                        .toString()
                                                  }),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasError ||
                                                        !snapshot.hasData)
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    return ListView.builder(
                                                        itemCount: snapshot
                                                            .data.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return ListTile(
                                                            title: Text(
                                                                "${snapshot.data[index]['company_name']}"),
                                                            subtitle: Text(
                                                              "Company Id: ${snapshot.data[index]['company_id']}",
                                                              style: TextStyle(
                                                                  color: Coloors
                                                                      .fontcolor),
                                                            ),
                                                            onTap: () {
                                                              companyController
                                                                  .text = snapshot
                                                                          .data[
                                                                      index][
                                                                  'company_name'];
                                                              comapny_id = snapshot
                                                                          .data[
                                                                      index][
                                                                  'company_id'];
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          );
                                                        });
                                                  }),
                                            ));
                                      });
                                },
                                decoration: InputDecoration(
                                    hintText: "Company",
                                    hintStyle: GoogleFonts.poppins()
                                    //  suffixIcon: PopupMenuButton<String>(
                                    //    icon: const Icon(Icons.arrow_drop_down),
                                    //    onSelected: (String value) {
                                    //      companyController.text = value;
                                    //    },
                                    //    itemBuilder: (BuildContext context) {
                                    //      return items
                                    //          .map<PopupMenuItem<String>>((String value) {
                                    //        return new PopupMenuItem(
                                    //            child: new Text(value), value: value);
                                    //      }).toList();
                                    //    },
                                    //  ),
                                    ),
                              )
                            : Container();
                      }),

                  TextFormField(
                    controller: locationController,
                    decoration: InputDecoration(
                        hintText: 'Location', hintStyle: GoogleFonts.poppins()),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  PhoneNumberInput(
                    phoneNumberController: phoneController,
                  ),

                  //DateTimer(),
                  // DOBWidget(
                  //   dobController: dobController,
                  // ),
                  TextField(
                    controller: dobController,
                    decoration: InputDecoration(
                      hintText: "D.O.B", //label text of field
                      hintStyle:
                          TextStyle(color: Colors.grey.shade600, fontSize: 17),
                    ),
                    readOnly: true,
                    //set it true, so that user will not able to edit text
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        setState(() {
                          dobController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {}
                    },
                  ),

                  TextFormField(
                    controller: clientAdhharController,
                    decoration: InputDecoration(
                        hintText: "Addhar Number",
                        hintStyle: GoogleFonts.poppins()),
                    // decoration: const InputDecoration(labelText: 'Addhar Number'),
                    keyboardType: TextInputType.number,
                    maxLength: 12,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: GoogleFonts.poppins(
                            color: Colors.grey.shade700, fontSize: 16),
                      ),
                      GenderSelection(
                        genderController: genderController,
                      ),
                    ],
                  ),

                  const SizedBox(height: 25.0),
                  Text(
                    'To be filled by the candidate before Medical Examination:',
                    style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    ' A. When you are "dizzy" do you experience any of the following symptoms? (check yes or no)',
                    textAlign: TextAlign.start,
                    style:
                        GoogleFonts.poppins(color: Colors.black, fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // SizedBox(width: 100,),
                        Text(
                          "Yes",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "No",
                          style: GoogleFonts.poppins(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          '1. Light-headedness or swim  \n    sensation in the head?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question1,
                            onChanged: (value) {
                              setState(() {
                                question1 = value!;
                                opt1 = "yes";
                                if (question1) {
                                  questionn1 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn1,
                            onChanged: (value) {
                              setState(() {
                                questionn1 = value!;
                                opt1 = "no";
                                if (questionn1) {
                                  question1 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),

                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          '2. Blacking out or loss of         \n    Consciousness ?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question2,
                            onChanged: (value) {
                              setState(() {
                                question2 = value!;
                                opt2 = "yes";
                                if (question2) {
                                  questionn2 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn2,
                            onChanged: (value) {
                              setState(() {
                                questionn2 = value!;
                                opt2 = "no";
                                if (questionn2) {
                                  question2 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          '3. Object spinning or turning   \n     around you?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question3,
                            onChanged: (value) {
                              setState(() {
                                question3 = value!;
                                opt3 = "yes";
                                if (question3) {
                                  questionn3 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn3,
                            onChanged: (value) {
                              setState(() {
                                questionn3 = value!;
                                opt3 = "no";
                                if (questionn3) {
                                  question3 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: 60,
                    child: Row(
                      children: [
                        Text(
                          '4. Nausea or vomiting               ',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question4,
                            onChanged: (value) {
                              setState(() {
                                question4 = value!;
                                opt4 = "yes";
                                if (question4) {
                                  questionn4 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn4,
                            onChanged: (value) {
                              setState(() {
                                questionn4 = value!;
                                opt4 = "no";
                                if (questionn4) {
                                  question4 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          '5. Tingling in your fingers, toes\n     or around your mouth?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question5,
                            onChanged: (value) {
                              setState(() {
                                question5 = value!;
                                opt5 = "yes";

                                if (question5) {
                                  questionn5 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn5,
                            onChanged: (value) {
                              setState(() {
                                questionn5 = value!;
                                opt5 = "no";
                                if (questionn5) {
                                  question5 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: 55,
                    child: Row(
                      children: [
                        Text(
                          '6. Does change of Position       \n     make you dizzy?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question6,
                            onChanged: (value) {
                              setState(() {
                                question6 = value!;
                                opt6 = "yes";
                                if (question6) {
                                  questionn6 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn6,
                            onChanged: (value) {
                              setState(() {
                                questionn6 = value!;
                                opt6 = "no";
                                if (questionn6) {
                                  question6 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    child: Row(
                      children: [
                        Text(
                          '7. when you are dizzy,must      \n    support yourself when\n    standing?',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Checkbox(
                            value: question7,
                            onChanged: (value) {
                              setState(() {
                                question7 = value!;
                                opt7 = "yes";
                                if (question7) {
                                  questionn6 = false;
                                }
                              });
                            }),
                        Checkbox(
                            value: questionn7,
                            onChanged: (value) {
                              setState(() {
                                questionn7 = value!;
                                opt7 = "no";
                                if (questionn7) {
                                  question6 = false;
                                }
                              });
                            }),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  PastMedicalHistory(
                    que1: pre1,
                    que2a: pre2,
                    que2b: pre3,
                    que2c: prep4,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Complaint:',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.start,
                  ),

                  Complaints(
                    complain: complaint,
                  ),

                  const SizedBox(height: 20.0),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Coloors.fontcolor),
                                onPressed: () {
                                  setState(() {
                                    _showSignatureDialog();
                                  });
                                },
                                child: const Text(
                                  'Sign Here',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 20),
                              _signatureBytes != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),

                                            //borderRadius: BorderRadius.circular(10)
                                          ),
                                          child: Image.memory(
                                            _signatureBytes!,
                                            width: 180,
                                            height: 40,
                                          ),
                                        ),
                                        Text(
                                          "Please clear sign to upload from gallery!!",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Coloors.fontcolor),
                                        )
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        Map<Permission, PermissionStatus>
                                            statuses = await [
                                          Permission.storage,
                                          Permission.camera,
                                        ].request();
                                        if (statuses[Permission.storage]!
                                                .isGranted &&
                                            statuses[Permission.camera]!
                                                .isGranted) {
                                          showSignPicker(context);
                                        } else {
                                          print('no permission provided');
                                        }
                                      },
                                      child: Column(
                                        children: [
                                          imageFile2 == null
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 20,
                                                  ),
                                                  child: Container(
                                                      child: Text(
                                                    "Upload Sign",
                                                    style: TextStyle(
                                                        color:
                                                            Coloors.fontcolor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                )
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey)),
                                                  child: Image.file(
                                                    imageFile2!,
                                                    height: 40.0,
                                                    width: 140.0,
                                                    fit: BoxFit.fill,
                                                  )),
                                        ],
                                      ),
                                    )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                TextEditingController batch =
                                    TextEditingController();
                                TextEditingController Company =
                                    TextEditingController();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Alert!"),
                                        content: Container(
                                          height: 200,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("Enter Your Batch No."),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color:
                                                            Coloors.fontcolor)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: TextFormField(
                                                    controller: batch,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              FutureBuilder(
                                                  future: ApiDomain()
                                                      .getProfileData(),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData ||
                                                        snapshot.hasError)
                                                      return CircularProgressIndicator();
                                                    return snapshot.data['type']
                                                                .toString()
                                                                .toLowerCase() !=
                                                            "customer"
                                                                .toLowerCase()
                                                        ? Column(
                                                            children: [
                                                              Text(
                                                                  "Enter Company Id"),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    border: Border.all(
                                                                        width:
                                                                            1,
                                                                        color: Coloors
                                                                            .fontcolor)),
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          8),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        Company,
                                                                    decoration:
                                                                        InputDecoration(
                                                                            border:
                                                                                InputBorder.none),
                                                                    onTap: () {
                                                                      //    getCompany({"batch_no":batch.text.toString()});
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return AlertDialog(
                                                                                title: Text("Please select Your Company"),
                                                                                content: Container(
                                                                                  height: 200,
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
                                                                                                      style: TextStyle(color: Coloors.fontcolor),
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
                                                if (batch.text.trim() != "")
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DetailsScreenForRegisterCustomers(
                                                                batch_no: batch
                                                                    .text
                                                                    .trim(),
                                                                company_id:
                                                                    comapny_id,
                                                              )));
                                                //showBottomSheet(context: context, builder:(context){
                                                //   return Container(
                                                //     child: Text("Please enter Your Batch Number"),
                                                //   );
                                                // });
                                              },
                                              child: Text("submit")),
                                          ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel")),
                                        ],
                                      );
                                    });
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Coloors.fontcolor),
                              child: Text(
                                "Consumer details",
                                style: GoogleFonts.poppins(color: Colors.white),
                              )),
                          isLoading
                              ? ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      print('Name: ${nameController.text}');
                                      print(
                                          'Company: ${companyController.text}');
                                      print(
                                          'Location: ${locationController.text}');
                                      print(
                                          'Client Account: ${clientAccountController.text}');
                                      print('Gender: ${genderController.text}');
                                      print('Question 1: $question1');
                                      print('Question 2: $question2');

                                      //  nameController.clear();
                                      //  companyController.clear();
                                      //  locationController.clear();
                                      //  clientAccountController.clear();

                                      if (batchController.text
                                                  .trim()
                                                  .toString() !=
                                              "" ||
                                          nameController.text
                                                  .trim()
                                                  .toString() !=
                                              "" ||
                                          dobController.text
                                                  .trim()
                                                  .toString() !=
                                              "" ||
                                          clientAdhharController.text
                                                  .trim()
                                                  .toString() !=
                                              "" ||
                                          genderController.text
                                                  .trim()
                                                  .toString() !=
                                              "") {
                                        setState(() {
                                          isLoading = false;
                                        });

                                        var batch = batchController.text.trim();

                                        var name = nameController.text
                                            .trim()
                                            .toString();
                                        var location = locationController.text
                                            .trim()
                                            .toString();
                                        var mobile =
                                            phoneController.text.trim();
                                        var dob = dobController.text
                                            .trim()
                                            .toString();
                                        var addhar =
                                            clientAdhharController.text.trim();
                                        var gender = genderController.text
                                            .trim()
                                            .toString();
                                        var light = opt1;
                                        var black = opt2;
                                        var object = opt3;
                                        var nausea = opt4;
                                        var tingling = opt5;
                                        var does = opt6;
                                        var when = opt7;
                                        var list1 = pre1;
                                        var list2 = pre2;
                                        var list3 = pre3;
                                        var list4 = prep4;
                                        var list5 = complaint;
                                        //   'consumer_profile_image':,

                                        sendImageToServer(
                                            name,
                                            batch,
                                            mobile,
                                            location,
                                            addhar,
                                            light,
                                            black,
                                            object,
                                            gender,
                                            nausea,
                                            tingling,
                                            does,
                                            when,
                                            dob,
                                            list1,
                                            list2,
                                            list3,
                                            list4,
                                            list5);
                                        setState(() {
                                          isLoading = true;
                                        });
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Please Filled all the details before submit the form")));
                                      }

                                      //   print(value);
                                      //   getUserRegister(value);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Coloors.fontcolor),
                                  child: Text(
                                    'Submit',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white),
                                  ),
                                )
                              : CircularProgressIndicator()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> sendImageToServer(
      String name,
      batch,
      mob,
      location,
      adhhar,
      option1,
      option2,
      option3,
      gender,
      option4,
      option5,
      option6,
      option7,
      dob,
      List list1,
      List list2,
      list3,
      list4,
      list5) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    //var images= File('image.jpg').writeAsBytes(_signatureBytes!);

    var uri = Uri.parse(
        'https://qbacp.com/mediclear/api/add-consumer-medical-details'); // Replace with your server's endpoint
    var request = http.MultipartRequest("POST", uri);
    //..files.add(await http.MultipartFile.fromPath('consumer_profile_image', imageFile!.path));

    request.headers['Authorization'] = 'Bearer ' + '$token';
    if (imageFile != null)
      request.files.add(await http.MultipartFile.fromPath(
          'consumer_profile_image', imageFile!.path));
    if (imageFile2 != null)
      request.files.add(await http.MultipartFile.fromPath(
          'consumer_sign_image', imageFile2!.path));
    // if(_signatureBytes!=null)
    // request.files.add(await http.MultipartFile.fromPath('consumer_sign_image_name',images.toString()));
    request.fields['consumer_name'] = name;
    request.fields['batch_no'] = '$batch';
    request.fields['company_id'] = '$comapny_id';
    request.fields['consumer_mob_no'] = '$mob';
    request.fields['test_type_id'] = '${1}';
    request.fields['consumer_location'] = '$location';
    request.fields['consumer_addhar_number'] = '$adhhar';
    request.fields['light_hedness_or_swim_sensation_in_the_head'] = '$option1';
    request.fields['blacking_out_or_loss_of_consciousness'] = '$option2';
    request.fields['object_spinning_or_turning_around_you'] = '$option3';
    request.fields['consumer_profile_image'] = '$imageFile';
    request.fields['gender'] = '$gender';
    request.fields['nausea_or_vomiting'] = '$option4';
    request.fields['consumer_dob'] = '$dob';
    request.fields['tingling_in_your_fingers_toes_around_your_mouth'] =
        '$option5';
    request.fields['does_changes_of_position_make_you_dizzy'] = '$option6';
    request.fields['when_you_are_dizzy_must_support_yourself_when_standing'] =
        '$option7';
    request.fields['post_mediacal_history_disease'] = '$list1';
    request.fields['defficulting_in_hearing'] = '$list2';
    request.fields['noise_in_ears'] = '$list3';
    request.fields['fullness_or_stuffiness_in_your_ears'] = '$list4';
    request.fields['complaint'] = '$list5';

    // request.fields['category']= '$choose';
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      var rest = jsonDecode(res.body);
      print(res.body);
      if (rest['status'] == "success") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${rest['message']}')));
        //Navigator.pop(context);
        // if(type.toString().toLowerCase()=="customer".toLowerCase())
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>CustomerDetailsScreen(batch_no: batch)));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => DetailsScreenForRegisterCustomers(
                      batch_no: batch,
                      company_id: comapny_id,
                    )));
        // Get.offAll(Home_view());
      }
    } else if (response.statusCode == 404) {
      final res = await http.Response.fromStream(response);
      var rest = jsonDecode(res.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${rest['message']}')));
    } else if (response.statusCode == 403) {
      final res = await http.Response.fromStream(response);
      var rest = jsonDecode(res.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${rest['message']}')));
    } else {
      // alertBoxdialogBox(context, 'Alert', '${rest['message']}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Registration not sucessfull,please check your details')));
    }
  }

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
        //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));
        Navigator.pop(context);
      });
    } else {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please check batch number")));
      Future.delayed(Duration(seconds: 3), () {
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));
        Navigator.pop(context);
      });
    }
  }

  final picker2 = ImagePicker();

  void showSignPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery() async {
    await picker2
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker2
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(
    File imgFile,
  ) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile2 = File(croppedFile.path);
      });
      // reload();
    }
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                                fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        _imgFromGallery2();
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        _imgFromCamera2();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  _imgFromGallery2() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage2(File(value.path));
      }
    });
  }

  _imgFromCamera2() async {
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage2(File(value.path));
      }
    });
  }

  File? returnImageFile() {
    return imageFile;
  }

  _cropImage2(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
        //returnImageFile();
      });
      // reload();
    }
  }
}

Widget listTile({String? title, icon, Function()? callback}) {
  return ListTile(
    onTap: callback,
    title: Text(
      '$title',
      style: GoogleFonts.poppins(fontWeight: FontWeight.w300, fontSize: 18),
    ),
    leading: Icon(
      icon,
      color: Coloors.fontcolor,
    ),
  );
}

//  Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(11),
//             border: Border.all(color: Colors.grey)
//         ),
//         height: MediaQuery.of(context).size.height*0.06,
//         width: MediaQuery.of(context).size.width*0.89,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width*0.77,
//                   child: 
//                  TextField(
//                     controller: dateInput,
//                     //editing controller of this TextField
//                     decoration: InputDecoration(
//                       //icon of text field
//                       border:InputBorder.none,
//                       hintText: "D.O.B", //label text of field
//                       hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 17),
//                     ),
//                     readOnly: true,
//                     //set it true, so that user will not able to edit text
//                     onTap: () async {
//                       DateTime? pickedDate = await showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime(1950),
//                           //DateTime.now() - not to allow to choose before today.
//                           lastDate: DateTime.now());

//                       if (pickedDate != null) {
//                         print(
//                             pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
//                         String formattedDate =
//                         DateFormat('yyyy-MM-dd').format(pickedDate);
//                         print(
//                             formattedDate); //formatted date output using intl package =>  2021-03-16
//                         setState(() {
//                           dateInput.text =
//                               formattedDate; //set output date to TextField value.
//                         });
//                       } else {}
//                     },
//                   ),
//                 ),
//                 Icon(Icons.calendar_month)
//               ],
//             ),
//           ),
//         ),)