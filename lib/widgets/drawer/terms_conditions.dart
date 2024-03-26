import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
   bool termsAccepted=false;
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

@override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(value: termsAccepted, 
         activeColor: Coloors.fontcolor,
            onChanged:(value) {
              setState(() {
                termsAccepted=!termsAccepted;
              });
            },),
           // if(termsAccepted)
           TextButton(onPressed:() {
             _showTermsAndConditionsDialog(context);
           }, 
           
           child: Text("Terms & Conditions",style: GoogleFonts.poppins(color: Coloors.fontcolor),))
            
          ],
        
       
    );

  }


}




