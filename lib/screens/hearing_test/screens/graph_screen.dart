import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/feq_api.dart';
import 'graph_test.dart';
import 'package:http/http.dart' as http;

class HearingTestGraphSCreen extends StatefulWidget {
  HearingTestGraphSCreen({required this.medical_id});
  final String medical_id;
  @override
  State<HearingTestGraphSCreen> createState() => _HearingTestGraphSCreenState();
}

class _HearingTestGraphSCreenState extends State<HearingTestGraphSCreen> {
  int _value = 1;
  int _selectedIndex = 1;
  final player = AudioPlayer();
  int? selectedButtonColumn1;
  int? selectedButtonColumn2;

  int currentColumn = 1;

  int selectedIndex = 0;

  int activeColumnIndex = 0;
  int activeColumnIndex2 = 0;
  bool allColumnsDone = false;
  bool allColumnsDone2 = false;
  List<List<int>> columnValues = List.generate(7, (index) {
    return List.generate(6, (i) => i + 1);
  });
  List<List<int>> columnValues2 = List.generate(7, (index) {
    return List.generate(6, (i) => i + 1);
  });
  List<int> selectedValues = List.filled(7, 0);
  List<int> selectedValues2 = List.filled(7, 0);
  List<int> _selectedlistvarible = [];
  List<int> _selectedlistvarible2 = [];

  int _selectedContainerIndex = 0;
  SharedPreferences? _prefs;
  String combinedValues = '';
  String combinedValues2 = '';

  String _leftside = '';
  String _rightside = '';
  String _medical_details_id = "";
  String _test_type_id = '1';

  //
  String _hearingApi = 'https://qbacp.com/mediclear/api/hearingdata';

  Future<void> sendDataToApi(String leftside, String rightside,
      String medical_details_id, String test_type_id) async {
    try {
      var response = await http.post(
        Uri.parse(_hearingApi),
        body: {
          'left_ear_fixed': leftside,
          'right_ear_fixed': rightside,
          'medical_details_id': widget.medical_id,
          'test_type_id': test_type_id
        },
      );

      print('Response body: ${response.body}');
    } catch (e) {
      print('Error sending data to API: $e');
    }
  }

  void _convertlistToString() {
    setState(() {
      _selectedlistvarible.addAll(selectedValues);
      print("jahjahj" + _selectedlistvarible.toString());
    });
    combinedValues = _combineListValues(_selectedlistvarible);
    setState(() {
      _leftside = combinedValues;
    });
    print("NAv" + combinedValues);
  }

  void _convertlistToString2() {
    setState(() {
      _selectedlistvarible2.addAll(selectedValues2);
      print("ssasasa" + _selectedlistvarible2.toString());
    });
    combinedValues2 = _combineListValues(_selectedlistvarible2);
    setState(() {
      _rightside = combinedValues2;
    });
    print("Goldy" + combinedValues2);
  }

  void moveToNextColumn() {
    setState(() {
      if (!allColumnsDone) {
        if (activeColumnIndex == 6) {
          bool allDone = true;
          for (int i = 0; i < selectedValues.length; i++) {
            if (selectedValues[i] == 0) {
              allDone = false;
              break;
            }
          }
          if (allDone) {
            allColumnsDone = true;
            setState(() {});
            _convertlistToString();
            return;
          }
        }
        activeColumnIndex = (activeColumnIndex + 1) % 7;
      }
    });
  }

  void moveToNextColumn2() {
    setState(() {
      if (!allColumnsDone2) {
        if (activeColumnIndex2 == 6) {
          bool allDone2 = true;
          for (int i = 0; i < selectedValues2.length; i++) {
            if (selectedValues2[i] == 0) {
              allDone2 = false;
              break;
            }
          }
          if (allDone2) {
            allColumnsDone2 = true;
            setState(() {});
            _convertlistToString2();
            return;
          }
        }
        activeColumnIndex2 = (activeColumnIndex2 + 1) % 7;
      }
    });
  }
  // void selectOption(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }

  void moveUpOrDown(bool isUp) {
    setState(() {
      if (selectedValues[activeColumnIndex] != 1) {
        if (isUp) {
          if (selectedValues[activeColumnIndex]! > 1) {
            selectedValues[activeColumnIndex] =
                selectedValues[activeColumnIndex]! - 1;
          }
        } else {
          if (selectedValues[activeColumnIndex]! < 6) {
            selectedValues[activeColumnIndex] =
                selectedValues[activeColumnIndex]! + 1;
          }
        }
      }
    });
  }

  void moveUpOrDown2(bool isUp) {
    setState(() {
      if (selectedValues2[activeColumnIndex2] != 1) {
        if (isUp) {
          if (selectedValues2[activeColumnIndex2]! > 1) {
            selectedValues2[activeColumnIndex2] =
                selectedValues2[activeColumnIndex2]! - 1;
          }
        } else {
          if (selectedValues2[activeColumnIndex2]! < 6) {
            selectedValues2[activeColumnIndex2] =
                selectedValues2[activeColumnIndex2]! + 1;
          }
        }
      }
    });
  }

  _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedContainerIndex = _prefs!.getInt('selectedContainerIndex') ?? 0;
    });
  }

  _setSelectedContainerIndex(int index) {
    setState(() {
      _selectedContainerIndex = index;
      _prefs!.setInt('selectedContainerIndex', index);
    });
  }

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VertigoTest(),
            ));

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Hear Test',
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VertigoTest(),
                    ));
              },
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
                size: 35,
              )),
          backgroundColor: Coloors.fontcolor,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: [
                Center(
                  child: RotatedBox(quarterTurns: 7, child: Text("/[db HL]")),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 35),
                        child: Text('10'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 82),
                        child: Text('20'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 129),
                        child: Text('30'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 176),
                        child: Text('40'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 223),
                        child: Text('50'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 1, top: 270),
                        child: Text('60'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 55,
                        ),
                        child: Text('250'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 125,
                        ),
                        child: Text('500'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 190,
                        ),
                        child: Text('1000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 260,
                        ),
                        child: Text('2000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 330,
                        ),
                        child: Text('4000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 400,
                        ),
                        child: Text('6000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 470,
                        ),
                        child: Text('8000'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                              height: MediaQuery.of(context).size.height * 0.67,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: const Border(
                                  top: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  left: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  right: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(7, (index) {
                                  return _selectedContainerIndex == 0
                                      ? ColumnWidget(
                                          active: activeColumnIndex == index &&
                                              !allColumnsDone,
                                          values: columnValues[index],
                                          selectedValue: selectedValues[index],
                                          onChanged: (value) {
                                            if (!allColumnsDone) {
                                              setState(() {
                                                selectedValues[index] = value!;
                                              });
                                              print("ddddddd" +
                                                  selectedValues.toString());
                                            }
                                          },
                                        )
                                      : ColumnWidget2(
                                          active2:
                                              activeColumnIndex2 == index &&
                                                  !allColumnsDone2,
                                          values2: columnValues2[index],
                                          selectedValue2:
                                              selectedValues2[index],
                                          onChanged2: (value) {
                                            if (!allColumnsDone2) {
                                              setState(() {
                                                selectedValues2[index] = value!;
                                              });
                                              print("hhhhhh" +
                                                  selectedValues2.toString());
                                            }
                                          },
                                        );
                                }),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 220,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Left"),
                          Radio(
                            value: 0,
                            groupValue: _selectedContainerIndex,
                            onChanged: (value) {
                              _setSelectedContainerIndex(value!);
                            },
                          ),
                          Text("Right"),
                          Radio(
                            value: 1,
                            groupValue: _selectedContainerIndex,
                            onChanged: (value) {
                              _setSelectedContainerIndex(value!);
                            },
                          ),
                        ],
                      ),
                      Container(
                        height: 45,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedContainerIndex == 0) {
                              moveUpOrDown(true);
                            } else {
                              moveUpOrDown2(true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400),
                          child: Text(
                            "Up",
                            style: GoogleFonts.roboto(color: Coloors.fontcolor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedContainerIndex == 0) {
                              moveUpOrDown(false);
                            } else {
                              moveUpOrDown2(false);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400),
                          child: Text("Down",
                              style:
                                  GoogleFonts.roboto(color: Coloors.fontcolor)),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 45,
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_selectedContainerIndex == 0) {
                              moveToNextColumn();
                              // _convertlistToString();
                              print(combinedValues);
                            } else {
                              moveToNextColumn2();
                              // _convertlistToString2();
                              print(combinedValues2);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400),
                          child: Text(
                            "BARELY AUDIBLE",
                            style: GoogleFonts.roboto(color: Coloors.fontcolor),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        width: 95,
                        child: ElevatedButton(
                          onPressed: () {
                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                              DeviceOrientation.portraitDown,
                            ]);

                            sendDataToApi(_leftside, _rightside,
                                _medical_details_id, _test_type_id);

                            //     .then((_) {
                            //   // Reset to portrait mode after navigating away from the landscape screen
                            //   SystemChrome.setPreferredOrientations([
                            //     DeviceOrientation.portraitUp,
                            //     DeviceOrientation.portraitDown,
                            //   ]);
                            // });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Result submitted'),
                                duration: Duration(seconds: 3),
                              ),
                            );

                            Future.delayed(Duration(seconds: 3), () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => VertigoTest(),
                              ));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade400),
                          child: Text(
                            "Done",
                            style: GoogleFonts.roboto(color: Coloors.fontcolor),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _combineListValues(List<int> list) {
    return list.join(',');
  }

  final List<String> soundPaths = [
    'assets/feq.mp3',
    'assets/feq1.mp3',
    'assets/feq2.mp3',
  ];
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

Future<void> _storeSelectedValueLocally(String selectedValue) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedValue', selectedValue);
    print('Selected value stored locally: $selectedValue');
  } catch (e) {
    print('Error storing selected value locally: $e');
  }
}

class RadioExample extends StatefulWidget {
  const RadioExample({super.key});

  @override
  State<RadioExample> createState() => _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  int _selectedContainerIndex = 0;
  SharedPreferences? _prefs;

  _setSelectedContainerIndex(int index) {
    setState(() {
      _selectedContainerIndex = index;
      _prefs!.setInt('selectedContainerIndex', index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Text("Left"),
          RadioListTile(
            value: 0,
            groupValue: _selectedContainerIndex,
            onChanged: (value) {
              _setSelectedContainerIndex(value!);
            },
          ),
          SizedBox(
            width: 40,
          ),
          Text("Right"),
          RadioListTile(
            value: 1,
            groupValue: _selectedContainerIndex,
            onChanged: (value) {
              _setSelectedContainerIndex(value!);
            },
          ),
        ],
      ),
    );
  }
}

class ColumnWidget extends StatefulWidget {
  final bool active;
  final List<int> values;
  final int? selectedValue;
  final ValueChanged<int?> onChanged;

  const ColumnWidget({
    required this.active,
    required this.values,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  State<ColumnWidget> createState() => _ColumnWidgetState();
}

class _ColumnWidgetState extends State<ColumnWidget> {
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: 50,
        //   // decoration: BoxDecoration(
        //   //   border: Border(
        //   //       right: BorderSide(
        //   //         color: widget.active ? Colors.transparent : Colors.grey,
        //   //         width: 0.1,
        //   //       ),
        //   //       left: BorderSide(
        //   //         color: widget.active ? Colors.transparent : Colors.grey,
        //   //         width: 0.1,
        //   //       )),
        //   // ),
        //   child:
        SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.values.map((value) {
          return Radio(
            value: value,
            groupValue: widget.selectedValue,
            onChanged: widget.active ? widget.onChanged : null,
          );
        }).toList(),
      ),
      // ),
    );
  }
}

class ColumnWidget2 extends StatefulWidget {
  final bool active2;
  final List<int> values2;
  final int? selectedValue2;
  final ValueChanged<int?> onChanged2;

  const ColumnWidget2({
    required this.active2,
    required this.values2,
    required this.selectedValue2,
    required this.onChanged2,
  });

  @override
  _ColumnWidgetState2 createState() => _ColumnWidgetState2();
}

class _ColumnWidgetState2 extends State<ColumnWidget2> {
  @override
  Widget build(BuildContext context) {
    return
        // Container(
        //   height: MediaQuery.of(context).size.height,
        //   width: 50,
        //   // padding: EdgeInsets.all(8.0),
        //   // decoration: BoxDecoration(
        //   //   border: Border(
        //   //       right: BorderSide(
        //   //         color: widget.active2 ? Colors.transparent : Colors.grey,
        //   //         width: 0.1,
        //   //       ),
        //   //       left: BorderSide(
        //   //         color: widget.active2 ? Colors.transparent : Colors.grey,
        //   //         width: 0.1,
        //   //       )),
        //   // ),
        //   child:
        SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: widget.values2.map((value) {
          return Radio(
            value: value,
            groupValue: widget.selectedValue2,
            onChanged: widget.active2 ? widget.onChanged2 : null,
          );
        }).toList(),
      ),
      // ),
    );
  }
}

Widget CustomGraphButton(String text, double width) {
  return Container(
    height: 45,
    width: width,
    child: ElevatedButton(
      onPressed: () {
        pushFeqData();
      },
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade400),
      child: Text(
        text,
        style: GoogleFonts.roboto(color: Coloors.fontcolor),
      ),
    ),
  );
}

void pushFeqData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedValue = prefs.getString('selectedValue');
  print('vamue=>>> $storedValue');
  if (storedValue != null) {
    FeqApi().FeqPush(
      "$storedValue,55,88",
      "2,5,3,",
      "127",
      "1",
      "55,66,99",
      "22,34,66",
    );
  } else {
    print('No stored value found.');
  }
}

// child: Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 1,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 stopSound();
//               });
//             },
//           ),
//           Radio(
//             value: 2,
//             groupValue: _value,
//             onChanged: (value) async {
//               setState(() {
//                 _value = value!;
//                 player.setAsset('assets/feq2.mp3');
//               });
//               await _storeSelectedValueLocally(
//                   value.toString());
//             },
//           ),
//           Radio(
//             value: 3,
//             groupValue: _value,
//             onChanged: (value) async {
//               setState(() {
//                 _value = value!;
//                 // selectOption(value!);
//                 player.setAsset('assets/feq3.mp3');
//               });
//               await _storeSelectedValueLocally(
//                   value.toString());
//             },
//           ),
//           Radio(
//             value: 4,
//             groupValue: _value,
//             onChanged: (value) async {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//               await _storeSelectedValueLocally(
//                   value.toString());
//             },
//           ),
//           Radio(
//             value: 5,
//             groupValue: _value,
//             onChanged: (value) async {
//               setState(() {
//                 _value = value!;
//                 playSound2();
//               });
//               await _storeSelectedValueLocally(
//                   value.toString());
//             },
//           ),
//           Radio(
//             value: 6,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 7,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 8,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 9,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 10,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 11,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 12,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 13,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 14,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 15,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 16,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 17,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 18,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 19,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 20,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 21,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 22,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 23,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 24,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 25,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 26,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 27,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 28,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 29,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 30,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 31,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 32,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 33,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 34,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 35,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 36,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     ),
//     SingleChildScrollView(
//       child: Column(
//         children: [
//           Radio(
//             value: 37,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 38,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 39,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 40,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 41,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//           Radio(
//             value: 42,
//             groupValue: _value,
//             onChanged: (value) {
//               setState(() {
//                 // selectOption(value!);
//                 _value = value!;
//                 playSound1();
//               });
//             },
//           ),
//         ],
//       ),
//     )
//   ],
// ),

// Future<void> playSound() async {
//   try {
//     await player.setAsset('assets/feq.mp3');
//     await player.play();
//   } catch (e) {
//     print('Error playing audio: $e');
//   }
// }

// Future<void> playSound1() async {
//   try {
//     await player.setAsset('assets/feq1.mp3');
//     await player.play();
//   } catch (e) {
//     print('Error playing audio: $e');
//   }
// }

// Future<void> playSound2() async {
//   try {
//     await player.setAsset('assets/feq2.mp3');
//     await player.play();
//   } catch (e) {
//     print('Error playing audio: $e');
//   }
// }

// Future<void> stopSound() async {
//   await player.stop();
// }

// void handleRadioButtonPress(int value) async {
//   setState(() {
//     _value = value;
//     switch (value) {
//       case 1:
//         stopSound();
//         break;
//       case 2:
//         player.setAsset('assets/feq2.mp3');
//         break;
//       case 3:
//         player.setAsset('assets/feq3.mp3');
//         break;
//       case 4:
//         playSound1();
//         break;
//       case 5:
//         playSound2();
//         break;
//       default:
//       // Handle default case if needed
//     }
//   });

//   await _storeSelectedValueLocally(value.toString());
// }
