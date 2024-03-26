import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiDomain{
 String url="https://qbacp.com/mediclear/api/";
  Future getProfileData()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.get(Uri.parse("${ApiDomain().url}customer-profile"),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data['Userdata']);
     return data['Userdata'];
    }

  }
   Future getConsumerProfileData(var id,context)async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}consumer-data"),
    body: jsonEncode(id),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      print(data['data']);
     return data['data'];
    }
    else
    {
      showDialog(context: context, builder:(context){
          return Container(
            child: Center(
              child: Column(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 15,),
                  Text("Something went wrong!"),
                
                ],
              ),
            ),
          );
            
      });
        Future.delayed(Duration(seconds: 3),(){
          Navigator.pop(context);
        });
    }

  }
   Future postProfileData(Object value,context)async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}customer-profile"),
    body:jsonEncode(value),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
      
      var rest= jsonDecode(response.body);
      print(response.body);
      if(rest['status'] == "sucess"){
        
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${rest['message']}')));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestScreen()));
     // Navigator.pop(context);
       // Get.offAll(Home_view());
      }
    }
    else {
       // alertBoxdialogBox(context, 'Alert', '${rest['message']}');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration not sucessfull,please check your details')));
      }
  }


  Future blood_pressure_test(Object value,context,String id)async{
     final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}bpdata"),
    body:jsonEncode(value),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200){
      var data=jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']}")));
      
                 SystemChrome.setPreferredOrientations([
                  DeviceOrientation.portraitUp,
                  DeviceOrientation.portraitDown,
                ]);
                print( data['consumer_test_report']['test_type_id']);
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>VertigoTest(id: id,val2: data['consumer_test_report']['test_type_id'],)));

                

      //return data;
    }
    else{
      var data=jsonDecode(response.body);
       showDialog(context: context, builder:(context){
        return AlertDialog(
          content: Container(child:Center(child: Text("Something went wrong!"),)),
        );
       });
    }
  }


   Future getNotificationCount()async {
      final SharedPreferences pref= await SharedPreferences.getInstance();
    var token=pref.getString("token");
    final response=await http.post(Uri.parse("${ApiDomain().url}newnotification"),
    headers: ({
     'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token' 
    }),
    );
    if(response.statusCode==200)
    {
      var data=jsonDecode(response.body);
      return data['notifications'];
    }
    
  }

  
}