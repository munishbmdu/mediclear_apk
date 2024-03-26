import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class FaqsTab extends StatelessWidget {
  final List<String> items = [
    "Why should I check For my ears?",
    "Who is at risk of haering loss?",
    'The test told me to get proffesional advice but i can hear well. what does it means?',
    'Can listening music affect my ears?',
    
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs',style:  GoogleFonts.roboto(fontSize: 24,color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index],style: GoogleFonts.roboto(fontSize: 16,color: Colors.black),),
            trailing: Icon(Icons.menu),
            onTap: () {
              
              _showDetailsDialog(context, index);
            },
          );
        },
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, int index) {
     final List<String> items = [
    "Hearing loss means a reduction in tghe ability to hear.There are different grades of hearing loss",
    "Unadressing hearing loss can affect people in different ways....",
    " Listening to loud music tires and damages sensory cells within your ears",
    'The management of hearing loss depends upon its cause,type and degree.You should consult a trained person',
    
  ];

    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('know More'),
          content: Text(items[index],style:  GoogleFonts.roboto(color: Colors.grey ),),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

