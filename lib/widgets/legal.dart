import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:mediclear_labs/screens/application_form/widgets/notification.dart';
import 'package:mediclear_labs/widgets/gradient._text.dart';



class legel_view extends StatefulWidget {
  const legel_view({super.key});

  @override
  State<legel_view> createState() => _legel_viewState();
}

class _legel_viewState extends State<legel_view> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       // backgroundColor: Colors.transparent,
        body: Column(
          children: [
           // customAppBar('Legel',context),
            // Container(
            //   height: 1,
            //   width: Get.width ,
            //   color: appcolor.borderColor,
            // ),
            InkWell(
              onTap: () {
               Get.to(termsandCondition());
              },
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 5,
                ),
                height: Get.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 10,
                ),
              ),
            ),
            // Container(
            //   height: 1,
            //   width: Get.width,
            //   color: Colors.black,
            // ),
            InkWell(
              onTap: () {
                Get.to(privacy_policy());
              },
              child: Container(
                margin: EdgeInsets.only(
                  bottom: 5,
                ),
                height: Get.height * 0.04,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 18,
                        height: 1.5,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                  ],
                ).paddingSymmetric(
                  horizontal: 10,
                ),
              ),
            ),
            // Container(
            //   height: 1,
            //   width: Get.width,
            //   color: Colors.black,
            // ),
          ],
        ),
        floatingActionButton:floatingActionButon(),
      ),
    );
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


class privacy_policy extends StatefulWidget {
  const privacy_policy({super.key});
  @override
  State<privacy_policy> createState() => _privacy_policy();
}

class _privacy_policy extends State<privacy_policy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: customAppBar('Privacy Policy',context),),
       // backgroundColor: Colors.transparent,
        body: Column(
          children: [
      
            // Container(
            //   height: 1,
            //   width: Get.width,
            //   color: appcolor.borderColor,
            // ),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1. Payment : Any amount equal to above Rs. 1',style: TextStyle(fontSize: 14),),
      
                Text('2. Bank Transfer : Any Amount equal or above \n    Rs.300',style: TextStyle(fontSize: 14),)
              ],
            ),
            SizedBox(height: 20,),
            Center(child: Text('Disclaimer', style: TextStyle(fontSize: 16,color: appcolor.redColor),)),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(' 1. Please note as, per CBDTwhen an unknown \n       printer took a galley of type and scrambled \n       it to make a type specimen book. It has \n       survived not only five centuries,',style: TextStyle(fontSize: 14),),
      
                Text(' 2. Please note as, per CBDTwhen an unknown \n       printer took a galley of type and scrambled \n       it to make a type specimen book. It has \n       survived not only five centuries,',style: TextStyle(fontSize: 14),),
              ],
            ),
            SizedBox(height: 20,),
            Center(child: Text('End User License Agreement', style: TextStyle(fontSize: 16,color: appcolor.redColor),)),
            SizedBox(height: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('  To View the update terms & conditions please \n   clieck on the link',style: TextStyle(fontSize: 14),),
      
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 25,),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text('Click Here')),
              ],
            )
          ],
        ),
        floatingActionButton:floatingActionButon(),
      ),
    );
  }
}


Container customAppBar(String title,context) {
  return Container(
   
    color: Colors.transparent,
    child: Row(
      // crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GradientText(
          gradient: appcolor.gradient,
          widget: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,color: appcolor.redColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        GradientText(
          widget: Text(
            title,
            style: TextStyle(
              height: 2,
              fontSize: 22,color: appcolor.redColor
            ),
          ),
          gradient: appcolor.gradient,
        ),
      ],
      
    ),
  );
}
class appcolor{
  static Color redColor=Coloors.fontcolor;
   static final LinearGradient gradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,

    // stops: [0.9,0.1],
    colors: [
      Color(0xffc32b30),
      Color(0xffc32b30),
    ],
  );
  static final Color borderColor = Colors.black;
    static final Color newRedColor = Color(0xffDD2B1C);
}


class termsandCondition extends StatefulWidget {
  const termsandCondition({super.key});

  @override
  State<termsandCondition> createState() => _termsandConditionState();
}

class _termsandConditionState extends State<termsandCondition> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
         appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: customAppBar('Terms & Conditions',context),),
       // backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(
              height: 50,
            ),
            // Container(
            //   height: 1,
            //   width: Get.width,
            //   color: appcolor.borderColor,
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1. PayTm : Any Amount equal or above Rs. 1',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '2. Bank Transfer : Any Amount equal or above\n   Rs.300 ',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'Disclaimer',
                  style: TextStyle(
                    color: appcolor.newRedColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '1. Please note as, per CBDTwhen an unknown\n   printer took a galley of type and scrambled \n   it to make a type specimen book. It has \n   survived not only five centuries, ',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '2. Please note as, per CBDTwhen an unknown\n   printer took a galley of type and scrambled \n   it to make a type specimen book. It has \n   survived not only five centuries, ',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  'End User Liscence Agreement',
                  style: TextStyle(
                    color: appcolor.newRedColor,
                    fontSize: 18
                  ),
                ),
                Text(
                  'To View the update terms & conditions please click on the link',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Click Here',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1,
                    ),
                  ),
                )
              ],
            ).paddingSymmetric(
              horizontal: 10,
            ),
          ],
        ),
     //   floatingActionButton:floatingActionButon(),
      ),
    );
  }
}
