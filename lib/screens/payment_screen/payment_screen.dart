import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mediclear_labs/screens/payment_screen/upi_screen.dart';


class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(context,MaterialPageRoute(builder:(context) {
                  return UpiPaymentScreen();
                },));
                // Handle Paytm payment
                // You can navigate to the next screen or perform the payment logic here.
              },
              child: Icon(
                FontAwesomeIcons.paypal, // Use an appropriate icon here
                size: 100.0,
                color: Colors.green,
              ),
            ),
           Text("Click To pay",style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black
           ),)
          ],
        ),
      ),
    );
  }
}
