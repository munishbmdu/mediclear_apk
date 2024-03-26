import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/application_form/screens/form.dart';
import 'package:shared_preferences/shared_preferences.dart';


class notifcation extends StatefulWidget {
  const notifcation({super.key});

  @override
  State<notifcation> createState() => _notifcation();
}

class _notifcation extends State<notifcation> {

 


  @override
  Widget build(BuildContext context) {
  // String text = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s,';
  //String Date = '14 Oct at 5:40';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed:() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyForm()));

          }, icon:Icon(Icons.navigate_before,color: Coloors.fontcolor,)),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
      
          title: Text('Notification',style: GoogleFonts.poppins(color: Coloors.fontcolor,fontWeight: FontWeight.bold),),
          centerTitle: true,
          ),
          
      
      //  backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: FutureBuilder(
          future: getNotification(),
          builder: (context,snapshot) {
            if(!snapshot.hasData||snapshot.hasError)
            return Center(child: CircularProgressIndicator());
           
            return ListView.builder(

              itemCount: snapshot.data.length,
              itemBuilder: (context,int index) {
                 String text=(snapshot.data[index]['data']['massage']);
            String date=snapshot.data[index]['created_at'];
            String Date=date.substring(0,10)+" at "+ date.substring(11,16);
             bool isviewmore=false;
                return Padding(
                 
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                  
                    child: Card(
                  //    color: Colors.grey[100],
                      elevation: 5,
                      child: (Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(snapshot.data[index]['data']['subject'],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.black),),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                            child: Text(text.length<100?text:text.substring(0,110),style: TextStyle(fontSize: 12,),softWrap: true,maxLines: 3,textAlign: TextAlign.start,),
                          ),
                         if(text.length>110) Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 8),
                            child: Row(children: [
                              Text("...."),
                              InkWell(
                                onTap: (){
                                 showDialog(context: context, builder:(context){
                                  return AlertDialog(
                                    content: Container(
                                      height: 300,
                                      child: Column(
                                        
                                        children: [
                                          Center(child: Text("Message")),
                                          SizedBox(height: 20,),
                                          Text(text,style: TextStyle(fontSize: 12,),softWrap: true,maxLines: 10,textAlign: TextAlign.start,),
                                         SizedBox(height: 20,),
                                         ElevatedButton(onPressed: (){
                                          Navigator.pop(context);
                                         }, child: Text("Ok"))
                                      
                                        ],
                                      ),
                                    ),
                                  );
                                 });
                                },
                                child: Text("View More",style: TextStyle(color: Coloors.fontcolor),),
                              )
                            ],),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                              Text(Date,style: TextStyle(fontSize: 12,color: Coloors.fontcolor),),
                            ],),
                          )
                        
                        ],
                      )),
                    //   child: ListTile(
                    //     leading: Text(snapshot.data[index]['data']['subject'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),                      
                    //     title: Text(text,style: TextStyle(fontSize: 12,),softWrap: true,maxLines: 3,textAlign: TextAlign.start,),
                    //  subtitle: Row(
                    //    mainAxisAlignment: MainAxisAlignment.start,
                    //    children: [
                    //      Text(Date,style: TextStyle(fontSize: 12,color: Coloors.fontcolor),),
                    //    ],
                    //  ),
                    
                    //   ),
                    ),
                  )
                         );
              }
            );
          }
        ),
        //floatingActionButton:floatingActionButon(),
      ),
    );
  }
}
Future getNotification()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
 final response=await http.post(Uri.parse("${ApiDomain().url}notification"),
 headers: ({
   'Authorization': 'Bearer $token' 
 })
 );
 if(response.statusCode==200){
  var data=jsonDecode(response.body);
  print(data['data']);
  return data['data'];
 }

}

Widget floatingActionButon(){
  return    SizedBox(
    height: 40,
    width: 40,
    child: FloatingActionButton(

    backgroundColor: Colors.green,
    onPressed: () {  },child: FaIcon(FontAwesomeIcons.whatsapp,)

    ),
  );
}
