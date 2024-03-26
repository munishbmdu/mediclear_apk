import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';




class PhoneNumberInput extends StatefulWidget {
    PhoneNumberInput({required this.phoneNumberController});
  TextEditingController phoneNumberController = TextEditingController();
  @override
  _PhoneNumberInputState createState() => _PhoneNumberInputState();
}

class _PhoneNumberInputState extends State<PhoneNumberInput> {
  bool isNAToggled = false;
  

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
     
        children: [
        //  Text("Phone Number",style: TextStyle(fontSize: 16,color: Colors.grey.shade700),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               
                Text('NA',style: GoogleFonts.poppins(),),
                Checkbox(
                 value: isNAToggled,
                 onChanged: (bool? value) {
                   setState(() {
                     isNAToggled = value!;
                     if (isNAToggled) {
                      
                       widget.phoneNumberController.clear();
                      
                     }
                   });
                 },
                            ),
              
              // SizedBox(width: 10),
              Expanded(
               
                child: Visibility(
                  visible: !isNAToggled,
                  child: TextFormField(
                    controller: widget.phoneNumberController,
                    maxLength: 10,
                   decoration: InputDecoration(hintText: 'Phone Number',hintStyle: GoogleFonts.poppins()),
                    keyboardType: TextInputType.phone,
                    // validator: (value) {
                    //   if (value == null || value.isEmpty||value.length!=10) {
                    //     return 'Please enter 10 digit number';
                    //   }
                    //   return null;
                    // },
                  ),
                ),
              ),
             
             
            ],
          ),
         // SizedBox(height: 20),
         
        ],
      
    );
  }
}
