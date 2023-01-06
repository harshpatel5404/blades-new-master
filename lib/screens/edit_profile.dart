import 'dart:io';

import 'package:blades/controller/profile_controller.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/dimentions.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController bioController = TextEditingController(text: "");
  TextEditingController detailController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedText = 0;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    nameController.text = profileController.name.value;
    phoneController.text = profileController.contact.value;
    emailController.text = profileController.email.value;
    bioController.text = profileController.bio.value;
    detailController.text = profileController.otherDetails.value;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    bioController.dispose();
    detailController.dispose();
  }

  File? image;
  Future pickImage() async {
    try {
      final pickimage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickimage == null) return;
      print(pickimage.path);
      final imageTemp = File(pickimage.path);
      setState(() => image = imageTemp);
    } catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Name",
        "controller": nameController,
        "icon": "person",
        "hint": "Name"
      },
      {
        "name": "Email",
        "controller": emailController,
        "icon": "contactemail",
        "hint": "Email"
      },
      {
        "name": "Phone Number",
        "controller": phoneController,
        "icon": "contactcall",
        "hint": "+1 234-567-7890"
      },
      {
        "name": "Bio/Description",
        "controller": bioController,
        "icon": "contactcall",
        "hint": "Bio/Description"
      },
      {
        "name": "Other important details",
        "controller": detailController,
        "icon": "contactcall",
        "hint": "Other important details"
      },
    ];
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Get.height * 0.15), // here the desired height
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * 0.04, vertical: mWidth * 0.03),
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
                  height: Get.width * 0.01,
                ),
                Container(
                  child: Text(
                    " Edit Profile",
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
          padding: EdgeInsets.only(
            // top: Get.width * 0.04,
            left: Get.width * 0.04,
            right: Get.width * 0.04,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                                Border.all(color: kSecondaryColor, width: 2)),
                        child: image != null
                            ? CircleAvatar(
                                radius: Get.width * 0.15,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(image!),
                              )
                            : profileController.image.value != ""
                                ? CircleAvatar(
                                    radius: Get.width * 0.15,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                        "https://nodeserver.mydevfactory.com:3309/userProfile/${profileController.image.value}"))
                                : CircleAvatar(
                                    radius: Get.width * 0.15,
                                    backgroundColor: Colors.white,
                                    backgroundImage: const AssetImage(
                                      "assets/images/person.png",
                                    ),
                                  ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: Get.width * 0.12,
                        child: GestureDetector(
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
                          prefixIcon: index == 3 || index == 4
                              ? Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: SizedBox(),
                                )
                              : Padding(
                                  padding: EdgeInsets.all(mWidth * 0.03),
                                  child: SvgPicture.asset(
                                    "assets/icons/${profiles[index]["icon"]}.svg",
                                    height: mWidth * 0.02,
                                    width: mWidth * 0.02,
                                  ),
                                ),
                          border: UnderlineInputBorder()),
                      keyboardType: TextInputType.text,
                    );

                    // if (index == 1) {
                    //   return Container(
                    //     alignment: Alignment.center,
                    //     decoration: BoxDecoration(
                    //         color: kWhite,
                    //         borderRadius: BorderRadius.circular(90)),
                    //     height: mHeight * 0.075,
                    //     width: mWidth,
                    //     padding: EdgeInsets.only(
                    //       left: mWidth * 0.08,
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         SvgPicture.asset(
                    //           "assets/icons/${profiles[index]["icon"]}.svg",
                    //           height: 20,
                    //           width: 20,
                    //           fit: BoxFit.contain,
                    //           color: Color(0xff9E9E9E),
                    //         ),
                    //         SizedBox(
                    //           width: 8,
                    //         ),
                    //         Container(
                    //           width: mWidth * 0.7,
                    //           child: Text(
                    //             thisController.text == ""
                    //                 ? profiles[index]["name"]
                    //                 : thisController.text,
                    //             overflow: TextOverflow.ellipsis,
                    //             maxLines: 4,
                    //             style: TextStyle(
                    //                 color: Color(0xff9E9E9E), fontSize: 15),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // }
                    // return index == selectedText
                    //     ? Container(
                    //         alignment: Alignment.center,
                    //         height: index == 3 || index == 4
                    //             ? mHeight * 0.15
                    //             : mHeight * 0.075,
                    //         child: TextFormField(
                    //           controller: profiles[index]["controller"],
                    //           cursorColor: kBlack,
                    //           autofocus: true,
                    //           maxLines: index == 3 || index == 4 ? 4 : 1,
                    //           decoration: InputDecoration(
                    //               contentPadding:
                    //                   const EdgeInsets.only(top: 10),
                    //               prefixIcon: Padding(
                    //                 padding: EdgeInsets.only(
                    //                     left: mWidth * 0.08,
                    //                     right: 10,
                    //                     top: 15,
                    //                     bottom: 20),
                    //                 child: index == 3 || index == 4
                    //                     ? SizedBox()
                    //                     : SvgPicture.asset(
                    //                         "assets/icons/${profiles[index]["icon"]}.svg",
                    //                         height: 20,
                    //                         width: 20,
                    //                         color: kBlack,
                    //                         fit: BoxFit.contain,
                    //                       ),
                    //               ),
                    //               border: OutlineInputBorder(
                    //                 borderRadius: index == 3 || index == 4
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               enabledBorder: OutlineInputBorder(
                    //                 borderRadius: index == 3 || index == 4
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
                    //                 borderSide: BorderSide(
                    //                   color: kBlack,
                    //                   width: 1,
                    //                 ),
                    //               ),
                    //               focusedBorder: OutlineInputBorder(
                    //                 borderRadius: index == 3 || index == 4
                    //                     ? BorderRadius.all(
                    //                         Radius.circular(20.0))
                    //                     : BorderRadius.all(
                    //                         Radius.circular(90.0)),
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
                    //           alignment: index == 3 || index == 4
                    //               ? Alignment.centerLeft
                    //               : Alignment.center,
                    //           decoration: BoxDecoration(
                    //               color: kWhite,
                    //               borderRadius: index == 3 || index == 4
                    //                   ? BorderRadius.circular(20)
                    //                   : BorderRadius.circular(90)),
                    //           height: index == 3 || index == 4
                    //               ? mHeight * 0.15
                    //               : mHeight * 0.075,
                    //           width: mWidth,
                    //           padding: EdgeInsets.only(
                    //             left: mWidth * 0.08,
                    //           ),
                    //           child: Row(
                    //             children: [
                    //               index == 3 || index == 4
                    //                   ? SizedBox()
                    //                   : SvgPicture.asset(
                    //                       "assets/icons/${profiles[index]["icon"]}.svg",
                    //                       height: 20,
                    //                       width: 20,
                    //                       fit: BoxFit.contain,
                    //                       color: Color(0xff9E9E9E),
                    //                     ),
                    //               SizedBox(
                    //                 width: 8,
                    //               ),
                    //               Expanded(
                    //                 child: Text(
                    //                   thisController.text == ""
                    //                       ? profiles[index]["name"]
                    //                       : thisController.text,
                    //                   overflow: TextOverflow.ellipsis,
                    //                   maxLines: 4,
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
                  height: mHeight * 0.02,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.06),
                    child: AppButton(
                      onpress: () {
                        var name = nameController.text;
                        var phone = phoneController.text;
                        var email = emailController.text;
                        var bio = bioController.text;
                        var detail = detailController.text;

                        if (phone.length != 10) {
                          showCustomSnackBar("Phone number must be 10 digit");
                        } else {
                          EasyLoading.show(status: 'Loading...');
                          updateProfile(name, email, phone, bio, detail, image)
                              .whenComplete(() {
                            getProfileDetails().whenComplete(() {
                              EasyLoading.removeAllCallbacks();
                              EasyLoading.dismiss();
                              Get.back();
                            });
                          });
                        }
                      },
                      btntext: "Submit",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.075,
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
