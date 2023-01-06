import 'package:blades/screens/edit_profile.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/profile_controller.dart';
import '../utils/dimentions.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());
  
  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  Size.fromHeight(Get.height * 0.15), // here the desired height
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
                    Text(
                      " Profile",
                      style: TextStyle(
                          fontSize: 15,
                          // fontFamily: "Poppins",
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w500,
                          color: kBlack.withOpacity(0.9)),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.width * 0.1,
                            bottom: 0,
                            left: Get.width * 0.04,
                            right: Get.width * 0.04),
                        child: Container(
                          margin: EdgeInsets.only(top: Get.width * 0.05),
                          // height: Get.height * 0.58,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 4.0,
                                  spreadRadius: 1),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: mHeight * 0.02,
                                right: mHeight * 0.02,
                                top: mWidth * 0.2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailWidget(
                                    text1: "Name",
                                    text2: profileController.name.value),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                DetailWidget(
                                    text1: "Email",
                                    text2: profileController.email.value),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                DetailWidget(
                                    text1: "Contact",
                                    text2: profileController.contact.value),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                DetailWidget(
                                    text1: "Bio/Description",
                                    text2: profileController.bio.value),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                DetailWidget(
                                    text1: "Other important details",
                                    text2: profileController
                                        .otherDetails.value),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: Get.width * 0.35,
                        child: Container(
                          height: Get.width * 0.3,
                          width: Get.width * 0.3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: kSecondaryColor, width: 2)),
                          child: profileController.image.value != ""
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    progressIndicatorBuilder:
                                        (context, url, progress) => Center(
                                      child: CircularProgressIndicator(
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                    imageUrl:
                                        "https://nodeserver.mydevfactory.com:3309/userProfile/${profileController.image.value}",
                                    height: Get.width * 0.25,
                                    width: Get.width * 0.25,
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : CircleAvatar(
                                  radius: Get.width * 0.15,
                                  backgroundImage: AssetImage(
                                      "assets/images/person.png"),
                                ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mWidth * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: mWidth * 0.06, horizontal: mWidth * 0.04),
                    child: AppButton(
                      onpress: () {
                        Get.to(const EditProfile());
                      },
                      btntext: "Edit Profile",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.07,
                      btnfontsize: 15.0,
                    ),
                  ),
                  SizedBox(
                    height: mHeight * 0.1,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class DetailWidget extends StatelessWidget {
  final String text1;
  final String text2;
  const DetailWidget({Key? key, required this.text1, required this.text2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: Get.width * 0.37,
          child: Text(
            text1,
            style: TextStyle(
              color: Color(0xff606060),
              fontSize: 13,
            ),
          ),
        ),
        Text(
          ":   ",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
          ),
        ),
        Container(
          width: Get.width * 0.4,
          child: Text(
            text2,
            maxLines: 4,
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }
}
