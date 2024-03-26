import 'package:flutter/material.dart';
import 'package:mediclear_labs/constants/colors.dart';

class PastMedicalHistory extends StatefulWidget {
   PastMedicalHistory({super.key,required this.que1,required this.que2a,required this.que2b,required this.que2c});
  List que1=[];
  List que2a=[];
  List que2b=[];
  List que2c=[];

  @override
  State<PastMedicalHistory> createState() => _PastMedicalHistoryState();
}

class _PastMedicalHistoryState extends State<PastMedicalHistory> {
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


  @override
  Widget build(BuildContext context) {
    return Column(
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
                        pastquestion11 = value!;
                        if(pastquestion11==true){
                          widget.que1.add(1);
                          
                        }
                        else{
                          widget.que1.remove(1);
                        }
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
                        pastquestion12 = value!;
                        if(pastquestion12==true){
                          widget.que1.add(2);

                        }
                        else{
                          widget.que1.remove(2);
                        }
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
                        pastquestion13 = value!;
                        if(pastquestion13==true)
                        {
                          widget.que1.add(3);
                        }
                        else{
                          widget.que1.remove(3);
                        }
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
                        pastquestion14 = value!;
                        if(pastquestion14==true)
                        widget.que1.add(4);
                        else
                        widget.que1.remove(4);
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
                        pastquestion15 = value!;
                        if(pastquestion15==true)
                        widget.que1.add(5);
                        else
                        widget.que1.remove(5);
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
                        pastquestion2a1 = value!;
                        if(pastquestion2a1==true)
                        widget.que2a.add(1);
                        else
                        widget.que2a.remove(1);
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
                            pastquestion2a2 = value!;
                               if(pastquestion2a2==true)
                        widget.que2a.add(2);
                        else
                        widget.que2a.remove(2);
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
                            pastquestion2a3 = value!;
                               if(pastquestion2a3==true)
                        widget.que2a.add(3);
                        else
                        widget.que2a.remove(3);
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
                            pastquestion2a4 = value!;
                               if(pastquestion2a4==true)
                        widget.que2a.add(4);
                        else
                        widget.que2a.remove(4);
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
                        pastquestion2a5 = value!;
                           if(pastquestion2a5==true)
                        widget.que2a.add(5);
                        else
                        widget.que2a.remove(5);
                      });
                    },
                  ),
                  const Text("associated with attack",style: TextStyle(fontSize: 14),),
                  Checkbox(
                    value: pastquestion2a6,
                    onChanged: (value) {
                      setState(() {
                        pastquestion2a6 = value!;
                           if(pastquestion2a6==true)
                        widget.que2a.add(6);
                        else
                        widget.que2a.remove(6);
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
                        pastquestion2b1 = value!;
                        
                        if(pastquestion2b1==true)
                        widget.que2b.add(1);
                        else
                        widget.que2b.remove(1);
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
                            pastquestion2b2 = value!;
                            
                        if(pastquestion2b1==true)
                        widget.que2b.add(2);
                        else
                        widget.que2b.remove(2);
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
                            pastquestion2b3 = value!;
                            
                        if(pastquestion2b3==true)
                        widget.que2b.add(3);
                        else
                        widget.que2b.remove(3);
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
                            pastquestion2b4 = value!;
                            
                        if(pastquestion2b4==true)
                        widget.que2b.add(4);
                        else
                        widget.que2b.remove(4);
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
                        pastquestion2b5 = value!;
                       
                        if(pastquestion2b5==true)
                        widget.que2b.add(5);
                        else
                        widget.que2b.remove(5);
                      });
                    },
                  ),
                  const Text("associated with attack",style: TextStyle(fontSize: 14),),
                  Checkbox(
                    value: pastquestion2b6,
                    onChanged: (value) {
                      setState(() {
                        pastquestion2b6 = value!;
                         
                        if(pastquestion2b6==true)
                        widget.que2b.add(6);
                        else
                        widget.que2b.remove(6);
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
                        pastquestion2c1 = value!;
                         
                        if(pastquestion2c1==true)
                        widget.que2c.add(1);
                        else
                        widget.que2c.remove(1);
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
                            pastquestion2c2 = value!;
                             
                        if(pastquestion2c2==true)
                        widget.que2c.add(2);
                        else
                        widget.que2c.remove(2);
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
                            pastquestion2c3 = value!;
                           
                        if(pastquestion2c3==true)
                        widget.que2c.add(3);
                        else
                        widget.que2c.remove(3);
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
                            pastquestion2c4 = value!;
                           
                        if(pastquestion2c4==true)
                        widget.que2c.add(4);
                        else
                        widget.que2c.remove(4);
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
                        pastquestion2c5 = value!;
                    
                        if(pastquestion2c5==true)
                        widget.que2a.add(5);
                        else
                        widget.que2a.remove(5);
                      });
                    },
                  ),
                  const Text("associated with attack",style: TextStyle(fontSize: 14),),
                  Checkbox(
                    value: pastquestion2c6,
                    onChanged: (value) {
                      setState(() {
                        pastquestion2c6 = value!;
                    
                        if(pastquestion2c6==true)
                        widget.que2a.add(6);
                        else
                        widget.que2a.remove(6);
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),

     




      ],
    );
  }
}







  class Complaints extends StatefulWidget {
   Complaints({super.key,required this.complain});
  List complain=[];

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
   bool pastquestionc1 = false;
  bool pastquestionc2 = false;
  bool pastquestionc3 = false;
  bool pastquestionc4 = false;
   bool pastquestionc5 = false;
  bool pastquestionc6 = false;
 
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

         
             
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
                        pastquestionc1 = value!;
                        if(pastquestionc1==true)
                        widget.complain.add(1);
                        else
                        widget.complain.remove(1);
                      });
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
                    pastquestionc2 = value!;
                     if(pastquestionc2==true)
                        widget.complain.add(2);
                        else
                        widget.complain.remove(2);
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
                    pastquestionc3 = value!;
                     if(pastquestionc3==true)
                        widget.complain.add(3);
                        else
                        widget.complain.remove(3);
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
                    pastquestionc4 = value!;
                     if(pastquestionc4==true)
                        widget.complain.add(4);
                        else
                        widget.complain.remove(4);
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
                    pastquestionc5 = value!;
                     if(pastquestionc5==true)
                        widget.complain.add(5);
                        else
                        widget.complain.remove(5);
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
                    pastquestionc6 = value!;
                     if(pastquestionc6==true)
                        widget.complain.add(6);
                        else
                        widget.complain.remove(6);
                  });
                    },
                  ),
                ),
              
      ],
    );
  }
}