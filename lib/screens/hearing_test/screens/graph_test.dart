import 'package:flutter/material.dart';

import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'graph_screen.dart';

class FeqTest extends StatefulWidget {
  const FeqTest({super.key});

  @override
  State<FeqTest> createState() => _FeqTestState();
}

class _FeqTestState extends State<FeqTest> {
  int _value = 1;
  int _selectedIndex = 0;
  final player = AudioPlayer();
  int? selectedButtonColumn1;
  int? selectedButtonColumn2;

  int currentColumn = 1;

  final List<String> soundPaths = [
    'assets/feq.mp3',
    'assets/feq1.mp3',
    'assets/feq2.mp3',
    // Add more sound options here
  ];
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> playSound() async {
    try {
      await player.setAsset('assets/feq.mp3');
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> playSound1() async {
    try {
      await player.setAsset('assets/feq1.mp3');
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> playSound2() async {
    try {
      await player.setAsset('assets/feq2.mp3');
      await player.play();
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> stopSound() async {
    await player.stop();
  }

  void handleRadioButtonPress(int value) async {
    setState(() {
      _value = value;
      switch (value) {
        case 1:
          stopSound();
          break;
        case 2:
          player.setAsset('assets/feq2.mp3');
          break;
        case 3:
          player.setAsset('assets/feq3.mp3');
          break;
        case 4:
          playSound1();
          break;
        case 5:
          playSound2();
          break;
        default:
        // Handle default case if needed
      }
    });

    await _storeSelectedValueLocally(value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 28),
                  child: Text('10'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 68),
                  child: Text('20'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 110),
                  child: Text('30'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 145),
                  child: Text('40'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 185),
                  child: Text('50'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 1, top: 225),
                  child: Text('60'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 45,
                  ),
                  child: Text('250'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 115,
                  ),
                  child: Text('500'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 182,
                  ),
                  child: Text('1000'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 250,
                  ),
                  child: Text('2000'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 322,
                  ),
                  child: Text('4000'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 395,
                  ),
                  child: Text('6000'),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 465,
                  ),
                  child: Text('8000'),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.80,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: const Border(
                        top: BorderSide(
                          color: Colors
                              .red, // Specify your desired color for the bottom line
                          width: 1.0, // Specify the width of the line
                        ),
                        left: BorderSide(
                          color: Colors
                              .red, // Specify your desired color for the left line
                          width: 1.0, // Specify the width of the line
                        ),
                        right: BorderSide(
                          color: Colors
                              .red, // Specify your desired color for the left line
                          width: 1.0, // Specify the width of the line
                        ),
                      ),
                    ),
                    child: GridView.count(
                      scrollDirection: Axis.horizontal,
                      crossAxisCount: 7,
                      childAspectRatio: 1.5,
                      children: [
                        Radio(
                          value: 1,
                          groupValue: _selectedIndex,
                          onChanged: (value) {
                            setState(() {
                              _selectedIndex = value!;
                              stopSound();
                            });
                          },
                        ),
                        Radio(
                          value: 2,
                          groupValue: _selectedIndex,
                          onChanged: (value) async {
                            setState(() {
                              _selectedIndex = value!;
                              player.setAsset('assets/feq2.mp3');
                            });
                            await _storeSelectedValueLocally(value.toString());
                          },
                        ),
                        Radio(
                          value: 3,
                          groupValue: _selectedIndex,
                          onChanged: (value) async {
                            setState(() {
                              _selectedIndex = value!;
                              player.setAsset('assets/feq3.mp3');
                            });
                            await _storeSelectedValueLocally(value.toString());
                          },
                        ),
                        Radio(
                          value: 4,
                          groupValue: _value,
                          onChanged: (value) async {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                            await _storeSelectedValueLocally(value.toString());
                          },
                        ),
                        Radio(
                          value: 5,
                          groupValue: _value,
                          onChanged: (value) async {
                            setState(() {
                              _value = value!;
                              playSound2();
                            });
                            await _storeSelectedValueLocally(value.toString());
                          },
                        ),
                        Radio(
                          value: 6,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound();
                            });
                          },
                        ),
                        Radio(
                          value: 7,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 8,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 9,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 10,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 11,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 12,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 13,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 14,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 15,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 16,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 17,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 18,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 19,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 20,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 21,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 22,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 23,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 24,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 25,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 26,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 27,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 28,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 29,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 30,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 31,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 32,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 33,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 34,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 35,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 36,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 37,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 38,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 39,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 40,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 41,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                        Radio(
                          value: 42,
                          groupValue: _value,
                          onChanged: (value) {
                            setState(() {
                              _value = value!;
                              playSound1();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _moveUp(int count) {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex--;
      });
    }
  }

  void _moveDown(int count) {
    if (_selectedIndex < count - 1) {
      setState(() {
        _selectedIndex++;
      });
    }
  }
}

Future<void> _storeSelectedValueLocally(String selectedValue) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedValue', selectedValue);
    print('Selected value stored locally: $selectedValue');
  } catch (e) {
    print('Error storing selected value locally: $e');
    // Handle storage error
  }
}
