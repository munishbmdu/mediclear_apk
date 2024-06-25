import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/application_form/screens/form.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/vertigo_test.dart';
import 'package:mediclear_labs/screens/register_customers_details/register_consumer_profile.dart';
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreenForRegisterCustomers extends StatefulWidget {
  DetailsScreenForRegisterCustomers({super.key, required this.batch_no,  this.company_id=""});

  String batch_no;
  String company_id;


  @override
  State<DetailsScreenForRegisterCustomers> createState() => _DetailsScreenForRegisterCustomersState();
}

class _DetailsScreenForRegisterCustomersState extends State<DetailsScreenForRegisterCustomers> {
   bool isLoading=true;
   
  @override
  Widget build(BuildContext context) {
    
    print(widget.batch_no);
    return Scaffold(
      appBar: AppBar(
        title: Text("Consumer",style: GoogleFonts.poppins(),),
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TestScreen()));
        }, icon: Icon(Icons.arrow_back)),
        actions: [
          TextButton(onPressed: (){
           // addMoreConsumers(widget.batch_no, widget.company_id);
           
            showDialog(context: context, builder:(context){
              return AlertDialog(
                content: FutureBuilder(
                  future: addMoreConsumers(widget.batch_no, widget.company_id),
                  builder: (context,snapshot) {
                    if(snapshot.hasError||!snapshot.hasData)
                    return Container(
                      height: 200,
                      child: Center(child: CircularProgressIndicator()));
                    return Container(
                      height: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total Allocated Test: ",style: TextStyle(fontSize: 17),),
                              Text("${snapshot.data['Total_you_have_test']}",style: TextStyle(fontSize: 20,color: Coloors.fontcolor),)
                            ],
                          ),
                          SizedBox(height: 10,),
                            Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Remaining Test: ",style: TextStyle(fontSize: 17),),
                              Text("${snapshot.data['remaing_consumer_for_test']}",style: TextStyle(fontSize: 20,color: Coloors.fontcolor),)
                            ],
                          ),
                           SizedBox(height: 10,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Registered consumers: ",style: TextStyle(fontSize: 17),),
                              Text("${snapshot.data['total_addconsumer']}",style: TextStyle(fontSize: 20,color: Coloors.fontcolor),)
                            ],
                          ),
                          SizedBox(height: 20,),
                          ElevatedButton(onPressed: (){
                            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>MyForm()));
                          }, child:Text("Add"))
                        ],
                      ),
                    );
                  }
                ),
              );
            });
          }, child:Row(
            children: [
              Icon(Icons.add),
              Text("Add more")
            ],
          ))
        ],
      ),
      body: FutureBuilder(
        future: getDetails(widget.batch_no, widget.company_id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            
            return Center(
               child: Text("Fetching data...You don't have data",textAlign: TextAlign.center,style: GoogleFonts.poppins(fontSize: 20),),   
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(16.0),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[200],
                            child: ClipOval(
                              child: Image.network(
                                snapshot.data[index]['consumer_profile_image_name'].toString(),
                                fit: BoxFit.cover,
                                height: 120,
                                width: 100,
                              ),
                            ),
                          ),
                          title: Text(
                            snapshot.data[index]['consumer_name'].toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          subtitle: Text(
                            snapshot.data[index]['id'].toString(),
                            style: TextStyle(fontSize: 14.0, color: Colors.red),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            
                              ElevatedButton(
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>VertigoTest(id:snapshot.data[index]['id'].toString(),batch_no: widget.batch_no,company_id: widget.company_id,)));
                                },
                                child: Text("Test"),
                              ),
                            if (snapshot.data[index]['consumer_status'] == '0')
                            ElevatedButton(
                              
                              onPressed: () {
                                var value={
                                  'id':snapshot.data[index]['id'].toString()
                                };
                                showDialog(context: context, builder:(context){
                                  return AlertDialog(
                                        content: Container(
                                           height: 200,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Are you sure You want to delete this consumer?",textAlign: TextAlign.center,softWrap: true,maxLines: 2,),
                                              SizedBox(height: 20,),
                                              Row(
                                               
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                               ElevatedButton(onPressed: (){
                                                  deleteConsumerProfile(value);
                                                  
                                              
                                            
                                             
                                                }, 
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Coloors.fontcolor
                                                ),
                                                child:Text("Yes",style: TextStyle(color: Colors.white),)),
                                                 ElevatedButton(onPressed: (){
                                                  Navigator.pop(context);
                                                 }, 
                                                 style: ElevatedButton.styleFrom(
                                                  backgroundColor: Coloors.fontcolor
                                                ),
                                                 child:Text("No",style: TextStyle(color: Colors.white),))
                                              ],)
                                            ],
                                          ),
                                        ),
                                      );
                                });
                              },
                              child: Text("Delete", style: TextStyle(color: Coloors.fontcolor)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                var value={
                                  'id':snapshot.data[index]['id'].toString()
                                };
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(consumer_id: value,)));
                              },
                              child: Text("Details", style: TextStyle(color: Coloors.fontcolor)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future getDetails(String batch, company_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var data = {
      "batch_no": batch,
      "company_id": company_id,
    };

    final response = await http.post(
      Uri.parse("https://bmdublog.com/mediclear/api/all-consumer-data"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data['data'];
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']} or company id")));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
}


    Future deleteConsumerProfile(Object value)async{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

   
    final response = await http.post(
      Uri.parse("https://bmdublog.com/mediclear/api/consumer-medical-data-delete"),
      body: jsonEncode(value),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      
    );
     if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']}")));
      Navigator.pop(context);
      setState(() {
      
      });
     
      return data;
    } else {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']}")));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }

    }



    Future addMoreConsumers(String batch, company_id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var data = {
      "batch_no": batch,
      "company_id": company_id,
    };

    final response = await http.post(
      Uri.parse("https://bmdublog.com/mediclear/api/forbiddenlity-add-consumer"),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else if (response.statusCode == 403) {
      var data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${data['message']}")));
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pop(context);
      });
    }
}
}
