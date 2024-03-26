import 'package:flutter/material.dart';


class GenderSelection extends StatefulWidget {
  TextEditingController genderController=TextEditingController();
  GenderSelection({ required this.genderController});
  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool male = false;
  bool female = false;
  bool others = false;
  //  void submitgender() {
  //   setState(() {
  //     male = false;
  //     female = false;
  //     others = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: male,
          onChanged: (bool? value) {
            setState(() {
              male = value!;
              widget.genderController.text="male";
              if (male) {
                // Handle male selection
                female = false;
                others = false;
              }
            });
          },
        ),
        Text('Male'),
        Checkbox(
          value: female,
          onChanged: (bool? value) {
            setState(() {
              female = value!;
              widget.genderController.text="female";
              if (female) {
               
                male = false;
                others = false;
              }
            });
          },
        ),
        Text('Female'),
        Checkbox(
          value: others,
          onChanged: (bool? value) {
            setState(() {
              others = value!;
              widget.genderController.text="others";
              if (others) {
              
                male = false;
                female = false;
              }
            });
          },
        ),
        Text('Others'),
      ],
    );
  }
}
