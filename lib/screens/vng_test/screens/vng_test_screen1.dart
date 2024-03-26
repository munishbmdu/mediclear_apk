
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/login_page/login_page1.dart';


class VngTestScreen1 extends StatelessWidget {
  const VngTestScreen1({super.key});

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text("Please Focus on the camera while looking to the Screen",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 18, color: Coloors.fontcolor),),
          ),
          SizedBox(
            height: 200,
          ),
        MyButton(name: "Start", width: 320, height: 50, onPressedCallback: (){
          Navigator.of(context).push(MaterialPageRoute(builder:(context) => VNGTEST(),));
        })
        ],
      ),
    );
  }
}


class VNGTEST extends StatefulWidget {
  @override
  _VNGTESTState createState() => _VNGTESTState();
}

class _VNGTESTState extends State<VNGTEST> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

   @override
  void initState() {
    super.initState();

    // Initialize the camera
    _initializeControllerFuture = _initCameraController();
  }

  Future<void> _initCameraController() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[1], ResolutionPreset.medium);
    return _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
           RotationTransition(
            turns:AlwaysStoppedAnimation(180/360),
             child: Container(
               height: MediaQuery.of(context).size.height,
               width:  MediaQuery.of(context).size.width,

               decoration: BoxDecoration(
                
               ),
              child: Image.asset("assets/vng1.gif",fit: BoxFit.cover,),

             ),
           ),
          // Camera Preview in the corner
          Positioned(
            bottom: 0.0,
            right: 0.0,
            width: 150.0,
            height: 150.0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              // Camera Preview
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: MyButton(name: "Done", width: 100, height: 50, onPressedCallback: (){
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder:(context) => VertigoTest(val7: 1,),));
              });
            

          })),
          Positioned(
            left: MediaQuery.of(context).size.width/2.23,
            bottom: MediaQuery.of(context).size.height/2.11,
            child: Container(height: 45,
          width: 55,
          color: Colors.white,
          ))
        ],
      ),
    );
  }
}






/// Stateful widget to fetch and then display video content.
