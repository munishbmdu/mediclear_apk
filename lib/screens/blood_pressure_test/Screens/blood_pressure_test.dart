import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/blood_pressure_test/widgets/switch_button.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/hearing_test/widgets/graph.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BloodPressureTestCreen1 extends StatefulWidget {
   BloodPressureTestCreen1({super.key,required this.id});
  String id;

  @override
  State<BloodPressureTestCreen1> createState() => _BloodPressureTestCreen1State();
}

class _BloodPressureTestCreen1State extends State<BloodPressureTestCreen1> {
   TextEditingController postlower= TextEditingController();
  TextEditingController postupper= TextEditingController();
  TextEditingController preupper= TextEditingController();
  TextEditingController prelower= TextEditingController();
   int _currentIndex = 0;
   bool isLoading=false;

  @override
  Widget build(BuildContext context) {
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return WillPopScope(

      onWillPop: () async{ 
                              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.id,)));
              return true;
       },
      child: Scaffold(
         appBar: AppBar(
          title: Text('MEDICLEAR',style: GoogleFonts.roboto(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
          backgroundColor: Coloors.fontcolor,
            automaticallyImplyLeading: false,
             leading: IconButton(onPressed:() {
                                    SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
                DeviceOrientation.portraitDown,
              ]);
              Navigator.pop(context);
            }, icon:Icon(Icons.navigate_before,color: Colors.white,size: 35,)),
          centerTitle: true,
          elevation: 2,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
               new RotationTransition(
                turns: new AlwaysStoppedAnimation(270/360),
                child: Text("mm-hg",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)),
                Container(
                width: 420,
                
                child:Column(
                  children: [
                    Container(
                      height: 250,
                      child: BloodPressureGraph(prelower: prelower, preupper: preupper, postlower: postlower, postupper: postupper)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Pre",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                        SizedBox(width: 10,),
                        Text("Post",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),)
                      ],
                    )
                  ],
                ),
          
              ),
              SizedBox(width: 10,),
              Container(
                width: 240,
                child:  Column(
        children: [
          // Toggle Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text('Pre BP',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
             Radio(value: 0, groupValue: _currentIndex, onChanged:(value){
                 setState(() {
                   _currentIndex=value!;
                 });
             }),
             Text('Post BP',textAlign: TextAlign.center, style: GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
                Radio(value: 1, groupValue: _currentIndex, onChanged:(value){
                 setState(() {
                   _currentIndex=value!;
                 });
             }),
              
              // Switch(
              //   value: _currentIndex == 0,
              //   onChanged: (value) {
              //     setState(() {
              //       _currentIndex = value ? 0 : 1;
              //     });
              //   },
              // ),
              // Text('Post BP',textAlign: TextAlign.center, style:GoogleFonts.roboto(fontWeight: FontWeight.bold,fontSize:14, color: Coloors.fontcolor),),
            ],
          ),
          // Content based on the selected screen
          IndexedStack(
            index: _currentIndex,
            children: [
              // Screen 1
             Center(
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomeTextField("Lower BP",prelower ),
          SizedBox(
            height: 20,
          ),
          CustomeTextField("Upper BP", preupper),
          SizedBox(
            height: 20,
          ),
        
        ],
      )
    ),

              // Screen 2
             Center(
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomeTextField("Lower BP",postlower ),
          SizedBox(
            height: 20,
          ),
          CustomeTextField("Upper BP", postupper),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                 ElevatedButton(onPressed:() {
           setState(() {
             
           });
          }, 
            style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Coloors.fontcolor
                ), 
          child:Text("Graph",style: GoogleFonts.roboto(color: Colors.white),)),
             isLoading==false? ElevatedButton(onPressed:() {

                if(prelower.text==""||preupper.text==""||postlower.text==""||postupper.text==""){
                showDialog(context: context, builder:(context){
        return AlertDialog(
          content: Container(
            height: 100,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Please fill all the data before submit"),),
                Center(
                  child: ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child:Text("ok")),
                )
              ],
            ),
          ),
        );
       });
                }
                else{
                  isLoading==true;
                  var value={
                    "pre_lower_bp":prelower.text.trim().toString(),
                    "pre_upper_bp":preupper.text.trim().toString(),
                    "post_lower_bp":postlower.text.trim().toString(),
                    "post_upper_bp":postupper.text.trim().toString(),
                    "test_type_id":1,
                    "medical_details_id":widget.id,
                  };
                  
                 ApiDomain().blood_pressure_test(value, context,widget.id);
                 isLoading==false;

                }
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: widget.id,)));
              }, 
                style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      backgroundColor: Coloors.fontcolor
                    ), 
              child:Text("submit",style: GoogleFonts.roboto(color: Colors.white),)):CircularProgressIndicator(),
            ],
          ),
          
        ],
      )
    ),
            ],
          ),
        ],
      
    ))
                
          
            ],
          ),
        ),
      ),
    );
  }
}
//  Widget buildScreen1Content(context,TextEditingController prelower,TextEditingController preupper) {
//     // You can call any widget or UI elements for Screen 1 here
//     return Center(
//       child: Column(
//        // mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           CustomeTextField("Lower BP",prelower ),
//           SizedBox(
//             height: 20,
//           ),
//           CustomeTextField("Upper BP", preupper),
//           SizedBox(
//             height: 20,
//           ),
        
//         ],
//       )
//     );
    
//   }
//    Widget buildScreen2Content(context,TextEditingController postlower,TextEditingController postupper) {
//     // You can call any widget or UI elements for Screen 2 here
//     return  Center(
//       child: Column(
//        // mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           CustomeTextField("Lower BP",postlower ),
//           SizedBox(
//             height: 20,
//           ),
//           CustomeTextField("Upper BP", postupper),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//                  ElevatedButton(onPressed:() {
           
//           }, 
//             style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                   backgroundColor: Coloors.fontcolor
//                 ), 
//           child:Text("Graph",style: GoogleFonts.roboto(color: Colors.white),)),
//               ElevatedButton(onPressed:() {
//                  SystemChrome.setPreferredOrientations([
//                   DeviceOrientation.portraitUp,
//                   DeviceOrientation.portraitDown,
//                 ]);
//                 Navigator.push(context, MaterialPageRoute(builder:(context) => VertigoTest(val2: 1,),));
//               }, 
//                 style: ElevatedButton.styleFrom(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                       backgroundColor: Coloors.fontcolor
//                     ), 
//               child:Text("Finish",style: GoogleFonts.roboto(color: Colors.white),)),
//             ],
//           ),
          
//         ],
//       )
//     );
//   }



Widget CustomeTextField(String title,TextEditingController text){
  return TextFormField(
      //   obscureText: true,
      keyboardType: TextInputType.number,
      controller: text,
      decoration: InputDecoration(
          hintText: title,
          hintStyle: GoogleFonts.roboto(),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Color.fromARGB(255, 48, 6, 234))),
          fillColor: Color.fromARGB(255, 228, 226, 239),
          filled: true),
    );
}


class BloodPressureGraph extends StatefulWidget {
   BloodPressureGraph({super.key,required this.prelower,required this.preupper,required this.postlower,required this.postupper});
   TextEditingController postlower;
  TextEditingController postupper;
  TextEditingController preupper;
  TextEditingController prelower;



  @override
  State<BloodPressureGraph> createState() => _BloodPressureGraphState();
}

class _BloodPressureGraphState extends State<BloodPressureGraph> {
  late ZoomPanBehavior _zoomPanBehavior;
  @override
  void initState() {
    // TODO: implement initState
    
   
      super.initState(); 
       _zoomPanBehavior = ZoomPanBehavior(
                  // Performs zooming on double tap
                  enableSelectionZooming: true,
                  selectionRectBorderColor: Colors.red,
                  selectionRectBorderWidth: 1,
                  selectionRectColor: Colors.grey
                );         
  }
@override
    Widget build(BuildContext context) {
      
         return Scaffold(
            body: Center(
                child: Container(
                    child: SfCartesianChart(
                     //zoomPanBehavior: _zoomPanBehavior,
                       primaryXAxis: NumericAxis( minimum: 0,maximum: 1,interval: 1),
                        series: <ChartSeries>[
                         RangeAreaSeries<ChartData, double>(
            dataSource: <ChartData>[
              ChartData(0,( widget.prelower.text.toString())==""?0:double.parse( widget.prelower.text.toString()), ( widget.preupper.text.toString())==""?0:double.parse(( widget.preupper.text.toString()))),
                ChartData(1,( widget.postlower.text.toString())==""?0:double.parse( widget.postlower.text.toString()), ( widget.postupper.text.toString())==""?0:double.parse(( widget.postupper.text.toString()))),
              // ChartData(1, 7, 3),
              //  ChartData(2, 5, 2),
              //  ChartData(3, 8, 0),
              // ChartData(4, 8, 3),
            ],
            xValueMapper: (ChartData data, _) => data.x,
            highValueMapper: (ChartData data, _) => data.high,
            lowValueMapper: (ChartData data, _) => data.low,
            opacity: 0.5,
            name: 'Range Area',
          ),
                        ]
                    )
                )   
            )
        );
    }
}

  class ChartData {
        ChartData(this.x, this.high, this.low);
            final double x;
            final  high;
            final  low;
    }

// class BloodPressureScreen extends StatefulWidget {
//   @override
//   _BloodPressureScreenState createState() => _BloodPressureScreenState();
// }

// class _BloodPressureScreenState extends State<BloodPressureScreen> {
//   TextEditingController preController = TextEditingController();
//   TextEditingController postController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blood Pressure Tracker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextField(
//               controller: preController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Pre Blood Pressure (mmHg)'),
//             ),
//             TextField(
//               controller: postController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Post Blood Pressure (mmHg)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 // Yahan par aap pre aur post values le sakte hain
//                 double preValue = double.parse(preController.text);
//                 double postValue = double.parse(postController.text);
//                 // Ab aap in values ka use karke graph banane ke liye kuch karein
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// }
// class BloodPressureScreen2 extends StatefulWidget {
//   @override
//   _BloodPressureScreen2State createState() => _BloodPressureScreen2State();
// }

// class _BloodPressureScreen2State extends State<BloodPressureScreen2> {
//   TextEditingController preController = TextEditingController();
//   TextEditingController postController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Blood Pressure Tracker'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextField(
//               controller: preController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Pre Blood Pressure (mmHg)'),
//             ),
//             TextField(
//               controller: postController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Post Blood Pressure (mmHg)'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 double preValue = double.parse(preController.text);
//                 double postValue = double.parse(postController.text);
//                 showDialog(
//                   context: context,
//                   builder: (context) {
//                     return AlertDialog(
//                       content: SizedBox(
//                         width: 300,
//                         height: 300,
//                         child: SfCartesianChart(
//                           primaryXAxis: CategoryAxis(),
//                           primaryYAxis: NumericAxis(),
//                           series: <ChartSeries>[
//                             LineSeries<Map<String, dynamic>, String>(
//                               dataSource: [
//                                 {'category': 'Pre', 'value': preValue},
//                                 {'category': 'Post', 'value': postValue},
//                               ],
//                               xValueMapper: (Map<String, dynamic> data, _) => data['category'],
//                               yValueMapper: (Map<String, dynamic> data, _) => data['value'],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }