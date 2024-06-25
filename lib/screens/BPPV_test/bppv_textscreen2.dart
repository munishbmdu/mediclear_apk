import 'package:flutter/material.dart';

import 'dart:io';

import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BppvTestScreen2 extends StatefulWidget {
  BppvTestScreen2({super.key,required this.medical_id});
  String medical_id;

  @override
  State<BppvTestScreen2> createState() => _BppvTestScreen2State();
}

class _BppvTestScreen2State extends State<BppvTestScreen2> {



  File? galleryFile;
  final picker = ImagePicker(); 
  bool isLoading=false;
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20,bottom: 10),
              child: Text("Upload Video Here",style:  GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize:22, color: Coloors.fontcolor),textAlign: TextAlign.center,),
            ),
             const SizedBox( 
                  height: 20, 
                ),
               
               Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
           const SizedBox( 
                height: 50, 
              ), 
              SizedBox( 
               // height: 200.0, 
               
                child: galleryFile == null 
                    ?  Center(child:  Container(
                      height: 100,
                      child: Image.asset("assets/upload_video.png"))) 
                    : Center(child: Text("Uploded Sucessfully")), 
              ), 
          ElevatedButton( 
                style: ButtonStyle( 
                    backgroundColor: MaterialStateProperty.all(Colors.green)), 
                child: Text('Select or record video',style: GoogleFonts.poppins(color: Colors.white),), 
                onPressed: () { 

                  _showPicker1(context: context); 
                 
                }, 
              ), 
             
         
        ],
      
      
    ),
                
             
                SizedBox(
                  height: 20,
                ),
               ElevatedButton(onPressed:() {
                 print(galleryFile!.path);
            isLoading=true;
                   uploadvideobppvgtest();
                   if(isLoading)
                   showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Container(
          height: 250,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             CircularProgressIndicator(),
              SizedBox(height: 20,),
              Text("Uploading Your videos, please wait a little",softWrap: true,textAlign: TextAlign.center,maxLines: 2,)
            ],
          ),
        ),
      );
    });
  
    //                 Future.delayed(Duration(seconds: 10),(){
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.medical_id,)));
    // });
                

                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Coloors.fontcolor
                ), 
                child:Text("Submit",style: GoogleFonts.poppins(color: Colors.white),))
                
               
           
          ],
        ),
      ),
      
    );
  }

  Future uploadvideobppvgtest()async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

   //var images= File('image.jpg').writeAsBytes(_signatureBytes!);
  
    var uri = Uri.parse('https://bmdublog.com/mediclear/api/bppv'); // Replace with your server's endpoint
    var request = http.MultipartRequest("POST", uri);
        //..files.add(await http.MultipartFile.fromPath('consumer_profile_image', imageFile!.path));
      
    request.headers['Authorization'] =
        'Bearer ' + '$token';
        if(galleryFile!=null)
        request.files.add(await http.MultipartFile.fromPath('bppv_video', galleryFile!.path));
        print(galleryFile?.path);
        request.fields['medical_details_id'] = widget.medical_id;
        request.fields['test_type_id'] = '${1}';
  
    
         var response = await request.send();

    // Check the response
    print("abbbm$response");
    if(response.statusCode==200)
    {
      print(response.statusCode);
    //  isLoading=false;
       setState(() {
       Future.delayed(Duration(seconds: 3),(){
        Navigator.pop(context);
       });
      });
    
       showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Container(
          height: 250,
          child: Column(
            children: [
              Image.asset("assets/bppv.png"),
              SizedBox(height: 20,),
              Text("Hurrah!!, BPPV Test Done Sucessfully",softWrap: true,textAlign: TextAlign.center,maxLines: 2,)
            ],
          ),
        ),
      );
    });
  
  Future.delayed(Duration(seconds: 3),(){
 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.medical_id,)));
  });
    }
      else
    {
      // isLoading=false;
       setState(() {
       Future.delayed(Duration(seconds: 3),(){
        Navigator.pop(context);
       });
      });
       showDialog(context: context, builder:(context){
      return AlertDialog(
        content: Container(
          height: 250,
          child: Column(
            children: [
              Image.asset("assets/bppv.png"),
              SizedBox(height: 20,),
              Text("BPPV Test Failed",)
            ],
          ),
        ),
      );
    });


    
    Future.delayed(Duration(seconds: 3),(){
     
      Navigator.pop(context);
   //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>RombergTestScreen3(medical_id: widget.medical_id)));
    });
  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.medical_id,)));
    }
  }
 void _showPicker1({ 
    required BuildContext context, 
  }) { 
    showModalBottomSheet( 
      context: context, 
      builder: (BuildContext context) { 
        return SafeArea( 
          child: Wrap( 
            children: <Widget>[ 
              ListTile( 
                leading: const Icon(Icons.photo_library), 
                title: const Text('Gallery'), 
                onTap: () { 
                  getVideo(ImageSource.gallery); 
                 Navigator.of(context).pop(); 
                }, 
              ), 
              ListTile( 
                leading: const Icon(Icons.photo_camera), 
                title: const Text('Camera'), 
                onTap: () { 
                  getVideo(ImageSource.camera); 
                  Navigator.of(context).pop(); 
                }, 
              ), 
            ], 
          ), 
        ); 
      }, 
    ); 
  } 
    
  
  Future getVideo( 
    ImageSource img,
  
  ) async { 
    final pickedFile = await picker.pickVideo( 
        source: img, 
        preferredCameraDevice: CameraDevice.front, 
        maxDuration: const Duration(seconds: 30)); 
    XFile? xfilePick = pickedFile; 
    setState( 
      () { 
        if (xfilePick != null) { 
          galleryFile = File(pickedFile!.path); 
          
        } else { 
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
              const SnackBar(content: Text('Please upload a video'))); 
        } 
      }, 
    ); 
}
   
  
  
}




