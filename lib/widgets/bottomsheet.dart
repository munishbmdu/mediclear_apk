import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediclear_labs/widgets/custom_text_button.dart';

class ShowBottomSheet {
  static void showBottomSheet2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        "assets/clock.png",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Set a remainder",
                    style: GoogleFonts.poppins(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 50,
                      width: 50,
                      child: Image.asset(
                        "assets/share.png",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Share your score",
                    style: GoogleFonts.roboto(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 70,
                      width: 90,
                      child: Image.asset(
                        "assets/logo2.png",
                        fit: BoxFit.fill,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Share App",
                    style: GoogleFonts.roboto(fontSize: 16),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                thickness: 2,
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 50,
              ),
              Container(
                  height: 50,
                  width: 200,
                  child: CustomTextButton(
                    text: "Done",
                    onTap:() {
                      Navigator.of(context).pop();
                    },
                  ))
            ],
          ),
        );
      },
    );
  }

  static void showBottomSheet1(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  "Language Settings",
                  style: GoogleFonts.roboto(fontSize: 20, color: Colors.blue),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "English",
                  style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Hindi",
                  style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Bengali",
                  style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "punjabi",
                  style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Tamil",
                  style: GoogleFonts.roboto(fontSize: 17, color: Colors.black),
                ),
              ),
              const Divider(
                thickness: 2,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                  height: 50,
                  width: 200,
                  child: CustomTextButton(
                    text: "Done", onTap: () { 
                      Navigator.of(context).pop();
                     },
                  ))
            ],
          ),
        );
      },
    );
  }
}
