import 'dart:io';
import 'package:blades/services/api_services.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/bottom_bar.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/dimentions.dart';

class UploadContentScreen extends StatefulWidget {
  final String channelId;
  const UploadContentScreen({Key? key, required this.channelId})
      : super(key: key);
  @override
  State<UploadContentScreen> createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedText = 0;
  String filename = "";
  File? contentFile;

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }

  pickContent() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: [
          // 'jpg',
          // 'pdf',
          // 'doc',
          'mp4',
          // 'docx',
          // 'ppt',
          // 'xlsx',
          // 'png'
        ],
      );
      if (result != null) {
        var filePath = result.files.first.path;
        filename = result.files.first.name;
        File file = File(filePath!);
        contentFile = File(filePath);
        // int sizeInBytes = file.lengthSync();
        // print(sizeInBytes);
        // double sizeInMb = sizeInBytes / (1024 * 1024);
        // if (sizeInMb > 10) {
        //   showCustomSnackBar("Maximum file size 10 MB allowed");
        // } else {
        //   contentFile = File(filePath);
        //   setState(() {});
        // }
        setState(() {});
      } else {
        print("error");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Content Title",
        "controller": titleController,
        "hint": "Content Title"
      },
      {
        "name": "Content Description",
        "controller": descController,
        "hint": "Content Description"
      },
    ];
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Get.height * 0.165), // here the desired height
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(9),
                            borderSide: const BorderSide(
                                width: 0, color: Colors.white)),
                        elevation: 3.5,
                        child: Padding(
                            padding: EdgeInsets.all(Get.width * 0.02),
                            child: const Icon(Icons.arrow_back)),
                      ),
                    ),
                    Container(
                      height: mHeight * 0.07,
                      child: Image.asset(
                        "assets/icons/logo.png",
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.12,
                    ),
                  ],
                ),
                SizedBox(
                  height: Get.width * 0.02,
                ),
                Container(
                  child: Text(
                    " Upload Content",
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                        color: kBlack.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          child: Padding(
            padding: EdgeInsets.all(Get.width * 0.04),
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.04),
                ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: mHeight * 0.03,
                    );
                  },
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: profiles.length,
                  itemBuilder: (BuildContext context, int index) {
                    var thisController = profiles[index]["controller"];
                    return TextFormField(
                      controller: thisController,
                      decoration: InputDecoration(
                          hintText: profiles[index]["name"],
                          border: UnderlineInputBorder()),
                      keyboardType: TextInputType.text,
                    );

                    // return index == selectedText
                    //     ? Container(
                    //         alignment: Alignment.center,
                    //         height: index == 1
                    //             ? mHeight * 0.13
                    //             : mHeight * 0.08,
                    //         child: TextFormField(
                    //           controller: profiles[index]["controller"],
                    //           cursorColor: kBlack,
                    //           autofocus: true,
                    //           maxLines: index == 1 ? 2 : 1,
                    //           decoration: InputDecoration(
                    //               contentPadding: const EdgeInsets.only(
                    //                   top: 15, bottom: 15, right: 10),
                    //               prefixIcon: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     left: mWidth * 0.05,
                    //                     right: 15,
                    //                     top: 15,
                    //                     bottom: 20),
                    //               ),
                    //               border: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: BorderRadius.all(
                    //                     Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               // labelText: profiles[index]["name"],
                    //               // labelStyle: const TextStyle(
                    //               //     color: Colors.black,
                    //               //     fontFamily: "Poppins"),
                    //               hintStyle: const TextStyle(
                    //                   color: Colors.grey,
                    //                   fontFamily: "Poppins"),
                    //               filled: true,
                    //               fillColor: kPrimaryColor,
                    //               hintText: profiles[index]["hint"]),
                    //         ),
                    //       )
                    //     : InkWell(
                    //         onTap: () {
                    //           setState(() {
                    //             selectedText = index;
                    //           });
                    //         },
                    //         child: Container(
                    //           alignment: index == 1
                    //               ? Alignment.centerLeft
                    //               : Alignment.center,
                    //           decoration: BoxDecoration(
                    //               color: kWhite,
                    //               borderRadius: BorderRadius.circular(90)),
                    //           height: index == 1
                    //               ? mHeight * 0.13
                    //               : mHeight * 0.08,
                    //           width: mWidth,
                    //           padding: EdgeInsets.only(
                    //             left: mWidth * 0.08,
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               SizedBox(
                    //                 width: 8,
                    //               ),
                    //               Container(
                    //                 width: mWidth * 0.7,
                    //                 child: Text(
                    //                   thisController.text == ""
                    //                       ? profiles[index]["name"]
                    //                       : thisController.text,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   maxLines: 2,
                    //                   style: TextStyle(
                    //                       color: Color(0xff9E9E9E),
                    //                       fontSize: 15),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                  },
                ),
                SizedBox(
                  height: mHeight * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    pickContent();
                  },
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(50),
                    color: kSecondaryColor,
                    dashPattern: [5, 5, 5],
                    strokeWidth: 1.5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: Container(
                        width: Get.width,
                        height: Get.width * 0.17,
                        color: kWhite,
                        child: filename != ""
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    filename,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icons/upload.svg",
                                    height: Get.width * 0.08,
                                    width: Get.width * 0.08,
                                    color: kSecondaryColor,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    "Upload Content",
                                    style: TextStyle(
                                        color: kSecondaryColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Poppins"),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: mHeight * 0.02,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.08),
                    child: AppButton(
                      onpress: () {
                        String title = titleController.text.trim();
                        String desc = descController.text.trim();
                        if (title.isEmpty) {
                          showCustomSnackBar('Enter Content Title');
                        } else if (desc.isEmpty) {
                          showCustomSnackBar('Enter Content Decription');
                        } else if (contentFile == null) {
                          showCustomSnackBar('Please choose file');
                        } else {
                          EasyLoading.show(status: 'Uploading...');
                          uploadContent(
                                  title, desc, contentFile, widget.channelId)
                              .whenComplete(() {
                            getContent();
                            getChannelDetails().whenComplete(() {
                              EasyLoading.removeAllCallbacks();
                              EasyLoading.dismiss();
                              Get.back();
                            });
                          });
                        }
                      },
                      btntext: "Save",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.07,
                      widths: mWidth,
                      btnfontsize: 15.0,
                    ),
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
