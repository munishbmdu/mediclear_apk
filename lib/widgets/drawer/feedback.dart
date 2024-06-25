import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/application_form/screens/form.dart';
import 'package:mediclear_labs/screens/login_page/login_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



class FeedBack extends StatefulWidget {
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
   TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  int selectedOption=1;
  Future getFeedbackOrComplain(Object value)async{
         final SharedPreferences prefs= await SharedPreferences.getInstance();
         var Token=prefs.getString('token');
         final response=await http.post(Uri.parse("http://bmdublog.com/mediclear/api/feedback"),
         body:jsonEncode(value),
         headers: ({
           "Content-Type":"application/json; charset=UTF-8",
           'Authorization': 'Bearer $Token',
         })
         
         );
         if(response.statusCode==200){
          
          final data=jsonDecode(response.body);
          if(data['status']==true){
           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']}")));
           Navigator.pop(context);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));
          }

                              
         }
         else{
         
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fil the above fields!!")));
                              
         }
  }

    bool isLoading = true;
  bool showSpinner = false ;
   @override
  Widget build(BuildContext context) {
    var Get=MediaQuery.of(context).size;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Coloors.fontcolor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text('Feedback & Complaints'),),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 1,
              width: Get.width,
              color: Coloors.fontcolor,
            ),
            SizedBox(
        
              height: 20,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height*0.7,
                width: 311,
                decoration: BoxDecoration(
                  color: Color(0xffD9D9D9),
                  borderRadius: BorderRadius.all(Radius.circular(11))
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Center(
                            child: Container(
                            height: Get.height * 0.04,
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: selectedOption,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption=value!;
                                  });
                                },
                                fillColor: MaterialStateColor.resolveWith(
                                      (states) => Coloors.fontcolor,
                                ),
                              ),
                              Text(
                                'Feedback',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(
        
                                width: 15,
                              ),
                              Radio(
                                value: 2,
                                groupValue: selectedOption,
                                onChanged: (val) {
                                  setState(() {
                                    selectedOption=val!;
                                  });
                                },
                                fillColor: MaterialStateColor.resolveWith(
                                      (states) => Coloors.fontcolor,
                                ),
                              ),
                              Text(
                                'Complaints',
                                style: TextStyle(
                                  fontSize: 14 ,
                                ),
                              ),
                            ],
                        ),
                      ),
                          ),
                    
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          height: 38,
                          width: 284,
                          child: TextField(
                            controller: subject,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              
                              hintText: 'Subject',
                              hintStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,vertical: 10
                              ),
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Coloors.fontcolor)),
                              border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          height: 202,
                          width: 284,
                          child: TextField(
                            controller: message,
                            maxLines: 10,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
        
                                hintText: 'Message....',
                                hintStyle: TextStyle(color: Colors.black),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Coloors.fontcolor)),
        
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,vertical: 20
                                ),
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),
                    ),
        
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text('Upload Image', style: TextStyle(fontSize: 14),),
                    //     SizedBox(width: 10,),
                    //    InkWell(
                    //        onTap: (){
                    //          showModalBottomSheet<void>(
                    //            context: context,
                    //            builder: (BuildContext context) {
                    //              return Container(
                    //                height: 80,
                    //                color:Coloors.fontcolor,
                    //                child: Center(
                    //                  child: Row(
                    //                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //                    crossAxisAlignment: CrossAxisAlignment.center,
                    //                    mainAxisSize: MainAxisSize.min,
                    //                    children: <Widget>[
                    //                     //  Column(
                    //                     //    children: [
                    //                     //      IconButton(onPressed: ()async{
                    //                     //          imagePickerCamera();
                    //                     //      }, icon: Icon(Icons.camera,color: Colors.white,),
                    //                     //      ),
                    //                     //      Text('Camera',style: TextStyle(color: Colors.white),),
        
                    //                     //    ],
                    //                     //  ),
                    //                      SizedBox(width: 40,),
                    //                     //  Column(
                    //                     //    children: [
                    //                     //      IconButton(onPressed: ()async{
                    //                     //        imagePicker();
                    //                     //      }, icon: FaIcon(FontAwesomeIcons.file,color: Colors.white,),
                    //                     //      ),
                    //                     //      Text('File',style: TextStyle(color: Colors.white),),
                    //                     //    ],
                    //                     //  ),
        
                    //                      // ElevatedButton(
                    //                      //   child: const Text('Close BottomSheet'),
                    //                      //   onPressed: () => Navigator.pop(context),
                    //                      // ),
                    //                    ],
                    //                  ),
                    //                ),
                    //              );
                    //            },
                    //          );
                    //        },
                    //   //  child: Card(
                    //   //     child: Container(
                    //   //       height: 80,
                    //   //         width: 144,
                    //   //       child: SelectedImage == null? Image.asset('assets/Vector1.png'): Image.file(SelectedImage!,fit: BoxFit.cover,),
                    //   //     ),
                    //   //   )
                    //    )
                    //   ],
                    // ),
                  
                  
        
                  SizedBox(
                    height: 30,
                  ),
                    Center(
                      child:isLoading? MyButton(name: "Submit", width: 150, height: 50, onPressedCallback:() {
                                if(subject==''){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter Subject of your concern!!")));
                                }
                                else if(message==''){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Enter your concern!!")));
                                }
                                else{
                                  setState(() {
                                    isLoading=false;
                                  });
                                  var value={
                                    'type':selectedOption,
                                    'subject':subject.text.toString(),
                                    'message':message.text.toString(),
                                  };
                                   getFeedbackOrComplain(value);
                                  Future.delayed(Duration(seconds: 4),(){
                                    setState(() {
                                      isLoading=true;
                                    });
                                  });
                                }
                              },):CircularProgressIndicator()
                    )
                  ],
                ),
        
              )
            ),
          
          ],
        ),
      ),
     // floatingActionButton:floatingActionButon(context),
    );
  }
}