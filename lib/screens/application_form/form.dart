// import 'dart:io';


// import 'package:camera/camera.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:mediclear_labs/constants/colors.dart';
// import 'package:mediclear_labs/main.dart';
// import 'package:mediclear_labs/screens/test_options.dart';
// import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
// import 'package:mediclear_labs/widgets.dart/camera.dart';
// import 'package:mediclear_labs/screens/application_form/widgets/galary_signature.dart';
// import 'package:mediclear_labs/screens/application_form/widgets/geneder_checkbox.dart';
// import 'package:mediclear_labs/screens/application_form/widgets/past_medical_history.dart';
// import 'package:mediclear_labs/screens/application_form/widgets/phone_number_enter.dart';
// import 'package:mediclear_labs/widgets.dart/signature.dart';
// import 'package:signature/signature.dart';

// class MyForm extends StatefulWidget {
//   @override
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // TextEditingController nameController = TextEditingController();
  // TextEditingController clientAdhharController = TextEditingController();
  // TextEditingController companyController = TextEditingController();
  // TextEditingController locationController = TextEditingController();
  // TextEditingController clientAccountController = TextEditingController();
  // TextEditingController genderController = TextEditingController();
  // bool question1 = false;
  // bool question2 = false;
  // bool question3 = false;
  // bool question4 = false;
  // bool question5 = false;
  // bool question6 = false;
  // bool question7 = false;
  // bool question8 = false;
  // bool pastquestion1 = false;
  // bool pastquestion2 = false;
  // bool pastquestion3 = false;
  // bool pastquestion4 = false;
  // bool pastquestion5 = false;
   

//   late String name = "";
  
//     Future<void> _showSignatureDialog() async {
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
          
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),),
//           // title: new RotationTransition(
//           //   turns: new AlwaysStoppedAnimation(90/360),
//           //   child: const Text('Sign Here',style: TextStyle(
//           //     color: Coloors.fontcolor
//           //   ),),
//           // ),
//           title:Row(children: [
//                 new RotationTransition(
//                 turns: new AlwaysStoppedAnimation(270/360),
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Coloors.fontcolor
//                 ),
//                 onPressed: () {
//                 setState(() {
//                   _controller.clear();
//                    _signatureBytes = null;
                    
//                 });
//                         //Navigator.of(context).pop();
//                 },
//                 child: const Text('Clear'),
//               ),
//             ),
//               new RotationTransition(
//                 turns: new AlwaysStoppedAnimation(270/360),
//                 child: ElevatedButton(
//                    style: ElevatedButton.styleFrom(
//                   backgroundColor: Coloors.fontcolor
//                 ),
//                 onPressed: () {
//                  setState(() {
//                    _controller.undo();
//                  });
//                 },
//                 child: const Text('undo'),
//                           ),
//               ),
//             new RotationTransition(
//               turns: new AlwaysStoppedAnimation(270/360),
//               child: ElevatedButton(
//                  style: ElevatedButton.styleFrom(
//                   backgroundColor: Coloors.fontcolor
//                 ),
//                 onPressed: () {
//                   _controller.toPngBytes().then((signatureBytes) {
//                     setState(() {
//                       _signatureBytes = signatureBytes;
//                     });
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 child: const Text('Done'),
//               ),
//             ),
//           ]) ,
//           content: Container(
//             height: 500,
//             width: double.infinity,
//             child: Signature(
//               controller: _controller,
//               height: 500,
//               width: 200,
//               backgroundColor: Colors.grey.shade300,
//             ),
//           ),
//           actions: <Widget>[
         
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     companyController.dispose();
//     locationController.dispose();
//     clientAccountController.dispose();
//     genderController.dispose();
//     super.dispose();
//   }
//    final SignatureController _controller = SignatureController(
//     penStrokeWidth: 3,
//     penColor: Colors.black,
//     exportBackgroundColor: Colors.white,
//   );

//   Uint8List? _signatureBytes;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: 80,
//         backgroundColor: Colors.white,
//         title: Text(
//           name.length == 0 ? "Hii,Welcome" : name,
//           style: const TextStyle(color: Coloors.fontcolor),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Container(
//               height: 80,
//               width: 70,
//               child: Image.asset("assets/mediclear.jpg"),
//             ),
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: 210,
//                           child: TextFormField(
//                             controller: nameController,
//                             decoration: const InputDecoration(labelText: 'Name'),
//                             keyboardType: TextInputType.text,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your name';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                           Container(
//                             width: 210,
//                             child: TextFormField(
//                                                 controller: companyController,
//                                                 decoration: const InputDecoration(labelText: 'Company'),
//                                                 validator: (value) {
//                                                   if (value == null || value.isEmpty) {
//                             return 'Please enter your company';
//                                                   }
//                                                   return null;
//                                                 },
//                                               ),
//                           ),
//                       ],
//                     ),
//                   const CameraPermission()
//                   ],
//                 ),
              
//                 TextFormField(
//                   controller: locationController,
//                   decoration: const InputDecoration(labelText: 'Location',
                 
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter your location';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 PhoneNumberInput(),
            
//                 TextFormField(
//                   controller: clientAdhharController,
//                   decoration: const InputDecoration(labelText: 'Addhar Number'),
//                   keyboardType: TextInputType.number,
//                   maxLength: 12,
//                   validator: (value) {
//                     if (value == null || value.isEmpty || value.length != 12) {
//                       return 'Please enter valid Addhar number details';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(
//                   height: 6,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Gender",
//                     ),
//                     GenderSelection(),
//                   ],
//                 ),

                // const SizedBox(height: 20.0),
                // const Text(
                //   'To be filled by the candidate before Medical Examination:',
                //   style: TextStyle(
                //       color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),
                //   textAlign: TextAlign.start,
                // ),
                // const SizedBox(
                //   height: 7,
                // ),
                // const Text(
                //   ' A. When you are "dizzy" do you experience any of the following symptoms? (check yes or no)',
                //   textAlign: TextAlign.start,
                //   style: TextStyle(color: Colors.black,fontSize: 15),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),
                // CheckboxListTile(
                //   title: const Text(
                //       "1. Light-headedness or swimming sensation in the head?",
                //       textAlign: TextAlign.start,style: TextStyle(
                //         fontSize: 15
                //       ),),
                //   value: question1,
                //   onChanged: (value) {
                //     setState(() {
                //       question1 = value!;
                //     });
                //   },
                // ),
                //   CheckboxListTile(
                //                   title: const Text('2. Blacking out or loss of consciousness?',
                //   style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //                   value: question2,
                //                   onChanged: (value) {
                //                     setState(() {
                //   question2 = value!;
                //                     });
                //                   },
                //                 ),
                // CheckboxListTile(
                //   title: const Text('3. Object spinning or tuming around you?',
                //   style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //   value: question3,
                //   onChanged: (value) {
                // setState(() {
                //   question3 = value!;
                // });
                //   },
                // ),
                // CheckboxListTile(
                //   title: const Text('4. Nausea or vomiting?',
                //  style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //   value: question4,
                //   onChanged: (value) {
                // setState(() {
                //   question4 = value!;
                // });
                //   },
                // ),
                // CheckboxListTile(
                //   title: const Text(
                //   '5. Tingling in your fingers, toes or around your mouth?',
                //  style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //   value: question5,
                //   onChanged: (value) {
                // setState(() {
                //   question5 = value!;
                // });
                //   },
                // ),
                // CheckboxListTile(
                //   title: const Text('6. Does change of position make you dizzy?',
                //  style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //   value: question6,
                //   onChanged: (value) {
                // setState(() {
                //   question6 = value!;
                // });
                //   },
                // ),
                // CheckboxListTile(
                //   title: const Text(
                //   '7.  When you are dizzy, must you support yourself when standing?',
                //   style: TextStyle(
                //     fontSize: 15
                //   ),
                //   textAlign: TextAlign.start),
                //   value: question7,
                //   onChanged: (value) {
                // setState(() {
                //   question7 = value!;
                // });
                //   },
                // ),
              
                // const SizedBox(
                //   height: 10,
                // ),
//                 const PastMedicalHistory(),
             
              

//                 const SizedBox(height: 20.0),
              

//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                    Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                      children: [
//                        Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ElevatedButton(
//               style:ElevatedButton.styleFrom(
//                 backgroundColor: Coloors.fontcolor
//               ),
//               onPressed: () {
//                setState(() {
//                 _showSignatureDialog();        
//                });
//               },
//               child: const Text('Sign Here'),
//             ),
//             const SizedBox(width: 20),
          
//              _signatureBytes != null?
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black,width: 0.5),
                      
//                       //borderRadius: BorderRadius.circular(10)
//                     ),
//                     child: Image.memory(
//                       _signatureBytes!,
//                       width: 180,
//                       height: 40,
//                     ),
//                   ),
//                    Text("Please clear sign to upload from gallery!!",style: TextStyle(fontSize: 12, color: Coloors.fontcolor),)
//                 ],
//               ):GallerySign()
              
          
//           ],
//         ),
       
//          ],
//                    ),
        
//         const SizedBox(
//           height: 25,
//         ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         ElevatedButton(onPressed:() {
                          
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Coloors.fontcolor
//                         ),
//                          child: const Text("Preview")),
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_formKey.currentState!.validate()) {
//                               print('Name: ${nameController.text}');
//                               print('Company: ${companyController.text}');
//                               print('Location: ${locationController.text}');
//                               print(
//                                   'Client Account: ${clientAccountController.text}');
//                               print('Gender: ${genderController.text}');
//                               print('Question 1: $question1');
//                               print('Question 2: $question2');
//                               setState(() {
//                                 name = nameController.text;
//                               });
//                               //  nameController.clear();
//                               //  companyController.clear();
//                               //  locationController.clear();
//                               //  clientAccountController.clear();

//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => const TestScreen()),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
                              
//                               backgroundColor: Coloors.fontcolor),
//                           child: const Text('Submit'),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
 
// }

