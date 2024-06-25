import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/api_domain.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:http/http.dart' as http;
import 'package:mediclear_labs/screens/test_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User_Profile extends StatefulWidget {
  const User_Profile({super.key});

  @override
  State<User_Profile> createState() => _User_Profile();
}

class _User_Profile extends State<User_Profile> {
  File? imageFile2;
  var img;
  TextEditingController state = TextEditingController();
  int id = 1;
  TextEditingController city = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pincode = TextEditingController();
  bool isloading = false;

  Future getProfileData() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var token = pref.getString("token");
    final response = await http.get(
      Uri.parse("${ApiDomain().url}customer-profile"),
      headers: ({
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      }),
    );
    if (response.statusCode == 200) {
      var dataa = jsonDecode(response.body);
      var data = dataa['Userdata'];
      email.text = data['email'] == null ? "" : data['email'].toString();
      name.text = data['name'] == null ? "" : data['name'].toString();
      phone.text =
          data['mobile_no'] == null ? "" : data['mobile_no'].toString();
      state.text = data['state'] == null ? "" : data['state'].toString();
      city.text = data['city'] == null ? "" : data['city'].toString();
      pincode.text = data['pincode'] == null ? "" : data['pincode'].toString();
      // img=data['customer_profile_image'];

      print(data['Userdata']);
      // return data['Userdata'];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getProfileData();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print("rebuild");
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Profile ',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Coloors.fontcolor),
          ),
        ),
        resizeToAvoidBottomInset: true,
        // endDrawer: Drawers(context),
        body:
            //  print(state.text.toString());

            SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Stack(children: [
                  FutureBuilder(
                      future: ApiDomain().getProfileData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError)
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        if (!snapshot.hasData)
                          return Center(
                            child: CircularProgressIndicator(),
                          );

                        img = snapshot.data['customer_profile_image'];
                        return CircleAvatar(
                            radius: 60,
                            // backgroundImage: img!= "customer profile not updated"? NetworkImage(img,):null ,
                            child: ClipOval(
                                child: imageFile2 == null
                                    ? img == "customer profile not updated"
                                        ? Icon(Icons.person)
                                        : Image.network(
                                            img,
                                            fit: BoxFit.cover,
                                            width: 120,
                                            height: 130,
                                          )
                                    : Image.file(
                                        File(
                                          imageFile2!.path,
                                        ),
                                        fit: BoxFit.cover,
                                        height: 130,
                                        width: 120,
                                      ))
                            // // //   child:(snapshot.data['customer_profile_image']!="customer profile not updated")?Image.network(snapshot.data['customer_profile_image'],):Icon(Icons.person),
                            //   child: snapshot.data['customer_profile_image'].toString()!="https://bmdublog.com/mediclear/" ? Image.network(snapshot.data['customer_profile_image']!.toString()):Icon(Icons.person),
                            // backgroundImage: SelectedImage ==null ? Image(image: Image.file(SelectedImage!),):Icon(Icons.person) ,
                            );
                      }),
                  Positioned(
                      top: 80,
                      left: 80,
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Coloors.fontcolor,
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              showImagePicker(context);
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ))
                ]),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                      controller: name,
                      keyboardType: TextInputType.visiblePassword,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Color(0xfff1f3ff),
                        suffixIcon: Icon(Icons.person),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1f42ba),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                      controller: phone,
                      keyboardType: TextInputType.visiblePassword,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: Color(0xfff1f3ff),
                        suffixIcon: Icon(Icons.phone_android),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1f42ba),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                    controller: email,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Color(0xfff1f3ff),
                      suffixIcon: Icon(Icons.email),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          ),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff1f42ba),
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                      // key: Key(email.text.toString()),
                      controller: state,
                      // readOnly: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'Address',
                        fillColor: Color(0xfff1f3ff),
                        suffixIcon: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: FutureBuilder(
                                          future:
                                              getState("state", "country", 101),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                    child:
                                                        Text("Wait a moment")),
                                              );
                                            } else if (snapshot.hasData) {
                                              return ListView.builder(
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        state.text = snapshot
                                                            .data[index]["name"]
                                                            .toString();
                                                        id = snapshot
                                                            .data[index]['id'];
                                                        print(id);
                                                        Navigator.pop(context);
                                                      },
                                                      title: Text(snapshot
                                                          .data[index]["name"]
                                                          .toString()),
                                                    );
                                                  });
                                            }
                                            return CircularProgressIndicator();
                                          }),
                                    );
                                  });
                            },
                            icon: Icon(Icons.keyboard_arrow_down)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(255, 209, 152, 152))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1f42ba),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                      controller: pincode,
                      keyboardType: TextInputType.phone,
                      // readOnly: true,
                      decoration: InputDecoration(
                        hintText: "Pincode",
                        fillColor: Color(0xfff1f3ff),
                        suffixIcon: IconButton(
                            onPressed: () {}, icon: Icon(Icons.location_pin)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1f42ba),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: size.height * 0.06,
                  child: TextField(
                      controller: city,
                      //readOnly: true,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: 'City',
                        fillColor: Color(0xfff1f3ff),
                        suffixIcon: IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: FutureBuilder(
                                          future: getState("city", "state", id),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Container(
                                                height: 50,
                                                width: 50,
                                                child: Center(
                                                    child: Text(
                                                        "Wait a moment or enter valid state")),
                                              );
                                            } else if (snapshot.hasData) {
                                              return ListView.builder(
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return ListTile(
                                                      onTap: () {
                                                        city.text = snapshot
                                                            .data[index]["name"]
                                                            .toString();
                                                        Navigator.pop(context);
                                                      },
                                                      title: Text(snapshot
                                                          .data[index]["name"]
                                                          .toString()),
                                                    );
                                                  });
                                            }
                                            return CircularProgressIndicator();
                                          }),
                                    );
                                  });
                            },
                            icon: Icon(Icons.keyboard_arrow_down)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(11),
                            ),
                            borderSide: BorderSide(color: Colors.grey)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff1f42ba),
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(11))),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.89,
                child: isloading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: BeveledRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(3))),
                            backgroundColor: Coloors.fontcolor),
                        onPressed: () {
                          if (imageFile2 != null) {
                            var Email = email.text.trim().toString();
                            var State = state.text.trim().toString();
                            var City = city.text.trim().toString();
                            var Pincode = pincode.text.trim().toString();

                            // setState(() {
                            //   isloading=true;
                            // });
                            postProfileData(
                                Email, State, City, Pincode, context);
                            // imageFile2=null;
                            //                       Future.delayed(Duration(seconds: 3),(){
                            //                         setState(() {
                            // isloading=false;
                            //                         });
                            //                       });
                          } else {
                            var val = {
                              'email': email.text.trim().toString(),
                              'state': state.text.trim().toString(),
                              'pincode': pincode.text.trim().toString(),
                              'city': city.text.trim().toString()
                            };

                            ApiDomain().postProfileData(val, context);
                          } // showDialog(context: context, builder:(context){
                          //   return AlertDialog(
                          //     content: FutureBuilder(
                          //       future: getState("state", "country", 101), builder:(context,snapshot){
                          //       if(!snapshot.hasData){
                          //         return CircularProgressIndicator();

                          //       }else if(snapshot.hasData)
                          //       {
                          //         return ListView.builder(
                          //           itemCount: snapshot.data.length,
                          //           itemBuilder: (context,index){
                          //            return ListTile(
                          //                title: Text(snapshot.data[index]["name"].toString()),
                          //            );
                          //         });
                          //       }
                          //       return CircularProgressIndicator();
                          //     }),
                          //   );
                          // });

                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MainPage()));
                        },
                        child: Text(
                          'Update',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        )),
              ),
            ],
          ),
        ));
  }

  final picker = ImagePicker();

  void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                      child: const Column(
                        children: [
                          Icon(
                            Icons.image,
                            size: 60.0,
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            "Gallery",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      ),
                      onTap: () {
                        pickImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    )),
                    Expanded(
                        child: InkWell(
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 60.0,
                            ),
                            SizedBox(height: 12.0),
                            Text(
                              "Camera",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        pickImage(ImageSource.camera);
                        // _imgFromCamera();
                        Navigator.pop(context);
                      },
                    ))
                  ],
                )),
          );
        });
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        imageFile2 = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  // _imgFromGallery() async {
  //   await picker
  //       .pickImage(source: ImageSource.gallery, imageQuality: 50)
  //       .then((value) {
  //     if (value != null) {
  //       _cropImage(File(value.path));
  //     }
  //   });
  // }

  // _imgFromCamera() async {
  //   await picker
  //       .pickImage(source: ImageSource.camera, imageQuality: 50)
  //       .then((value) {
  //     if (value != null) {
  //       _cropImage(File(value.path));
  //     }
  //   });
  // }

  // _cropImage(File imgFile) async {
  //   final croppedFile = await ImageCropper().cropImage(
  //       sourcePath: imgFile.path,
  //       aspectRatioPresets: Platform.isAndroid
  //           ? [
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio16x9
  //             ]
  //           : [
  //               CropAspectRatioPreset.original,
  //               CropAspectRatioPreset.square,
  //               CropAspectRatioPreset.ratio3x2,
  //               CropAspectRatioPreset.ratio4x3,
  //               CropAspectRatioPreset.ratio5x3,
  //               CropAspectRatioPreset.ratio5x4,
  //               CropAspectRatioPreset.ratio7x5,
  //               CropAspectRatioPreset.ratio16x9
  //             ],
  //       uiSettings: [
  //         AndroidUiSettings(
  //             toolbarTitle: "Image Cropper",
  //             toolbarColor: Colors.deepOrange,
  //             toolbarWidgetColor: Colors.white,
  //             initAspectRatio: CropAspectRatioPreset.original,
  //             lockAspectRatio: false),
  //         IOSUiSettings(
  //           title: "Image Cropper",
  //         )
  //       ]);
  //   if (croppedFile != null) {
  //     imageCache.clear();
  //     setState(() {
  //       imageFile2 = File(croppedFile.path);
  //     });
  //     // reload();
  //   }
  // }

  Future<void> postProfileData(var email, state, city, pincode, context) async {
    print("calling");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var uri = Uri.parse(
        "${ApiDomain().url}customer-profile"); // Replace with your server's endpoint
    var request = http.MultipartRequest("POST", uri)
      ..files.add(await http.MultipartFile.fromPath(
        'customer_profile_image',
        imageFile2!.path,
      ));
    request.headers['Authorization'] = 'Bearer ' + '$token';
    request.fields['email'] = '$email';
    request.fields['state'] = '$state';
    request.fields['pincode'] = '$pincode';
    request.fields['city'] = '$city';
    //request.fields[''] = '$location';

    // request.fields['category']= '$choose';
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      final res = await http.Response.fromStream(response);
      var rest = jsonDecode(res.body);
      print(res.body);
      if (rest['status'] == "sucess") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${rest['message']}')));
        imageFile2 = null;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TestScreen()));

        // Navigator.pop(context);
        // Get.offAll(Home_view());
      }
    } else {
      // alertBoxdialogBox(context, 'Alert', '${rest['message']}');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('Registration not sucessfull,please check your details')));
    }
  }

  // Future imagePicker()async{
  //   final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

  //   // Cropped Image
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: returnedImage!.path

  //   );
  //   if(returnedImage == null)return;
  //   setState(() {
  //     SelectedImage = File(croppedFile!.path);
  //     Navigator.of(context).pop();
  //   });
  // }
  // Future imagePickerCamera()async{
  //   final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);
  //   CroppedFile? croppedFile = await ImageCropper().cropImage(
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9,
  //       ],
  //       sourcePath: returnedImage!.path
  //   );
  //   if(returnedImage == null)return;
  //   setState(() {
  //     SelectedImage = File(croppedFile!.path);
  //     Navigator.of(context).pop();

  //   });
  // }
  Future getState(String state_city, String country_state, int id) async {
    final response = await http.get(Uri.parse(
        "https://demo.codingbirdsonline.com/country-state-city-dropdown-api/index.php?endpoint=get${state_city}&${country_state}_id=${id}"));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data['data']);
      return data['data'];
    }
  }
  //  Future getProfileData()async{
  //   final SharedPreferences pref= await SharedPreferences.getInstance();
  //   var token=pref.getString("token");
  //   final response=await http.get(Uri.parse("${ApiDomain().url}customer-profile"),
  //   headers: ({
  //    'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': 'Bearer $token'
  //   }),
  //   );
  //   if(response.statusCode==200){
  //     var data=jsonDecode(response.body);
  //     print(data['Userdata']);
  //    return data['Userdata'];
  //   }

  // }
}
