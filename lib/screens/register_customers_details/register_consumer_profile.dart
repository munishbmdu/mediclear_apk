
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/application_form/widgets/datetime.dart';
import 'package:mediclear_labs/screens/application_form/widgets/geneder_checkbox.dart';
import 'package:mediclear_labs/screens/application_form/widgets/phone_number_enter.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ProfileScreen extends StatefulWidget {
   ProfileScreen({super.key,required this.consumer_id});
   var consumer_id;


  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}
class _ProfileScreen extends State<ProfileScreen> {
    File? imageFile2;
   var img;
  TextEditingController adhhar=TextEditingController();
 
  TextEditingController city=TextEditingController();
   TextEditingController email=TextEditingController();
   TextEditingController name=TextEditingController();
   TextEditingController phone=TextEditingController();
   TextEditingController gender=TextEditingController();
   String id="";
   bool isloading=false;
   var image="";

   bool question1=false;
  bool question2 = false;
  bool question3 = false;
  bool question4 = false;
  bool question5 = false;
  bool question6 = false;
  bool question7 = false;
  bool question8 = false;
  bool pastquestion1 = false;
  bool pastquestion2 = false;
  bool pastquestion3 = false;
  bool pastquestion4 = false;
  bool pastquestion5 = false;

   bool pastquestion11 = false;
  bool pastquestion12 = false;
  bool pastquestion13 = false;
  bool pastquestion14 = false;
  bool pastquestion15 = false;
  bool pastquestion2a1 = false;
  bool pastquestion2a2 = false;
  bool pastquestion2a3 = false;
  bool pastquestion2a4 = false;
  bool pastquestion2a5 = false;
  bool pastquestion2a6 = false;
  bool pastquestion2b1 = false;
  bool pastquestion2b2 = false;
  bool pastquestion2b3 = false;
  bool pastquestion2b4 = false;
  bool pastquestion2b5 = false;
  bool pastquestion2b6 = false;
  bool pastquestion2c1 = false;
  bool pastquestion2c2 = false;
  bool pastquestion2c3 = false;
  bool pastquestion2c4 = false;
  bool pastquestion2c5 = false;
  bool pastquestion2c6 = false;

     bool pastquestionc1 = false;
  bool pastquestionc2 = false;
  bool pastquestionc3 = false;
  bool pastquestionc4 = false;
   bool pastquestionc5 = false;
  bool pastquestionc6 = false;

   bool male = false;
  bool female = false;
  bool others = false;

  List complain=[];
   
  //  var value={
  //   'id':widget.consumer_id
  //  };
bool isEdit=false;
Future updatedetails(Object value)async{
  print(value);
   final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}edit-consumer-medical-data"),
    
    body:jsonEncode(value),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
      
      var rest= jsonDecode(response.body);
      print(response.body);
      if(rest['status'] == "success"){
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${rest['message']}')));
        isEdit=false;
       Navigator.pop(context);
    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestScreen()));
     // Navigator.pop(context);
       // Get.offAll(Home_view());
      }
    }
    else {
       // alertBoxdialogBox(context, 'Alert', '${rest['message']}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration not sucessfull,please check your details')));
      }
   }

   Future getConsumerProfileData()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}consumer-data"),
    body: jsonEncode(widget.consumer_id),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
    
        setState(() {
          
        });
     
      var dataa=jsonDecode(response.body);
      var data=dataa['data'];
       email.text=data['id']==null?"":data['id'].toString();
            name.text=data['consumer_name']==null?"":data['consumer_name'].toString();
            phone.text=data['consumer_mob_no']==null?"Not Available":data['consumer_mob_no'].toString();
            adhhar.text=data['consumer_addhar_number']==null?"":data['consumer_addhar_number'].toString();
            city.text=data['consumer_location']==null?"":data['consumer_location'].toString();
            gender.text=data['gender']==null?"":data['gender'].toString();
             question1=data['light_hedness_or_swim_sensation_in_the_head']==null?false:data['light_hedness_or_swim_sensation_in_the_head']=="yes"?true:false;
              question2=data['blacking_out_or_loss_of_consciousness']==null?false:data['blacking_out_or_loss_of_consciousness']=="yes"?true:false;
              question3=data['object_spinning_or_turning_around_you']==null?false:data['object_spinning_or_turning_around_you']=="yes"?true:false;
              question4=data['nausea_or_vomiting']==null?false:data['nausea_or_vomiting']=="yes"?true:false;
              question5=data['tingling_in_your_fingers_toes_around_your_mouth']==null?false:data['tingling_in_your_fingers_toes_around_your_mouth']=="yes"?true:false;
              question6=data['does_changes_of_position_make_you_dizzy']==null?false:data['does_changes_of_position_make_you_dizzy']=="yes"?true:false;
              question7=data['when_you_are_dizzy_must_support_yourself_when_standing']==null?false:data['when_you_are_dizzy_must_support_yourself_when_standing']=="yes"?true:false;   
              var pasthistoryList1=data['post_mediacal_history_disease'];
               var difficultyInHearing=data['defficulting_in_hearing'];
               var noiseInEarsList=data['noise_in_ears']; 
                var fullness_or_stuffiness_in_your_ears=data['fullness_or_stuffiness_in_your_ears'];
                  var complaints=data['complaints'];
                  // setState(() {
                    
                  // });
                    if(gender.text=="male"){
              male=true;
            }
             if(gender.text=="female"){
              female=true;
            }
              if(gender.text=="others"){
              others=true;
            }
              // question1=data['light_hedness_or_swim_sensation_in_the_head']==null?false:data['light_hedness_or_swim_sensation_in_the_head']=="yes"?true:false;
              // question2=data['blacking_out_or_loss_of_consciousness']==null?false:data['blacking_out_or_loss_of_consciousness']=="yes"?true:false;
              // question3=data['object_spinning_or_turning_around_you']==null?false:data['object_spinning_or_turning_around_you']=="yes"?true:false;
              // question4=data['nausea_or_vomiting']==null?false:data['nausea_or_vomiting']=="yes"?true:false;
              // question5=data['tingling_in_your_fingers_toes_around_your_mouth']==null?false:data['tingling_in_your_fingers_toes_around_your_mouth']=="yes"?true:false;
              // question6=data['does_changes_of_position_make_you_dizzy']==null?false:data['does_changes_of_position_make_you_dizzy']=="yes"?true:false;
              // question7=data['when_you_are_dizzy_must_support_yourself_when_standing']==null?false:data['when_you_are_dizzy_must_support_yourself_when_standing']=="yes"?true:false;   
              // var pasthistoryList1=data['post_mediacal_history_disease'];
              for(int i=1;i<6;i++){
                if(pasthistoryList1.contains(i))
                {
                  if(i==1)
                  pastquestion11=true;
                  if(i==2){
                    pastquestion12=true;
                  }
                  if(i==3)
                  pastquestion13=true;
                  if(i==4)
                  pastquestion14=true;
                  if(i==5)
                  pastquestion15=true;
                }
              }
               
                for(int i=1;i<7;i++){
                if(difficultyInHearing.contains(i))
                {
                  if(i==1)
                  pastquestion2a1=true;
                  if(i==2){
                    pastquestion2a2=true;
                  }
                  if(i==3)
                  pastquestion2a3=true;
                  if(i==4)
                  pastquestion2a4=true;
                  if(i==5)
                  pastquestion2a5=true;
                  if(i==6)
                  pastquestion2a6=true;
                }
              }
             
                for(int i=1;i<6;i++){
                if(noiseInEarsList.contains(i))
                {
                  if(i==1)
                  pastquestion2b1=true;
                  if(i==2){
                    pastquestion2b2=true;
                  }
                  if(i==3)
                  pastquestion2b3=true;
                  if(i==4)
                  pastquestion2b4=true;
                  if(i==5)
                  pastquestion2b5=true;
                  if(i==6)
                  pastquestion2b6=true;
                }
              }
              
                for(int i=1;i<6;i++){
                if(fullness_or_stuffiness_in_your_ears.contains(i))
                {
                  if(i==1)
                  pastquestion2c1=true;
                  if(i==2){
                    pastquestion2c2=true;
                  }
                  if(i==3)
                  pastquestion2c3=true;
                  if(i==4)
                  pastquestion2c4=true;
                  if(i==5)
                  pastquestion2c5=true;
                  if(i==6)
                  pastquestion2c6=true;
                }
              }
              
                for(int i=1;i<6;i++){
                if(complaints.contains(i))
                {
                  if(i==1)
                  pastquestionc1=true;
                  if(i==2){
                    pastquestionc2=true;
                  }
                  if(i==3)
                  pastquestionc3=true;
                  if(i==4)
                  pastquestionc4=true;
                  if(i==5)
                  pastquestionc5=true;
                  if(i==6)
                  pastquestionc6=true;
                }
              }
              
           
            // setState(() {
            

            // });
          
            print("sgfsgf${question1}");
          
           
            // id=data['id'];
          // img=data['consumer_profile_image_name'];
            

      print(dataa);

    // return data['Userdata'];
    }
 
  }
   
   @override
  void initState() {
    // TODO: implement initState
    getConsumerProfileData();
    super.initState();
    
     

    
  }

  @override
  Widget build(BuildContext context) {
 // getConsumerProfileData();
    var size = MediaQuery.of(context).size;
    print("rebuild");
    return Scaffold(
        appBar: AppBar(automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);
          },icon: Icon(Icons.arrow_back,color:Colors.black,),),
          title: Text('Consumer Profile ',style: TextStyle(fontWeight: FontWeight.w500,color: Coloors.fontcolor),),
        ),
        resizeToAvoidBottomInset: true,
        // endDrawer: Drawers(context),
        body:
          //  print(state.text.toString());

             SingleChildScrollView(
              child: Column(
                children: [
               
                 // SizedBox(height: 15,),
                
                 Column(
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: name,
                                readOnly: true,
                                decoration: InputDecoration(hintText: 'Name',hintStyle: GoogleFonts.poppins()),
                                
                                keyboardType: TextInputType.text,
                               
                              ),
                            ),
                           Container(
                              width: 200,
                                                    
                              child:      
                                    TextFormField(
                                      readOnly: true,
                                    //  initialValue:"",
                                     // controller: batch,
                                      decoration: InputDecoration(hintText: 'Batch number',hintStyle: GoogleFonts.poppins()),
                                      keyboardType: TextInputType.emailAddress,
                                   
                                        //                  
                                    ), 
                                    
                                      //              
                            ),
                            Container(
                              width: 200,
                              child: TextFormField(
                                controller: city,
                                readOnly: true,
                                decoration: InputDecoration(hintText: 'Location',hintStyle: GoogleFonts.poppins()
                               
                                ),
                              
                              ),
                            ),
                          ],
                        ),
                      ),
                       //                 InkWell(
                       //      highlightColor:Colors.transparent,
                       //       enableFeedback: false,
                       //       onTap:  () async {
                       //         Map<Permission, PermissionStatus> statuses = await [
                       //           Permission.storage, Permission.camera,
                       //         ].request();
                       //         if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
                       //           showImagePicker(context);
                       //         } else {
                       //           print('no permission provided');
                       //         }
                       //       },
                       //   child: imageFile == null
                       //       ? Padding(
                       //         padding: const EdgeInsets.symmetric(horizontal: 0,),
                       //         child: Container(
                       //           decoration: BoxDecoration(
                       //             border: Border.all(color: Colors.grey,),
                       //             borderRadius: BorderRadius.circular(10)
                       //           ),
                       //           child:Icon(Icons.person_add_alt,size: 80,)
                       //           ),
                       //       )
                       //       : Stack(
                       //         children: [
                       //           Container(
                       //             decoration: BoxDecoration(
                       //               border: Border.all(color: Colors.grey)
                       //             ),
                       //             child: Image.file(imageFile!, height: 110.0, width: 110.0, fit: BoxFit.fill,)),
                       //             Positioned(
                       //               top: -15,
                       //               right: -10,
                       //               child: IconButton(onPressed:() {
                       //                 setState(() {
                       //                   imageFile=null;
                       //                 });
                       //               }, icon: Icon(Icons.close,color: Coloors.fontcolor,)))
                       //         ],
                       //       ),
                       // ),
                     //  SizedBox(height: 20,),
                    FutureBuilder(
                            future: ApiDomain().getConsumerProfileData(widget.consumer_id,context),
                            builder: (context,snapshot) {
                              if(snapshot.hasError)
                              return Center(child: CircularProgressIndicator(),);
                               if(!snapshot.hasData){
                             
                               return Center(child: CircularProgressIndicator(),);
                               
                               }
                              
                              img=snapshot.data['consumer_profile_image_name'];
                              image=snapshot.data['consumer_sign_image_name'];
                              print(image);
                              
                             return Card(
                              //  radius: 60,
                                 // backgroundImage: img!= "customer profile not updated"? NetworkImage(img,):null ,
                                   child:imageFile2==null? img== "customer profile not updated"?Icon(Icons.person):Padding(
                                     padding: const EdgeInsets.all(2.0),
                                     child: Image.network(img,fit: BoxFit.cover,width: 120,height: 130,),
                                   ):Image.file(File(imageFile2!.path,),fit: BoxFit.cover,height: 130,width: 120,)
                                // // //   child:(snapshot.data['customer_profile_image']!="customer profile not updated")?Image.network(snapshot.data['customer_profile_image'],):Icon(Icons.person),
                                                       //   child: snapshot.data['customer_profile_image'].toString()!="https://qbacp.com/mediclear/" ? Image.network(snapshot.data['customer_profile_image']!.toString()):Icon(Icons.person),
                                                      // backgroundImage: SelectedImage ==null ? Image(image: Image.file(SelectedImage!),):Icon(Icons.person) ,
                              );
                            }
                          ),   
                     
                    ],
                  ),
                       
                               
                  //                      FutureBuilder(
                  //                       future:ApiDomain().getProfileData(),
                  // builder: (context,snapshot) {
                  //   if(!snapshot.hasData||snapshot.hasError)
                  //   return Container();
                  //   return 
                    
                  //   snapshot.data['type']!="customer"?
                  //                          TextField(
                  //                                  controller: company,
                  //                                   onTap: (){
                  //                        getCompany(value={"batch_no":batchController.text.toString()});
                  //                         showDialog(context: context, builder:(context){
                  //                         return AlertDialog(
                                            
                  //                           title: Text("Please select Your Company",style: GoogleFonts.poppins(),),
                  //                           content:Container(
                  //                             height: 200,
                  //                             child: FutureBuilder(future: getCompany(value={
                  //                               'batch_no':batchController.text.toString()
                  //                             }), builder:(context,snapshot){
                  //                              if(snapshot.hasError||!snapshot.hasData)
                  //                              return Center(child: CircularProgressIndicator(
                                                                                        
                  //                              ),);
                  //                              return  ListView.builder(
                  //                               itemCount: snapshot.data.length,
                  //                               itemBuilder: (context,index){
                  //                                  return  ListTile(
                  //                                   title: Text("${snapshot.data[index]['company_name']}"),
                  //                                   subtitle:Text("Company Id: ${snapshot.data[index]['company_id']}",style: TextStyle(color: Coloors.fontcolor),),
                  //                                   onTap: (){
                  //                                     companyController.text=snapshot.data[index]['company_name'];
                  //                                     comapny_id=snapshot.data[index]['company_id'];
                  //                                     Navigator.pop(context);
                  //                                   },
                  //                                  );
                  //                               });
                  //                             }),
                  //                           )
                  //                         );
                  //                       });
                  //                     },
                  //                                  decoration: InputDecoration(
                  //                                hintText: "Company",
                  //                                hintStyle: GoogleFonts.poppins()
                  //                               //  suffixIcon: PopupMenuButton<String>(
                  //                               //    icon: const Icon(Icons.arrow_drop_down),
                  //                               //    onSelected: (String value) {
                  //                               //      companyController.text = value;
                  //                               //    },
                  //                               //    itemBuilder: (BuildContext context) {
                  //                               //      return items
                  //                               //          .map<PopupMenuItem<String>>((String value) {
                  //                               //        return new PopupMenuItem(
                  //                               //            child: new Text(value), value: value);
                  //                               //      }).toList();
                  //                               //    },
                  //                               //  ),
                  //                                  ),
                                                 
                  //                                ):Container();
                  //                        }
                  //                      ),
                                 
                  
                    
                  const SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Container(
                      child: TextFormField(
                        controller: phone,
                       // maxLength: 10,
                       readOnly: true,
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
                       
                 //DateTimer(),
                              //    DOBWidget(dobController: dobController,),
                               
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: TextFormField(
                      controller: adhhar,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Addhar Number",
                        hintStyle: GoogleFonts.poppins()
                      ),
                      // decoration: const InputDecoration(labelText: 'Addhar Number'),
                      keyboardType: TextInputType.number,
                      maxLength: 12,
                                     
                    ),
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 12),
                         child: Text(
                          "Gender",style: GoogleFonts.poppins(color: Colors.grey.shade700,fontSize: 16),
                                               ),
                       ),
                     Row(
      children: [
        Checkbox(
          value: male,
          onChanged: (bool? value) {
            // setState(() {
            //   male = value!;
            //   gender.text="male";
            //   if (male) {
            //     // Handle male selection
            //     female = false;
            //     others = false;
            //   }
            // });
          },
        ),
        Text('Male'),
        Checkbox(
          value: female,
          onChanged: (bool? value) {
            // setState(() {
            //   female = value!;
            //   gender.text="female";
            //   if (female) {
               
            //     male = false;
            //     others = false;
            //   }
            // });
          },
        ),
        Text('Female'),
        Checkbox(
          value: others,
          onChanged: (bool? value) {
            // setState(() {
            //   others = value!;
            //   gender.text="others";
            //   if (others) {
              
            //     male = false;
            //     female = false;
            //   }
            // });
          },
        ),
        Text('Others'),
      ],
    ),

     FutureBuilder(
                            future: ApiDomain().getConsumerProfileData(widget.consumer_id,context),
                            builder: (context,snapshot) {
                              if(snapshot.hasError)
                              return Center(child: CircularProgressIndicator(),);
                               if(!snapshot.hasData)
                              return Center(child: CircularProgressIndicator(),);
                              
                             // img=snapshot.data['consumer_profile_image_name'];
                              image=snapshot.data['consumer_sign_image_name'];
                              print(image);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("Signature: ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          SizedBox(width: 30,),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Coloors.fontcolor,width: 2)
                            ),
                            height: 50,
                            width: 200,
                            child: image!="consumer sign not entered"? Image.network(image,fit:BoxFit.cover,):Center(child: Text("consumer sign not entered"))),
                        ],
                      );
                    }
                  ),
                  
                    ],
                  ),
                 
                  
                  
                  SizedBox(height: 10,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                   children: [
                     const SizedBox(height: 20.0),
                                 const Text(
                  'To be filled by the candidate before Medical Examination:',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),
                  textAlign: TextAlign.start,
                                 ),
                                 const SizedBox(
                  height: 7,
                                 ),
                                 const Text(
                  ' A. When you are "dizzy" do you experience any of the following symptoms? (check yes or no)',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black,fontSize: 15),
                                 ),
                                 const SizedBox(
                  height: 10,
                                 ),
                                 CheckboxListTile(
                  title: const Text(
                      "1. Light-headedness or swimming sensation in the head?",
                      textAlign: TextAlign.start,style: TextStyle(
                        fontSize: 15
                      ),),
                  value: question1,
                  onChanged: (value) {
                    // setState(() {
                    // //  question1 = value!;
                    // });
                  },
                                 ),
                  CheckboxListTile(
                                  title: const Text('2. Blacking out or loss of consciousness?',
                  style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                                  value: question2,
                                  onChanged: (value) {
                  //                   setState(() {
                  // question2 = value!;
                  //                   });
                                  },
                                ),
                                 CheckboxListTile(
                  title: const Text('3. Object spinning or tuming around you?',
                  style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                  value: question3,
                  onChanged: (value) {
                                 // setState(() {
                                 //   question3 = value!;
                                 // });
                  },
                                 ),
                                 CheckboxListTile(
                  title: const Text('4. Nausea or vomiting?',
                 style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                  value: question4,
                  onChanged: (value) {
                                 // setState(() {
                                 //   question4 = value!;
                                 // });
                  },
                                 ),
                                 CheckboxListTile(
                  title: const Text(
                  '5. Tingling in your fingers, toes or around your mouth?',
                 style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                  value: question5,
                  onChanged: (value) {
                                 // setState(() {
                                 //   question5 = value!;
                                 // });
                  },
                                 ),
                                 CheckboxListTile(
                  title: const Text('6. Does change of position make you dizzy?',
                 style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                  value: question6,
                  onChanged: (value) {
                                 // setState(() {
                                 //   question6 = value!;
                                 // });
                  },
                                 ),
                                 CheckboxListTile(
                  title: const Text(
                  '7.  When you are dizzy, must you support yourself when standing?',
                  style: TextStyle(
                    fontSize: 15
                  ),
                  textAlign: TextAlign.start),
                  value: question7,
                  onChanged: (value) {
                                 // setState(() {
                                 //   question7 = value!;
                                 // });
                  },
                                 ),
                               
                                 const SizedBox(
                  height: 10,
                                 ),
                 
                   ],
                 
                  ),
                  
                  ),
                         
                         Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 10),
                           child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                           const Text(
                             "Past Medical History:",
                             style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                           ),
                           const SizedBox(
                             height: 5,
                           ),
                           
                            Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text(
                             "1. Do you have a history of any of the following? please check all that apply",style: TextStyle(fontSize: 14),),
                             Container(
                               height: 30,
                               child: Row(
                                 children: [
                  Text("Heart disease", style: TextStyle(fontSize: 14)),
                  SizedBox(width: 32,),
                  Checkbox(
                      value: pastquestion11,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion11 = value!;
                          // if(pastquestion11==true){
                          //   widget.que1.add(1);
                            
                          // }
                          // else{
                          //   widget.que1.remove(1);
                          // }
                        });
                      }
                  ),
                  SizedBox(width: 16,),
                     Text("Hypertension", style: TextStyle(fontSize: 14)),
                     SizedBox(width: 30,),
                  Checkbox(
                      value: pastquestion12,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion12 = value!;
                          // if(pastquestion12==true){
                          //   widget.que1.add(2);
                           
                          // }
                          // else{
                          //   widget.que1.remove(2);
                          // }
                        });
                      }
                                 ),
                                 ],
                               ),
                             ),
                           
                             Container(
                               height: 30,
                               child: Row(
                                 children: [
                  Text("Kidney disease", style: TextStyle(fontSize: 14)),
                  SizedBox(width: 25,),
                  Checkbox(
                      value: pastquestion13,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion13 = value!;
                          // if(pastquestion13==true)
                          // {
                          //   widget.que1.add(3);
                          // }
                          // else{
                          //   widget.que1.remove(3);
                          // }
                        });
                      }
                  ),
                  SizedBox(width: 17,),
                   Text("Thyroid disease", style: TextStyle(fontSize: 14)),
                   SizedBox(width: 15,),
                  Checkbox(
                       value: pastquestion14,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion14 = value!;
                          // if(pastquestion14==true)
                          // widget.que1.add(4);
                          // else
                          // widget.que1.remove(4);
                        });
                      }
                                 ),
                                 ],
                               ),
                             ),
                             Container(
                               height: 30,
                               child: Row(
                                 children: [
                    Text("Migrain headaches", style: TextStyle(fontSize: 14)),
                  Checkbox(
                     value: pastquestion15,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion15 = value!;
                          // if(pastquestion15==true)
                          // widget.que1.add(5);
                          // else
                          // widget.que1.remove(5);
                        });
                      }
                                 ),
                                 ],
                               ),
                             ),
                           ],
                                 
                               ),
                           
                           SizedBox(
                             height: 10,
                           ),
                           const Text(
                               "2. Do you have a history of any of the following Symptoms? please check all that apply",style: TextStyle(fontSize: 14),),
                           SizedBox(
                             height: 15,
                           ),
                           Text("a. Difficulty in hearing?"),
                           Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             children: [
                               Container(
                                 height: 25,
                                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Yes",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2a1,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2a1 = value!;
                          // if(pastquestion2a1==true)
                          // widget.que2a.add(1);
                          // else
                          // widget.que2a.remove(1);
                        });
                      },
                    ),
                    Row(
                      children: [
                        const Text("No",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2a2,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2a2 = value!;
                          //        if(pastquestion2a2==true)
                          // widget.que2a.add(2);
                          // else
                          // widget.que2a.remove(2);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Left ear",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2a3,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2a3 = value!;
                          //        if(pastquestion2a3==true)
                          // widget.que2a.add(3);
                          // else
                          // widget.que2a.remove(3);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Both ears",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2a4,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2a4 = value!;
                          //        if(pastquestion2a4==true)
                          // widget.que2a.add(4);
                          // else
                          // widget.que2a.remove(4);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                                 ),
                               ),
                               Container(
                                 height: 25,
                                 child: Row(
                  children: [
                    const Text("Right ear",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2a5,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2a5 = value!;
                          //    if(pastquestion2a5==true)
                          // widget.que2a.add(5);
                          // else
                          // widget.que2a.remove(5);
                        });
                      },
                    ),
                    const Text("associated with attack",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2a6,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2a6 = value!;
                          //    if(pastquestion2a6==true)
                          // widget.que2a.add(6);
                          // else
                          // widget.que2a.remove(6);
                        });
                      },
                    ),
                  ],
                                 ),
                               ),
                             ],
                           ),
                                SizedBox(
                             height: 15,
                           ),
                           Text("b. Noise in ears?",style: TextStyle(fontSize: 14),),
                           Column(
                             children: [
                               Container(
                                 height: 25,
                                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Yes",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2b1,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2b1 = value!;
                          
                          // if(pastquestion2b1==true)
                          // widget.que2b.add(1);
                          // else
                          // widget.que2b.remove(1);
                        });
                      },
                    ),
                    Row(
                      children: [
                        const Text("No",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2b2,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2b2 = value!;
                              
                          // if(pastquestion2b1==true)
                          // widget.que2b.add(2);
                          // else
                          // widget.que2b.remove(2);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Left ear",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2b3,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2b3 = value!;
                              
                          // if(pastquestion2b3==true)
                          // widget.que2b.add(3);
                          // else
                          // widget.que2b.remove(3);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Both ears",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2b4,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2b4 = value!;
                              
                          // if(pastquestion2b4==true)
                          // widget.que2b.add(4);
                          // else
                          // widget.que2b.remove(4);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                                 ),
                               ),
                               Container(
                                 height: 25,
                                 child: Row(
                  children: [
                    const Text("Right ear",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2b5,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2b5 = value!;
                         
                          // if(pastquestion2b5==true)
                          // widget.que2b.add(5);
                          // else
                          // widget.que2b.remove(5);
                        });
                      },
                    ),
                    const Text("associated with attack",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2b6,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2b6 = value!;
                           
                          // if(pastquestion2b6==true)
                          // widget.que2b.add(6);
                          // else
                          // widget.que2b.remove(6);
                        });
                      },
                    ),
                  ],
                                 ),
                               ),
                             ],
                           ),
                             SizedBox(
                             height: 15,
                           ),
                           Text("c. fullness or stuffiness in your ears",style: TextStyle(fontSize: 14),),
                           Column(
                             children: [
                               Container(
                                 height: 25,
                                 child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Yes",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2c1,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2c1 = value!;
                           
                          // if(pastquestion2c1==true)
                          // widget.que2c.add(1);
                          // else
                          // widget.que2c.remove(1);
                        });
                      },
                    ),
                    Row(
                      children: [
                        const Text("No",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2c2,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2c2 = value!;
                               
                          // if(pastquestion2c2==true)
                          // widget.que2c.add(2);
                          // else
                          // widget.que2c.remove(2);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Left ear",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2c3,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2c3 = value!;
                             
                          // if(pastquestion2c3==true)
                          // widget.que2c.add(3);
                          // else
                          // widget.que2c.remove(3);
                            });
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Both ears",style: TextStyle(fontSize: 14),),
                        Checkbox(
                          value: pastquestion2c4,
                          onChanged: (value) {
                            setState(() {
                          //     pastquestion2c4 = value!;
                             
                          // if(pastquestion2c4==true)
                          // widget.que2c.add(4);
                          // else
                          // widget.que2c.remove(4);
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                                 ),
                               ),
                               Container(
                                 height: 25,
                                 child: Row(
                  children: [
                    const Text("Right ear",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2c5,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2c5 = value!;
                      
                          // if(pastquestion2c5==true)
                          // widget.que2a.add(5);
                          // else
                          // widget.que2a.remove(5);
                        });
                      },
                    ),
                    const Text("associated with attack",style: TextStyle(fontSize: 14),),
                    Checkbox(
                      value: pastquestion2c6,
                      onChanged: (value) {
                        setState(() {
                          // pastquestion2c6 = value!;
                      
                          // if(pastquestion2c6==true)
                          // widget.que2a.add(6);
                          // else
                          // widget.que2a.remove(6);
                        });
                      },
                    ),
                  ],
                                 ),
                               ),
                             ],
                           ),
                                 ]
                           ),
                         )
                 
                      
                 
                 
                 
                 
                 //                   SizedBox(
                 //                     width: MediaQuery.of(context).size.width * 0.89,
                 //                     child: isloading?CircularProgressIndicator(): ElevatedButton(
                 //                         style: ElevatedButton.styleFrom(
                 //                             shape: BeveledRectangleBorder(
                 //                                 borderRadius: BorderRadius.all(Radius.circular(3))
                 //                             ),
                 //                             backgroundColor: Coloors.fontcolor
                 //                         ),
                 //                         onPressed: (){
                        
                 
                       
                 // //                             if(imageFile2!=null){
                 // //   var Email=email.text.trim().toString();
                 // //   var State =state.text.trim().toString();
                 // //     var City=city.text.trim().toString();
                 // //   var Pincode=pincode.text.trim().toString();
                   
                          
                 // //                         // setState(() {
                 // //                         //   isloading=true;
                 // //                         // });
                 // //                         postProfileData(Email,State,City,Pincode,context);
                 // //                        // imageFile2=null;
                 // //   //                       Future.delayed(Duration(seconds: 3),(){
                 // //   //                         setState(() {
                 // //   // isloading=false;
                 // //   //                         });
                 // //   //                       });
                 
                 // // }
                 // // else{
                 // //   var val={
                 // //     'email':email.text.trim().toString(),
                 // //     'state':state.text.trim().toString(),
                 // //     'pincode':pincode.text.trim().toString(),
                 // //     'city':city.text.trim().toString()
                     
                 // //   };
                     
                 // //                         ApiDomain().postProfileData(val, context);
                       
                 
                 // //                        }                          // showDialog(context: context, builder:(context){
                 //                           //   return AlertDialog(
                 //                           //     content: FutureBuilder(
                 //                           //       future: getState("state", "country", 101), builder:(context,snapshot){
                 //                           //       if(!snapshot.hasData){
                 //                           //         return CircularProgressIndicator();
                               
                 //                           //       }else if(snapshot.hasData)
                 //                           //       {
                 //                           //         return ListView.builder(
                 //                           //           itemCount: snapshot.data.length,
                 //                           //           itemBuilder: (context,index){
                 //                           //            return ListTile(
                 //                           //                title: Text(snapshot.data[index]["name"].toString()),
                 //                           //            );
                 //                           //         });
                 //                           //       }
                 //                           //       return CircularProgressIndicator();
                 //                           //     }),
                 //                           //   );
                 //                           // });
                        
                 //                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
                 //                         },
                 //                          child: Text('Update',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.white),)),
                 //                   ),
                                 ],
                               ),
              

                               Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
      children: [
                   Padding(
                     padding: const EdgeInsets.all(12.0),
                     child: Text(
                      'Complaint:',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,fontSize: 17),
                      textAlign: TextAlign.start,
                                    ),
                   ),
                   
         
             
                Container(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text(
                        "1. Giddiness",
                        textAlign: TextAlign.start,style: TextStyle(
                          fontSize: 15
                        ),),
                    value: pastquestionc1,
                    onChanged: (value) {
                     setState(() {
                        // if(isEdit) {pastquestionc1 = value!;
                        // if(pastquestionc1==true)
                        // complain.add(1);
                        // else
                        // complain.remove(1);
                        // }
                     });
                      // setState(() {
                       
                      // });
                    },
                  ),
                ),
                  Container(
                    height: 35,
                    child: CheckboxListTile(
                                    title: const Text('2. Vertigo',
                    style: TextStyle(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start),
                                    value: pastquestionc2,
                                    onChanged: (value) {
                                   setState(() {
                    //                   if(isEdit){
                    // pastquestionc2 = value!;
                    //  if(pastquestionc2==true)
                    //     complain.add(2);
                    //     else
                    //     complain.remove(2);}
                                   });
                                     
                                    },
                                  ),
                  ),
                Container(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('3. Nausea',
                    style: TextStyle(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start),
                    value: pastquestionc3,
                    onChanged: (value) {
                    
                setState(() {
                  // if(isEdit){
                  //    pastquestionc3 = value!;
                  //    if(pastquestionc3==true)
                  //       complain.add(3);
                  //       else
                  //       complain.remove(3);
                  // }
                });
                
                 
                    },
                  ),
                ),
                Container(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('4. Seizure Disorder(Epilespy)',
                   style: TextStyle(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start),
                    value: pastquestionc4,
                    onChanged: (value) {
                 setState(() {
                  //  if(isEdit){
                  //   pastquestionc4 = value!;
                  //    if(pastquestionc4==true)
                  //       complain.add(4);
                  //       else
                  //       complain.remove(4);
                  //  }
                 });
               
                    },
                  ),
                ),
                Container(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text(
                    '5. Acrophobia',
                   style: TextStyle(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start),
                    value: pastquestionc5,
                    onChanged: (value) {
                  setState(() {
                    //  if(isEdit){ 
                    // pastquestionc5 = value!;
                    //  if(pastquestionc5==true)
                    //     complain.add(5);
                    //     else
                    //     complain.remove(5);
                    //  }
                  
                  });
                    },
                  ),
                ),
                Container(
                  height: 35,
                  child: CheckboxListTile(
                    title: const Text('6. Assthama/COPD',
                   style: TextStyle(
                      fontSize: 15
                    ),
                    textAlign: TextAlign.start),
                    value: pastquestionc6,
                    onChanged: (value) {
               setState(() {
                  //  if(isEdit){
                  //   pastquestionc6 = value!;
                  //    if(pastquestionc6==true)
                  //       complain.add(6);
                  //       else
                  //       complain.remove(6);
                  //  }
               });
               
                    },
                  ),
                ),
              
      ],
    ),
    SizedBox(height: 40,),
    // isEdit==false? ElevatedButton(onPressed: (){
    //   isEdit=true;
    //   setState(() {
        
    //   });
      
    // }, 
    // style: ElevatedButton.styleFrom(
    //   backgroundColor: Coloors.fontcolor,
    // ),
    // child: Text("Edit",style: GoogleFonts.poppins(color: Colors.white),)):ElevatedButton(onPressed: (){
    //   print(complain);
    //   var value={
    //     "test_type_id":1,
    //     "id":email.text,
    //     'complaints':complain
    //   };
    //   updatedetails(value);
    //   isEdit=false;
      
      
    // },
    //  style: ElevatedButton.styleFrom(
    //   backgroundColor: Coloors.fontcolor,
    // ),
    //  child: Text("Submit",style: GoogleFonts.poppins(color: Colors.white)))
 
            ])
          
             )
    );


  }

  



}




