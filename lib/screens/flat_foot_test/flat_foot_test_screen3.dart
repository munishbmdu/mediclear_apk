import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/flat_foot_test/flat_foot_test_screen1.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FlatFootTestScreen3 extends StatefulWidget {
   FlatFootTestScreen3({super.key,required this.medical_id});
  String medical_id;

  @override
  State<FlatFootTestScreen3> createState() => _FlatFootTestScreen3State();
}

class _FlatFootTestScreen3State extends State<FlatFootTestScreen3> {
  File? SelectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar:  AppBar(
        title: Text('MEDICLEAR',style: GoogleFonts.poppins(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.black),),
        backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
           leading: IconButton(onPressed:() {
                          
            Navigator.pop(context);
          }, icon:Icon(Icons.navigate_before,color: Colors.black,size: 35,)),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child: Center(
                child: Text("Here! , Click or Upload Image",style:   GoogleFonts.roboto(fontSize: 19,fontWeight: FontWeight.bold, color: Coloors.fontcolor))),
                
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                showImagePicker(context);
              },
              child: SelectedImage==null? Image.asset("assets/add_image.png"):SizedBox(
                height: 300,
                width: 300,
                child: Card(
                  elevation: 5,
                
                  shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(15),
                  ),
                  shadowColor: Coloors.fontcolor,
                  child: Image.file(SelectedImage!)),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(onPressed:() {
             uploadImage(SelectedImage);
             Future.delayed(Duration(seconds: 5),(){
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.medical_id,)));
             });
            },  style: ElevatedButton.styleFrom(
        backgroundColor: Coloors.fontcolor
          ),
           child:Text("Submit",style:  GoogleFonts.roboto(fontSize: 20,color: Colors.white),))
          ],
        ),
      ),
    );
  }
        Future imagePicker()async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    // Cropped Image
    CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: returnedImage!.path

    );
    if(returnedImage == null)return;
    setState(() {
      SelectedImage = File(croppedFile!.path);
     // Navigator.of(context).pop();
    });
  }
  Future imagePickerCamera()async{
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    CroppedFile? croppedFile = await ImageCropper().cropImage(
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        sourcePath: returnedImage!.path
    );
    if(returnedImage == null)return;
    setState(() {
      SelectedImage = File(croppedFile!.path);
     // Navigator.of(context).pop();

    });
  }

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child:  Column(
                            children: [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style:  GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            imagePicker();
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child:  SizedBox(
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style:  GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            imagePickerCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }


Future<void> uploadImage(File? imageFile, ) async {
  try {
     final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    // Create a multipart request
    var request = http.MultipartRequest('POST',Uri.parse("${ApiDomain().url}flatfoot"));
    request.headers['Authorization'] =
        'Bearer ' + '$token';

    // Add the image file to the request
    var image = await http.MultipartFile.fromPath('flatfoot', imageFile!.path);
    request.files.add(image);

    // Add additional parameters
    request.fields['medical_details_id'] = widget.medical_id;
    request.fields['test_type_id'] = '${1}';
    print(SelectedImage);
    print(widget.medical_id);
    

    // Send the request
    var response = await request.send();

    // Check the response
    if(response.statusCode==200)
    {
      
       showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Container(
          height: 250,
          child: Column(
            children: [
              Image.asset("assets/foot_print_image.jpg"),
              SizedBox(height: 20,),
              Text("Hurrah!!, FlatFoot done successfully",)
            ],
          ),
        ),
      );
    });
    }
      else
    {
   
       showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Container(
          height: 250,
          child: Column(
            children: [
              Image.asset("assets/foot_print_image.jpg"),
              SizedBox(height: 20,),
              Text("FlatFoot Test Failed",)
            ],
          ),
        ),
      );
    });
    }
  } catch (error) {
    print('Error uploading image: $error');
  }
}

// Usage example


  
}