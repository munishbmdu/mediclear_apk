import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mediclear_labs/constants/colors.dart';
import 'package:permission_handler/permission_handler.dart';


class CameraPermission extends StatefulWidget {
  const CameraPermission({Key? key});

  @override
  State<CameraPermission> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CameraPermission> {

 static File? imageFile;
 
  @override
  Widget build(BuildContext context) {
    return  InkWell(
         highlightColor:Colors.transparent,
          enableFeedback: false,
          onTap:  () async {
            Map<Permission, PermissionStatus> statuses = await [
              Permission.storage, Permission.camera,
            ].request();
            if(statuses[Permission.storage]!.isGranted && statuses[Permission.camera]!.isGranted){
              showImagePicker(context);
            } else {
              print('no permission provided');
            }
          },
      child: imageFile == null
          ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0,),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey,),
                borderRadius: BorderRadius.circular(10)
              ),
              child:Icon(Icons.person_add_alt,size: 80,)
              ),
          )
          : Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey)
                ),
                child: Image.file(imageFile!, height: 110.0, width: 110.0, fit: BoxFit.fill,)),
                Positioned(
                  top: -15,
                  right: -10,
                  child: IconButton(onPressed:() {
                    setState(() {
                      imageFile=null;
                    });
                  }, icon: Icon(Icons.close,color: Coloors.fontcolor,)))
            ],
          ),
    );
  }

  final picker = ImagePicker();

   void showImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder){
          return Card(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/5.2,
                margin: const EdgeInsets.only(top: 8.0),
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: InkWell(
                          child:  Column(
                            children: [
                              Icon(Icons.image, size: 60.0,),
                              SizedBox(height: 12.0),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style:  GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                          onTap: () {
                            _imgFromGallery();
                            Navigator.pop(context);
                          },
                        )),
                    Expanded(
                        child: InkWell(
                          child: SizedBox(
                            child: Column(
                              children: [
                                Icon(Icons.camera_alt, size: 60.0,),
                                SizedBox(height: 12.0),
                                Text(
                                  "Camera",
                                  textAlign: TextAlign.center,
                                  style:  GoogleFonts.roboto(fontSize: 16, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            _imgFromCamera();
                            Navigator.pop(context);
                          },
                        ))
                  ],
                )),
          );
        }
    );
  }

  _imgFromGallery() async {
    await  picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  _imgFromCamera() async {
    await picker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    ).then((value){
      if(value != null){
        _cropImage(File(value.path));
      }
    });
  }

  static File? returnImageFile(){
    return imageFile;
  }

  _cropImage(File imgFile) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
            toolbarTitle: "Image Cropper",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {

      imageCache.clear();
      setState(() {
        imageFile = File(croppedFile.path);
        //returnImageFile();
      });
      // reload();
    }
  }

}



