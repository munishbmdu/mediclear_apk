import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/test_options.dart';

class CertificatePage extends StatefulWidget {
  final String certificate;
  const CertificatePage({super.key, required this.certificate});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  Map<String, dynamic> responseData = {};
  late String consumerName;
  late String certification_number;
  late String doctor_submit_date;
  late String lastvaild;
  late String consumer_addharnumber;
  late String company_name;
  late String gender;
  late String profile_pic;
  late String result;
  late String _DOB;
  bool isloading = true;
  @override
  void initState() {
    super.initState();
    sendDataToApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => TestScreen()),
              );
            },
            icon: Icon(Icons.arrow_back),
          ),
          elevation: 5,
          title: Text("Verification"),
        ),
        body: isloading == true
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          maxRadius: 60,
                          minRadius: 40,
                          backgroundImage: profile_pic != null
                              ? NetworkImage(
                                  "https://qbacp.com/mediclear/public/images/" +
                                      profile_pic)
                              : NetworkImage(
                                  "https://qbacp.com/mediclear/public/images" +
                                      profile_pic),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text:
                                    " Certificate No : ${certification_number}"),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Company Name : ${company_name}"),
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Name : ${consumerName}"),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller:
                                TextEditingController(text: "DOB : ${_DOB}"),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Report Date : ${doctor_submit_date}"),
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 17),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Valid Date : ${lastvaild}"),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Gender : ${gender} "),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Aadhaar : ${consumer_addharnumber}"),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.grey.shade500)),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: TextField(
                            readOnly: true,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                            controller: TextEditingController(
                                text: "Status : ${result} "),
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    //   child: Container(
                    //     height: MediaQuery.of(context).size.height * 0.05,
                    //     width: MediaQuery.of(context).size.width * 0.9,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(10.0),
                    //         border: Border.all(color: Colors.grey.shade500)),
                    //     child: TextField(
                    //       decoration: InputDecoration(border: InputBorder.none),
                    //       controller: TextEditingController(),
                    //       style: TextStyle(
                    //           color: Colors.grey.shade700,
                    //           fontSize: 17,
                    //           fontWeight: FontWeight.bold),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     ElevatedButton(
                    //       onPressed: () {
                    //         setState(() {
                    //           showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return InvalidDialog();
                    //             },
                    //           );
                    //         });
                    //       },
                    //       child: Text(
                    //         "Print",
                    //         style: TextStyle(color: Colors.black, fontSize: 17),
                    //       ),
                    //       style:
                    //           ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ));
  }

  Future<void> sendDataToApi() async {
    String url = 'https://qbacp.com/mediclear/api/get-report';
    String data = widget.certificate;

    try {
      var response = await http.post(
        Uri.parse(url),
        body: jsonEncode({"certification": data}),
        headers: {
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        print(response.body);

        responseData = jsonDecode(response.body)['data'];
        setState(() {
          consumerName = responseData['consumername'].toString();
          consumer_addharnumber =
              responseData['consumer_addharnumber'].toString();
          certification_number =
              responseData['certification_number'].toString();
          doctor_submit_date = responseData['doctor_submit_date'].toString();
          lastvaild = responseData['lastvalid_date'].toString();
          company_name = responseData['company_name'].toString();
          gender = responseData['gender'].toString();
          profile_pic = responseData['profile_pic'].toString();
          result = responseData['result'].toString();
          _DOB = responseData['dob'].toString();
        });
        setState(() {
          isloading = false;
        });
        print(consumerName.toString());
        print(certification_number.toString());
        print(consumer_addharnumber.toString());
        print(doctor_submit_date.toString());
        print(lastvaild.toString());
        print(company_name.toString());
        print(gender.toString());
        print(profile_pic.toString());
        print(result.toString());
        print(_DOB.toString());
        print("Navneetttt" + responseData.toString());
      } else {
        print("Failed to send data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Future<void> _sendDataToAPI(String data) async {
  //   final url = Uri.parse('https://qbacp.com/mediclear/api/get-report');
  //   final response = await http.post(
  //     url,
  //     body: jsonEncode({'certification': data}),
  //     headers: {'Content-Type': 'application/json'},
  //   );

  //   if (response.statusCode == 200) {
  //     print('Data sent successfully');
  //     print(response.body);
  //   } else {
  //     print('Failed to send data: ${response.statusCode}');
  //   }
  // }
}
