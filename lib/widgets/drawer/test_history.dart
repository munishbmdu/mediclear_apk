// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class historyView extends StatefulWidget {
//   const historyView({super.key});
//   @override
//   State<historyView> createState() => _historyViewState();
// }

// class _historyViewState extends State<historyView> {
//  // productController controller = Get.put(productController());
//   DateTime _dateTime = DateTime.now();
//   DateTime _EndateTime = DateTime.now();

//   void _datepicker()async{    showDatePicker(
//       context: context,
//       initialEntryMode: DatePickerEntryMode.calendarOnly,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2010),
//       lastDate: DateTime.now()).then((value) {
//     setState(() {
//       _dateTime = value!;
//     });
//   });
//   }
//   void _Enddatepicker()async{
//     showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2010),
//         lastDate: DateTime.now()).then((value) {
//       setState(() {
//         _EndateTime = value!;
//         // isCalendarSelected = true;
//       });
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Container(
//         height: Get.height,
//         width: Get.width,
//         decoration: BoxDecoration(
//             color: Colors.white

//           // image: DecorationImage(
//           //     image: AssetImage('assets/rectangle.png'), fit: BoxFit.fill),
//         ),
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           body: Column(
//             children: [
//               customAppBar('History'),
//               Container(
//                 height: 1,
//                 width: Get.width,
//                 color: appcolor.borderColor,
//               ),
//               Container(
//                 decoration: BoxDecoration(),
//                 height: Get.height * 0.08,
//                 child: TabBar(
//                   dividerColor: appcolor.newRedColor,
//                   indicatorPadding: EdgeInsets.zero,
//                   unselectedLabelColor: Colors.black,
//                   labelPadding: EdgeInsets.zero,
//                   padding: EdgeInsets.zero,
//                   unselectedLabelStyle: TextStyle(
//                     fontSize: 14,
//                   ),
//                   indicatorColor: appcolor.redColor,
//                   labelColor: Colors.black,
//                   labelStyle: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Colors.black,
//                     fontSize: 14,
//                   ),
//                  // controller: controller.tabcontroller,
//                   tabs: [
//                     Container(
//                       child: Text(
//                         'Point',
//                       ),
//                     ),
//                     Container(
//                       child: Text('Transition'),
//                     ),
//                     Text('Order'),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child:
//                     TabBarView(
//                       //  controller: controller.tabcontroller,
//                         children: [
//                       points(),
//                       Transition(),
//                       Order(),
//                 ]),
//               )
//             ],
//           ),
//         //  floatingActionButton:floatingActionButon(),
//         ),
//       ),
//     );
//   }

//   Widget points() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: appcolor.newRedColor,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     10,
//                   ),
//                 ),
//                 width: Get.width * 0.6,
//                 height: Get.height * 0.05,
//                 child: customtextformfield(
//                   enabled: true,
//                   border: InputBorder.none,
//                   bottomLineColor: Colors.transparent,
//                   hinttext: 'Code Search',
//                   suffixIcon: Icon(
//                     Icons.search,
//                   ),
//                   newIcon: Icon(
//                     Icons.search,
//                   ),
//                 ),
//               ),
//               Text(
//                 'Total Points 100',
//                 style: TextStyle(
//                   fontSize: 14,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Filter :',
//                 style: TextStyle(
//                   fontSize: 16,
//                   height: 1,
//                 ),
//               ),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_dateTime== null? 'Date From: ': '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}'} ',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _datepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_EndateTime == DateTime.now() ? 'Date To: ': '${_EndateTime.year}-${_EndateTime.month}-${_EndateTime.day}'}',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _Enddatepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               blockButton(
//                 verticalPadding: 3,
//                 width: Get.width * 0.2,
//                 widget: Text(
//                   'Submit',
//                   style: TextStyle(
//                     color: Colors.white,fontSize: 12
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           )
//         ],
//       ).paddingSymmetric(
//         horizontal: 10,
//       ),
//     );
//   }

//   Widget Transition() {
//    return SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: appcolor.newRedColor,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     10,
//                   ),
//                 ),
//                 width: Get.width * 0.6,
//                 height: Get.height * 0.05,
//                 child: customtextformfield(
//                   enabled: true,
//                   border: InputBorder.none,
//                   bottomLineColor: Colors.transparent,
//                   hinttext: 'Transition Search',
//                   suffixIcon: Icon(
//                     Icons.search,
//                   ),
//                   newIcon: Icon(
//                     Icons.search,
//                   ),
//                 ),
//               ),
//               Text(
//                 'Total Points 100',
//                 style: TextStyle(
//                   fontSize: 14,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Filter :',
//                 style: TextStyle(
//                   fontSize: 16,
//                   height: 1,
//                 ),
//               ),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_dateTime == null ? 'Date From: ': '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}'} ',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _datepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_EndateTime == DateTime.now() ? 'Date To: ': '${_EndateTime.year}-${_EndateTime.month}-${_EndateTime.day}'}',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _Enddatepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               blockButton(
//                 verticalPadding: 3,
//                 width: Get.width * 0.2,
//                 widget: Text(
//                   'Submit',
//                   style: TextStyle(
//                       color: Colors.white,fontSize: 12
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Table(
//               border: TableBorder.all(),
//               children: [
//                 TableRow(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[300]
//                     ),
//                     children :[
//                       Text('Date',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Amount',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Status',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Points',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),

//               ]
//           ),
//         ],
//       ).paddingSymmetric(
//         horizontal: 10,
//       ),
//     );
//   }

//   Widget Order() {
//     return  SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: appcolor.newRedColor,
//                   ),
//                   borderRadius: BorderRadius.circular(
//                     10,
//                   ),
//                 ),
//                 width: Get.width * 0.6,
//                 height: Get.height * 0.05,
//                 child: customtextformfield(
//                   enabled: true,
//                   border: InputBorder.none,
//                   bottomLineColor: Colors.transparent,
//                   hinttext: 'Product Search',
//                   suffixIcon: Icon(
//                     Icons.search,
//                   ),
//                   newIcon: Icon(
//                     Icons.search,
//                   ),
//                 ),
//               ),
//               Text(
//                 'Total Points 100',
//                 style: TextStyle(
//                   fontSize: 14,
//                   height: 1,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Text(
//                 'Filter :',
//                 style: TextStyle(
//                   fontSize: 16,
//                   height: 1,
//                 ),
//               ),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_dateTime == null ? 'Date From: ': '${_dateTime.year}-${_dateTime.month}-${_dateTime.day}'} ',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _datepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: appcolor.newRedColor,
//                     ),
//                     borderRadius: BorderRadius.circular(
//                       10,
//                     ),
//                   ),
//                   width: Get.width * 0.26,
//                   height: Get.height * 0.04,
//                   child: Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${_EndateTime == DateTime.now() ? 'Date To: ': '${_EndateTime.year}-${_EndateTime.month}-${_EndateTime.day}'}',
//                           style: TextStyle(
//                             fontSize: 9,
//                             color: appcolor.black,
//                             height: 1,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: (){
//                             _Enddatepicker();
//                           },
//                           child: GradientText(
//                             gradient: appcolor.gradient,
//                             widget: Icon(
//                               Icons.calendar_month,
//                               size: 16,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               blockButton(
//                 verticalPadding: 3,
//                 width: Get.width * 0.2,
//                 widget: Text(
//                   'Submit',
//                   style: TextStyle(
//                       color: Colors.white,fontSize: 12
//                   ),
//                 ),
//               )
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Table(
//               border: TableBorder.all(),
//               children: [
//                 TableRow(
//                     decoration: BoxDecoration(
//                         color: Colors.grey[300]
//                     ),
//                     children :[
//                       Text('Date',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Order Id',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Order Value',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                       Text('Status',style: TextStyle(fontSize: 12,),textAlign:TextAlign.center),
//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),
//                 TableRow(
//                     children :[
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                         child: TextFormField(
//                           cursorColor: Colors.black,
//                           cursorHeight: 25,
//                           decoration: InputDecoration(
//                             border: InputBorder.none,

//                           ),
//                           keyboardType: TextInputType.visiblePassword,

//                         ),
//                       ),

//                     ]),

//               ]
//           ),
//         ],
//       ).paddingSymmetric(
//         horizontal: 10,
//       ),
//     );
//   }
// }

// Widget blockButton({
//   Widget? widget,
//   double? width,
//   double? horizontalPadding,
//   double? verticalPadding,
//   double? borderradius,
//   Function()? callback,
// }) {
//   return InkWell(
//     onTap: callback,
//     child: Container(

//       margin: EdgeInsets.all(4),
//       width: width == null ? Get.width * 0.26 : width,
//       padding: EdgeInsets.symmetric(
//           horizontal: horizontalPadding == null ? 14 : horizontalPadding,
//           vertical: verticalPadding == null ? 10 : verticalPadding),
//       decoration: BoxDecoration(
//        // gradient: Coloors.,
//         borderRadius: BorderRadius.circular(borderradius==null?30:borderradius),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.red,
//              blurRadius: 3,
//             spreadRadius: 0
//           )
//         ],
//         // border: Border.all(
//         //   color: appcolor.purpleColor,
//         // ),
//       ),
//       child: Center(child: widget),
//     ),
//   );
// }

// // import 'package:flutter/material.dart';

// class appcolor {

//   static final Color redColor = Color(0xffDD2B1C);
//   static final Color purpleColor = Colors.black;
//   static final Color mixColor = Color(0xffDD2B1C);
//   static final Color black = Colors.black;
//   static final Color greyColor = Color(0xffEEEEEE);
//   static final Color borderColor = Colors.black;
//   static final Color SufixIconColor = Color(0xffDD2B1C);
//   static final Color newRedColor = Color(0xffDD2B1C);
//   static final LinearGradient gradient = LinearGradient(
//     begin: Alignment.topCenter,
//     end: Alignment.bottomCenter,

//     // stops: [0.9,0.1],
//     colors: [
//       Color(0xffc32b30),
//       Color(0xffc32b30),
//     ],
//   );
//   static final LinearGradient voidGradient = LinearGradient(
//     // stops: [0.9,0.1],
//     colors: [
//       Colors.black,
//     ],
//   );
// }

// Widget customtextformfield({
//   bool ? obsure,
//   bool ? readOnly,
//   Color? hintTextColor,
//   Color? bottomLineColor,
//   String? hinttext,
//   String? label,
//   TextEditingController? controller,
//   Widget? suffixIcon,
//   bool showPassword = false,
//   TextInputType? key_type,
//   Widget? newIcon,
//   Function()? callback,
//   var validator,
//   int? maxLength,
//   double? horizontalcontentPadding,
//   double? verticalContentPadding,
//   Gradient? gradient,
//   InputBorder? border,
//   bool ? enabled,
// }) {
//   return Padding(
//     padding: const EdgeInsets.all(1.0),
//     child: Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: 10,
//       ),
//       child: TextFormField(
//         onTap: callback,
//         readOnly: readOnly==null?false:readOnly,
//         enabled: enabled,
//         cursorHeight: 20,
//         cursorColor: hintTextColor == null ? appcolor.black : hintTextColor,
//         validator: validator,
//         keyboardType: key_type,
//         controller: controller,
//         obscureText: showPassword,
//         maxLength: maxLength,

//         style: TextStyle(
//           decorationStyle: TextDecorationStyle.dotted,
//           decoration: TextDecoration.none,
//           color: hintTextColor == null ? appcolor.black : hintTextColor,
//           fontSize: 15,
//         ),
//         decoration: InputDecoration(
//           label: Row(
//             children: [
//               Text(hinttext.toString(),style: TextStyle(color: Colors.black,fontSize: 13),),
//               Text(label==null?'':label.toString(),style: TextStyle(color: appcolor.redColor),)
//             ],
//           ),
//           counter: Offstage(),
//           alignLabelWithHint: false,
//           contentPadding:EdgeInsets.zero,
//           // EdgeInsets.symmetric(
//           //   horizontal:
//           //       horizontalcontentPadding == null ? 0 : horizontalcontentPadding,
//           //   vertical: verticalContentPadding == null ? 0 : verticalContentPadding,
//           // ),

//           suffixIcon:
//           InkWell(
//             onTap: callback,
//             child: gradient == null
//                 ? Container(
//                     child: GradientText(
//                       gradient:appcolor.gradient,
//                       widget: showPassword == false ? newIcon : newIcon,
//                     ),
//                   )
//                 : Container(
//                     child: newIcon,
//                   ),
//           ),
//           // hintText: hinttext,
//           // hintStyle: TextStyle(
//           //   color: hintTextColor == null ? Colors.black :  hintTextColor,
//           //   fontSize: 15,
//           // ),
//           enabledBorder: UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: bottomLineColor == null
//                   ? appcolor.borderColor
//                   : bottomLineColor,
//             ),
//           ),
//           focusedBorder:border==null? UnderlineInputBorder(
//             borderSide: BorderSide(
//               color: hintTextColor == null ? Color(0xffDD2B1C) : hintTextColor,
//             ),
//           ):border,
//           border: InputBorder.none,
//         ),
//       ),
//     ),
//   );
// }

// class GradientText extends StatelessWidget {
//   const GradientText(
//      {
//     required this.gradient,
//     required this.widget,
//   });

//   final Widget? widget;

//   final Gradient gradient;

//   @override
//   Widget build(BuildContext context) {
//     return ShaderMask(
//       // blendMode: BlendMode.srcIn,
//       shaderCallback: (bounds) => gradient.createShader(
//         Rect.fromLTWH(0, 0, bounds.width, bounds.height,),
//       ),
//       child: widget,
//     );
//   }
// }

// Container customAppBar(String title) {
//   return Container(

//     color: Colors.transparent,
//     child: Row(
//       // crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         GradientText(
//           gradient: appcolor.gradient,
//           widget: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               size: 20,color: appcolor.redColor,
//             ),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ),
//         SizedBox(
//           width: 20,
//         ),
//         GradientText(
//           widget: Text(
//             title,
//             style: TextStyle(
//               height: 2,
//               fontSize: 22,color: appcolor.redColor
//             ),
//           ),
//           gradient: appcolor.gradient,
//         ),
//       ],

//     ),
//   );
// }

import 'package:flutter/material.dart';

class TextHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test History'),
        centerTitle: true,
      ),
      body: LabReportsTable(),
    );
  }
}

class LabReport {
  final String date;
  final String batchNo;
  final String test;
  final String report;

  LabReport(
      {required this.date,
      required this.batchNo,
      required this.test,
      required this.report});
}

class LabReportsTable extends StatefulWidget {
  @override
  _LabReportsTableState createState() => _LabReportsTableState();
}

class _LabReportsTableState extends State<LabReportsTable> {
  late List<LabReport> labReports;
  late List<LabReport> filteredReports;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    labReports = [
      LabReport(
          date: '2023-01-01',
          batchNo: 'B123',
          test: 'Hearing Test',
          report: 'Pending'),
      LabReport(
          date: '2023-02-15', batchNo: 'B124', test: 'Romberg', report: 'View'),
      // Add more lab reports as needed
    ];

    filteredReports = List.from(labReports);
    searchController = TextEditingController();
  }

  void searchReports(String query) {
    setState(() {
      filteredReports = labReports
          .where((report) =>
              report.batchNo.toLowerCase().contains(query.toLowerCase()) ||
              report.date.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: searchReports,
            decoration: InputDecoration(
              labelText: 'Search (Batch No or Date)',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          const SizedBox(height: 16.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.black)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Batch No',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Test',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 100.0,
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                    child: Text(
                      'Report',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: Column(
                children: List.generate(
                  filteredReports.length,
                  (index) => Container(
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0, color: Colors.black)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].date),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].batchNo),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].test),
                        ),
                        Container(
                          width: 100.0,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(filteredReports[index].report),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
