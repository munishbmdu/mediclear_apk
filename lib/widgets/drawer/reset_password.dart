import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mediclear_labs/constants/colors.dart';

class reset_password extends StatefulWidget {
  const reset_password({super.key});

  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {

  TextEditingController mobile = TextEditingController();
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController cpass = TextEditingController();
 

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var Get=MediaQuery.of(context).size;
    return SafeArea(
      child:Scaffold(
          //backgroundColor: Colors.transparent,
          appBar: AppBar(
           backgroundColor: Coloors.fontcolor,
            
            centerTitle: true,
            title: Text('Change Password'),),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Container(
                  child:
                Text(
                      'Change Password',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Coloors.fontcolor),
                    ),
                  
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: Get.height * 0.055,
                  child: customtextformfield(
                    controller: mobile,
                    label: '*',
                    hinttext: 'Mobile Number',
                    suffixIcon: Icon(Icons.call),
                    newIcon: Icon(Icons.call,color: Coloors.fontcolor),
                    key_type: TextInputType.phone,
                    maxLength: 10,
                    bottomLineColor: Color(0xffb8b8b8)
                  ),
                ),
                Container(
                  height: Get.height * 0.055,
                  child: customtextformfield(
                    controller: oldpass,
                    obsure: true,
                    label: '*',
                    bottomLineColor: Color(0xffb8b8b8),
                    hinttext: 'Old Password',
                    suffixIcon: Icon(Icons.lock_open),
                  //  showPassword: showPassword.value,
                    callback: () {
                    
                      setState(() {});
                    },

                    newIcon: Icon(
                      Icons.lock,color:Coloors.fontcolor
                    ),
                    key_type: TextInputType.visiblePassword,
                  ),
                ),
                Container(
                  height: Get.height * 0.055,
                  child: customtextformfield(
                    controller: newpass,
                    label: '*',
                    hinttext: 'New Password',
                    suffixIcon: Icon(Icons.lock),
                    newIcon: Icon(Icons.lock,color: Coloors.fontcolor),

                    //  showPassword: showPassword1.value,
                      callback: () {
                     
                        setState(() {});
                      },
                    key_type: TextInputType.visiblePassword,
                      bottomLineColor: Color(0xffb8b8b8)
                  ),
                ),
                Container(
                  height: Get.height * 0.055,
                  child: customtextformfield(
                    controller: cpass,
                    label: '*',
                    hinttext: 'Confirm Password',
                    suffixIcon: Icon(Icons.lock_open),
                      //showPassword: showPassword2.value,
                      callback: () {
                      
                        setState(() {});
                      },
                    newIcon: Icon(
                      Icons.lock,color: Coloors.fontcolor
                    ),
                    key_type: TextInputType.visiblePassword,
                      bottomLineColor: Color(0xffb8b8b8)
                  ),
                ),
                Container(
                  height: Get.height * 0.055,
                  child: blockButton(
                      width: Get.width * 0.35,
                      callback: (){
                        var MobileNo = mobile.text.trim();
                        var OldPass = oldpass.text.trim();
                        var NewPass = newpass.text.trim();
                        var Cpass = cpass.text.trim();
                        if(MobileNo == '' && OldPass == ''&& NewPass == ''&& Cpass == ''){
                          AlertDialog(content: Text('Alert, Please Fill Fields'));
                        }else if(NewPass !=  Cpass){
                          AlertDialog(content: Text('Alert, New Password Conform Password does not Match'));
                        }else{
                          var value = {
                            "mobile_no":MobileNo,
                            "password":OldPass,
                            "new_password":NewPass,
                            "confirm_password":Cpass
                          };
                          setState(() {
                            isLoading =true;
                          });
                          Future.delayed(Duration(seconds: 3),(){
                            setState(() {
                              isLoading = false;
                            });
                          });
                       //   ResetPassword(value);
                        }
                      },
                      widget: isLoading == false?InkWell(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              height: 1.2),
                        ),
                      ):SizedBox(
                        height: 10,
                          width: 10,
                          child: CircularProgressIndicator(color: Colors.white,)),
                      verticalPadding: 3),
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                // Container(
                //   height: Get.height * 0.4,
                //   child: Image(
                //     image: AssetImage(
                //       'assets/imgpsh_fullsize_anim (2) 1.png',
                //     ),
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ],
            )
          ),
        ),
      
    );
  }

}

Widget customtextformfield({
  bool ? obsure,
  bool ? readOnly,
  Color? hintTextColor,
  Color? bottomLineColor,
  String? hinttext,
  String? label,
  TextEditingController? controller,
  Widget? suffixIcon,
  bool showPassword = false,
  TextInputType? key_type,
  Widget? newIcon,
  Function()? callback,
  var validator,
  int? maxLength,
  double? horizontalcontentPadding,
  double? verticalContentPadding,
  Gradient? gradient,
  InputBorder? border,
  bool ? enabled,
}) {
  return Padding(
    padding: const EdgeInsets.all(1.0),
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: TextFormField(
        onTap: callback,
        readOnly: readOnly==null?false:readOnly,
        enabled: enabled,
        cursorHeight: 20,
        cursorColor: hintTextColor == null ? Coloors.fontcolor : hintTextColor,
        validator: validator,
        keyboardType: key_type,
        controller: controller,
        obscureText: showPassword,
        maxLength: maxLength,

        style: TextStyle(
          decorationStyle: TextDecorationStyle.dotted,
          decoration: TextDecoration.none,
          color: hintTextColor == null ? Coloors.fontcolor : hintTextColor,
          fontSize: 15,
        ),
        decoration: InputDecoration(
          label: Row(
            children: [
              Text(hinttext.toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
              Text(label==null?'':label.toString(),style: TextStyle(color: Coloors.fontcolor),)
            ],
          ),
          counter: Offstage(),
          alignLabelWithHint: false,
          contentPadding:EdgeInsets.zero,
          // EdgeInsets.symmetric(
          //   horizontal:
          //       horizontalcontentPadding == null ? 0 : horizontalcontentPadding,
          //   vertical: verticalContentPadding == null ? 0 : verticalContentPadding,
          // ),

          suffixIcon:
          InkWell(
            onTap: callback,
            child: gradient == null
                ? Container(
                    child: showPassword == false ? newIcon : newIcon,
                    
                  )
                : Container(
                    child: newIcon,
                  ),
          ),
          // hintText: hinttext,
          // hintStyle: TextStyle(
          //   color: hintTextColor == null ? Colors.black :  hintTextColor,
          //   fontSize: 15,
          // ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: bottomLineColor == null
                  ? Coloors.fontcolor
                  : bottomLineColor,
            ),
          ),
          focusedBorder:border==null? UnderlineInputBorder(
            borderSide: BorderSide(
              color: hintTextColor == null ? Color(0xffDD2B1C) : hintTextColor,
            ),
          ):border,
          border: InputBorder.none,
        ),
      ),
    ),
  );
}

Widget blockButton({
  Widget? widget,
  double? width,
  double? horizontalPadding,
  double? verticalPadding,
  double? borderradius,
  Function()? callback,
}) {
  return InkWell(
    onTap: callback,
    child: Container(

      margin: EdgeInsets.all(4),
      width: width == null ? Get.width * 0.26 : width,
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding == null ? 14 : horizontalPadding,
          vertical: verticalPadding == null ? 10 : verticalPadding),
      decoration: BoxDecoration(
       // gradient: Coloors.fontcolor,
        borderRadius: BorderRadius.circular(borderradius==null?30:borderradius),
        boxShadow: [
          BoxShadow(
            color:  Coloors.fontcolor,
             blurRadius: 3,
            spreadRadius: 0
          )
        ],
        // border: Border.all(
        //   color: appcolor.purpleColor,
        // ),
      ),
      child: Center(child: widget),
    ),
  );
}
