import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RombergTestScreen3 extends StatefulWidget {
   RombergTestScreen3({super.key,required this.medical_id});
  String medical_id;

  @override
  State<RombergTestScreen3> createState() => _RombergTestScreen3State();
}

class _RombergTestScreen3State extends State<RombergTestScreen3> {
   File? galleryFile1;
   File? galleryFile2;
    File? galleryFile3;
    bool isLoading=false;

  final picker = ImagePicker();
  final picker2 = ImagePicker(); 
  final picker3 = ImagePicker();  
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
              child: Text("Upload Video Here",style:  GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:22, color: Coloors.fontcolor),textAlign: TextAlign.center,),
            ),
             const SizedBox( 
                  height: 20, 
                ),
                Column(
        children: [
         
           const SizedBox( 
                height: 20, 
              ), 
              SizedBox( 
               // height: 200.0, 
               
                child: galleryFile1 == null 
                    ?  Center(child: Container(
                      height: 100,
                      child: Image.asset("assets/upload_video.png"))) 
                    : Center(child: Text("Uploded Sucessfully")), 
              ), 
          ElevatedButton( 
                style: ButtonStyle( 
                    backgroundColor: MaterialStateProperty.all(Colors.green)), 
                child: const Text('Standing on Both Legs',style: TextStyle(color: Colors.white),), 
                onPressed: () { 

                  _showPicker1(context: context); 
                 // print(widget.galleryFile!.path);
                 
                }, 
              ), 
             
         
        ],
    
      
    ),
    Column(
        children: [
         
           const SizedBox( 
                height: 20, 
              ), 
              SizedBox( 
               // height: 200.0, 
               
                child: galleryFile2 == null 
                    ?  Center(child:  Container(
                      height: 100,
                      child: Image.asset("assets/upload_video.png"))) 
                    : Center(child: Text("Uploded Sucessfully")), 
              ), 
          ElevatedButton( 
                style: ButtonStyle( 
                    backgroundColor: MaterialStateProperty.all(Colors.green)), 
                child: const Text('Standing on right Leg',style: TextStyle(color: Colors.white),), 
                onPressed: () { 

                  _showPicker2(context: context); 
                 
                }, 
              ), 
             
         
        ],
      
      
    ),
    Column(
        children: [
          
           const SizedBox( 
                height: 20, 
              ), 
              SizedBox( 
               // height: 200.0, 
               
                child: galleryFile3 == null 
                    ?  Center(child:  Container(
                      height: 100,
                      child: Image.asset("assets/upload_video.png"))) 
                    : Center(child: Text("Uploded Sucessfully")), 
              ), 
          ElevatedButton( 
                style: ButtonStyle( 
                    backgroundColor: MaterialStateProperty.all(Colors.green)), 
                child: const Text('Standing on Left Leg'), 
                onPressed: () { 

                  _showPicker3(context: context); 
                 
                }, 
              ), 
             
         
        ],
      
      
    ),
                
               // VideoRecoreder2(galleryFile: galleryFile2,),
              //  VideoRecoreder3(galleryFile: galleryFile3,),
                
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(onPressed:() {
                  print("hann${galleryFile1}");
                  isLoading=true;
                  uploadvideorombergtest();
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
                child:Text("Submit"))
                
               
           
          ],
        ),
      ),
      
    );
  }



  
   Future uploadvideorombergtest()async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

   //var images= File('image.jpg').writeAsBytes(_signatureBytes!);
  
    var uri = Uri.parse('https://bmdublog.com/mediclear/api/rombergTest'); // Replace with your server's endpoint
    var request = http.MultipartRequest("POST", uri);
        //..files.add(await http.MultipartFile.fromPath('consumer_profile_image', imageFile!.path));
      
    request.headers['Authorization'] =
        'Bearer ' + '$token';
        if(galleryFile1!=null)
        request.files.add(await http.MultipartFile.fromPath('both_legs', galleryFile1!.path));
        if(galleryFile2!=null)
        request.files.add(await http.MultipartFile.fromPath('left_leg', galleryFile2!.path));
         if(galleryFile3!=null)
        request.files.add(await http.MultipartFile.fromPath('right_leg', galleryFile3!.path));
        // if(_signatureBytes!=null
        // request.files.add(await http.MultipartFile.fromPath('consumer_sign_image_name',images.toString()));
        // Add additional parameters
    request.fields['medical_details_id'] = widget.medical_id;
    request.fields['test_type_id'] = '${1}';
   // print(video1);
    print("saurabh${widget.medical_id}");
    

    // Send the request
    
    var response = await request.send();

    // Check the response
    print(response);
    if(response.statusCode==200)
    {
      isLoading=false;
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
              Image.asset("assets/romberg_eye_image.gif"),
              SizedBox(height: 20,),
              Text("Hurrah!!, Romberg Test done successfully",)
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
       isLoading=false;
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
              Image.asset("assets/romberg_eye_image.gif"),
              SizedBox(height: 20,),
              Text("Romberg Test Failed",)
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
                  print(galleryFile1);
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
          galleryFile1 = File(pickedFile!.path); 
          print("hii${pickedFile!.path}");
           print("hlooooi${galleryFile1}");
          
        } else { 
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
              const SnackBar(content: Text('Please upload a video'))); 
        } 
      }, 
    ); 
} 


 void _showPicker2({ 
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
                  getVideo2(ImageSource.gallery); 
                 Navigator.of(context).pop(); 
                }, 
              ), 
              ListTile( 
                leading: const Icon(Icons.photo_camera), 
                title: const Text('Camera'), 
                onTap: () { 
                  getVideo2(ImageSource.camera); 
                  print(galleryFile1);
                  Navigator.of(context).pop(); 

                }, 
              ), 
            ], 
          ), 
        ); 
      }, 
    ); 
  } 
  
    
  
  Future getVideo2( 
    ImageSource img,
  
  ) async { 
    final pickedFile = await picker2.pickVideo( 
        source: img, 
        preferredCameraDevice: CameraDevice.front, 
        maxDuration: const Duration(seconds: 30)); 
    XFile? xfilePick = pickedFile; 
    setState( 
      () { 
        if (xfilePick != null) { 
          galleryFile2 = File(pickedFile!.path); 
          print("hii2${pickedFile!.path}");
           print("hlooooi2${galleryFile2}");
          
        } else { 
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
              const SnackBar(content: Text('Please upload a video'))); 
        } 
      }, 
    ); 
} 


 void _showPicker3({ 
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
                  getVideo3(ImageSource.gallery); 
                 Navigator.of(context).pop(); 
                }, 
              ), 
              ListTile( 
                leading: const Icon(Icons.photo_camera), 
                title: const Text('Camera'), 
                onTap: () { 
                  getVideo3(ImageSource.camera); 
                  print(galleryFile1);
                  Navigator.of(context).pop(); 

                }, 
              ), 
            ], 
          ), 
        ); 
      }, 
    ); 
  } 
  
    
  
  Future getVideo3( 
    ImageSource img,
  
  ) async { 
    final pickedFile = await picker3.pickVideo( 
        source: img, 
        preferredCameraDevice: CameraDevice.front, 
        maxDuration: const Duration(seconds: 30)); 
    XFile? xfilePick = pickedFile; 
    setState( 
      () { 
        if (xfilePick != null) { 
          galleryFile3 = File(pickedFile!.path); 
          print("hii3${pickedFile!.path}");
           print("hlooooi3${galleryFile3}");
          
        } else { 
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<< 
              const SnackBar(content: Text('Please upload a video'))); 
        } 
      }, 
    ); 
} 

  
  
  
  
}





