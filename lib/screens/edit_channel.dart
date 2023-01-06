import 'dart:io';

import 'package:blades/services/api_services.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/dimentions.dart';

class EditChannel extends StatefulWidget {
  final String channelid;
  final String title;
  final String desc;
  final String channelImg;
  const EditChannel(
      {Key? key,
      required this.channelid,
      required this.title,
      required this.desc,
      required this.channelImg})
      : super(key: key);

  @override
  State<EditChannel> createState() => _EditChannelState();
}

class _EditChannelState extends State<EditChannel> {
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedIndex = 0;

  @override
  void initState() {
    titleController.text = widget.title;
    descController.text = widget.desc;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // titleController.dispose();
    // descController.dispose();
  }

  File? editchannelImage;
  Future pickImage() async {
    try {
      final pickimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickimage == null) return;
      print(pickimage.path);
      final imageTemp = File(pickimage.path);
      setState(() => editchannelImage = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Channel Title",
        "controller": titleController,
        "hint": "Jhon’s Medical Blog"
      },
      {
        "name": "Channel Description",
        "controller": descController,
        "hint": "Channel Description"
      },
    ];
    return SafeArea(
      child: Scaffold(
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
                    " Edit Channel",
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
        body: Padding(
          padding: EdgeInsets.all(Get.width * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.01),
                Container(
                  height: Get.height * 0.2,
                  child: Stack(
                    children: [
                      Container(
                          height: Get.width * 0.32,
                          width: Get.width * 0.32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: kPrimaryColor, width: 2)),
                          child: editchannelImage != null
                              ? CircleAvatar(
                                  radius: Get.width * 0.15,
                                  backgroundColor: Colors.white,
                                  backgroundImage: FileImage(editchannelImage!),
                                )
                              : CircleAvatar(
                                  radius: Get.width * 0.15,
                                  backgroundColor: Colors.white,
                                  backgroundImage:
                                      NetworkImage(widget.channelImg),
                                )),
                      Positioned(
                        bottom: 10,
                        left: Get.width * 0.12,
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Container(
                            height: Get.height * 0.05,
                            width: Get.height * 0.05,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 4.0,
                                      spreadRadius: 2),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: CircleAvatar(
                              backgroundColor: kSecondaryColor,
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
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
                    // return index == selectedIndex
                    //     ? Container(
                    //         alignment: Alignment.center,
                    //         height:
                    //             index == 1 ? mHeight * 0.13 : mHeight * 0.08,
                    //         child: TextFormField(
                    //           controller: profiles[index]["controller"],
                    //           cursorColor: kBlack,
                    //           autofocus: true,
                    //           maxLines: index == 1 ? 3 : 1,
                    //           decoration: InputDecoration(
                    //               contentPadding: const EdgeInsets.only(
                    //                   top: 15, bottom: 15, right: 10),
                    //               prefixIcon: SizedBox(),
                    //               border: OutlineInputBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius:
                    //                     BorderRadius.all(Radius.circular(90.0)),
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
                    //             selectedIndex = index;
                    //           });
                    //         },
                    //         child: Container(
                    //           alignment: index == 1
                    //               ? Alignment.centerLeft
                    //               : Alignment.center,
                    //           decoration: BoxDecoration(
                    //               color: kWhite,
                    //               borderRadius: BorderRadius.circular(90)),
                    //           height:
                    //               index == 1 ? mHeight * 0.13 : mHeight * 0.08,
                    //           width: mWidth,
                    //           padding: EdgeInsets.only(
                    //             left: mWidth * 0.08,
                    //             right: mWidth * 0.02,
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
                    //                   maxLines: index == 1 ? 3 : 1,
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
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.08),
                    child: AppButton(
                      onpress: () async {
                        String title = titleController.text;
                        String desc = descController.text;
                        bool titleExist = false;
                        var channeltitlelist = await getchannelList();
                        for (var element in channeltitlelist!) {
                          if (element == title) {
                            titleExist = true;
                          }
                        }
                        if (title.isEmpty) {
                          showCustomSnackBar('Enter Channel Title');
                        } else if (desc.isEmpty) {
                          showCustomSnackBar('Enter Channel Decription');
                        } else {
                          EasyLoading.show(status: 'Updating...');
                          editChannel(title, desc, editchannelImage,
                                  widget.channelid)
                              .whenComplete(() {
                            getChannelDetails().whenComplete(() {
                              EasyLoading.removeAllCallbacks();
                              EasyLoading.dismiss();
                              Get.back();
                            });
                          });
                        }
                        // getChannelDetails();
                      },
                      btntext: "Save",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.075,
                      widths: mWidth ,
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
