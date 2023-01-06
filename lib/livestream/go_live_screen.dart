import 'dart:io';
import 'dart:typed_data';
import 'package:blades/livestream/feed_screen.dart';
import 'package:blades/livestream/firestore_methods.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'broadcast_screen.dart';

class GoLiveScreen extends StatefulWidget {
  const GoLiveScreen({Key? key}) : super(key: key);

  @override
  State<GoLiveScreen> createState() => _GoLiveScreenState();
}

class _GoLiveScreenState extends State<GoLiveScreen> {
  final TextEditingController _titleController = TextEditingController();
  Uint8List? image;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  goLiveStream() async {
    EasyLoading.show(status: 'Starting Live...');
    String channelId = await FirestoreMethods()
        .startLiveStream(context, _titleController.text, image);
    if (channelId.isNotEmpty) { 
      Get.to(
        BroadcastScreen(
          isBroadcaster: true,
          channelId: channelId,
        ),
      );
    }
    EasyLoading.removeAllCallbacks();
    EasyLoading.dismiss();
  }

  Future<Uint8List?> pickImage() async {
    FilePickerResult? pickedImage = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (pickedImage != null) {
      return await File(pickedImage.files.single.path!).readAsBytes();
    }
    return null;
  }

  Future<Uint8List?> getFromGallery() async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (pickedImage != null) {
        return await File(pickedImage.path).readAsBytes();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Uint8List?> getFromCamera() async {
    try {
      XFile? pickedImage = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (pickedImage != null) {
        return await File(pickedImage.path).readAsBytes();
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future imagePickerDialog(context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (ctx) => Dialog(
        child: Container(
          height: mHeight * 0.17,
          width: mWidth * 0.6,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Uint8List? pickedImage = await getFromCamera();
                        if (pickedImage != null) {
                          setState(() {
                            image = pickedImage;
                          });
                        }
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.camera,
                            size: 30,
                          ),
                          Text(
                            "Camera",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kBlack, fontSize: 18),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.03,
                    ),
                    GestureDetector(
                      onTap: () async {
                        Uint8List? pickedImage = await getFromGallery();
                        if (pickedImage != null) {
                          setState(() {
                            image = pickedImage;
                          });
                        }
                        Get.back();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.wallpaper,
                            size: 30,
                          ),
                          Text(
                            "Gallery ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: kBlack, fontSize: 18),
                          ),
                          SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBlack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FeedScreen(),
                SizedBox(
                  height: mHeight * 0.04,
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        imagePickerDialog(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: image != null
                            ? SizedBox(
                                height: mHeight * 0.25,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.memory(image!)),
                              )
                            : DottedBorder(
                                borderType: BorderType.RRect,
                                radius: const Radius.circular(10),
                                dashPattern: const [10, 4],
                                strokeCap: StrokeCap.round,
                                color: kPrimaryColor,
                                child: Container(
                                  width: double.infinity,
                                  height: mHeight * 0.25,
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor.withOpacity(.05),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.folder_open,
                                        color: kPrimaryColor,
                                        size: 40,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        'Select your thumbnail',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey.shade400,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Title',
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: TextField(
                            style: TextStyle(color: kWhite),
                            controller: _titleController,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kSecondaryColor,
                                    width: 2,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kSecondaryColor,
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: AppButton(
                    btntext: 'Go Live!',
                    heights: mHeight * 0.08,
                    onpress: goLiveStream,
                    btncolor: kSecondaryColor,
                    textcolor: kWhite,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
