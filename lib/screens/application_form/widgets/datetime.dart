import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';


class DOBWidget extends StatefulWidget {
    TextEditingController dobController = TextEditingController();
   DOBWidget({required this.dobController});
  @override
  _DOBWidgetState createState() => _DOBWidgetState();
}

class _DOBWidgetState extends State<DOBWidget> {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 150,
      child: TextFormField(
        controller: widget.dobController,
        maxLength: 10,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // labelText: 'Date of Birth',
          hintText: 'YYYY-MM-DD',
          hintStyle: GoogleFonts.poppins()
        ),
        style: TextStyle(fontSize: 16), // Customize text style as needed
       onChanged: (value) {
          if (value.length == 4 && !value.contains('-')) {
            // Add the first hyphen after entering the year
            widget.dobController.text = '$value-';
          } else if (value.length == 7 && !value.endsWith('-')) {
            // Add the second hyphen after entering the month
            widget.dobController.text = '$value-';
          } else if (value.length == 5 && value.endsWith('-')) {
            // Remove the hyphen when deleting the month
            widget.dobController.text = value.substring(0, 4);
          } else if (value.length == 8 && value.endsWith('-')) {
            // Remove the hyphen when deleting the day
            widget.dobController.text = value.substring(0, 7);
          } else if (value.length > 10) {
            // Limit the length to 10 characters
            widget.dobController.text = value.substring(0, 10);
          }
        },
      ),
    );
  }

  void validateAndProcessDOB() {
    final String dobText = widget.dobController.text;

    if (dobText.length != 10) {
      // Show an error message or handle invalid input
      print('Please enter a valid date.');
      return;
    }

    // Extract day, month, and year from the entered date
    final List<String> dateParts = dobText.split('/');
    final String day = dateParts[0];
    final String month = dateParts[1];
    final String year = dateParts[2];

    // Validate the entered date (you can add more complex validation logic here)
    final isValidDate = isValidDateInput(int.parse(day), int.parse(month), int.parse(year));

    if (isValidDate) {
      // Process the valid DOB
      final dob = DateTime(int.parse(year), int.parse(month), int.parse(day));
      print('Date of Birth: ${DateFormat('yyyy-MM-dd').format(dob)}');
    } else {
      // Show an error message or handle invalid date
      print('Invalid date. Please check your input.');
    }
  }

  bool isValidDateInput(int day, int month, int year) {
    try {
      final DateTime date = DateTime(year, month, day);
      return date.year == year && date.month == month && date.day == day;
    } catch (e) {
      return false;
    }
  }
}
