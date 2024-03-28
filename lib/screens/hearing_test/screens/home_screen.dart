import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/screens/hearing_test/screens/test_screen1.dart';
import 'package:mediclear_labs/widgets/bottomsheet.dart';
import 'package:mediclear_labs/widgets/custom_text_button.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  InkWell(
                  //   onTap: () {
                  //      ShowBottomSheet.showBottomSheet1(context);
                  //   },

                  //    child: Container(
                  //      height: 60,
                  //       width: 60,
                  //       child: Image.asset("assets/logo1.jpg",fit: BoxFit.cover,)),
                  //  ),
                  //    InkWell(
                  // onTap: () {
                  //   ShowBottomSheet.showBottomSheet2(context);
                  // },
                  //    child: Container(
                  //     height: 70,
                  //     width: 70,
                  //     child: Image.asset("assets/logo2.png",fit: BoxFit.cover,)),
                  //  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 300,
                    width: 300,
                    child: Image.asset("assets/mediclear.jpg"))
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              height: 50,
              width: 250,
              child: CustomTextButton(
                text: "Click For Hearing",
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IndicatorWithScreens(
                          medical_id: '',
                        ),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


  //  void _showBottomSheet(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //      isScrollControlled: true,
  //     builder: (BuildContext context) {
  //       return Container(
  //         color: Colors.white,
  //        height: MediaQuery.of(context).size.height * 0.8,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //          mainAxisAlignment: MainAxisAlignment.center,
  //           children:[
  //            Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
        
  //             children: [
  //               Container(
  //                 height:70,
  //                 width: 70,
  //                 child: Image.asset("assets/clock.png",fit: BoxFit.fill,)),
  //                 const SizedBox(width: 20,),
  //               Text("Set a remainder",style: GoogleFonts.poppins(fontSize: 16),)
  //             ],
  //            ),
  //            const SizedBox(height: 20,),
  //            const Divider(
  //             thickness: 2,
  //             indent: 20,
  //             endIndent: 20,
  //             color: Colors.grey,
  //            ),
  //           const SizedBox(height: 20,),
  //             Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
        
  //             children: [
  //               Container(
  //                 height: 70,
  //                 width: 70,
  //                 child: Image.asset("assets/share.png",fit: BoxFit.fill,)),
  //                 const SizedBox(width: 20,),
  //               Text("Share your score",style: GoogleFonts.poppins(fontSize: 16),)
  //             ],
  //            ),
  //            const SizedBox(height: 20,),
  //            const Divider(
  //             thickness: 2,
  //             indent: 20,
  //             endIndent: 20,
  //             color: Colors.grey,
  //            ),
  //            const SizedBox(height: 20,),
  //              Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
        
  //             children: [
  //               Container(
  //                 height: 90,
  //                 width: 100,
  //                 child: Image.asset("assets/logo2.png",fit: BoxFit.fill,)),
  //                 const SizedBox(width: 20,),
  //               Text("Share App",style: GoogleFonts.poppins(fontSize: 16),)
  //             ],
  //            ),
  //            const SizedBox(height: 20,),
  //            const Divider(
  //             thickness: 2,
  //             indent: 20,
  //             endIndent: 20,
  //             color: Colors.grey,
  //            ),
  //            const SizedBox(
  //             height: 50,
  //            ),
  //            Container(
  //             height: 50,
  //             width: 200,
  //             child: CustomTextButton(text: "Done",))
        
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }