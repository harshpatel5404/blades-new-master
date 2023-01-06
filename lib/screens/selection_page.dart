import 'dart:ui';

import 'package:blades/screens/forget_password_screen.dart';
import 'package:blades/screens/home.dart';
import 'package:blades/screens/sign_in_page.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../services/firebase_services.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../widgets/custom_snackbar.dart';
import 'sign_up_screen.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({Key? key}) : super(key: key);

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: mWidth * 0.1),
                child: SizedBox(
                    height: mHeight * 0.33,
                    width: mHeight * 0.33,
                    child: Image.asset(
                      "assets/images/logo1.png",
                    )),
              ),
              Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: mHeight * 0.02),
                      child: AppButton(
                        onpress: () {
                          Get.to(SignUpScreen());
                        },
                        btntext: "Sign Up",
                        textcolor: const Color(0xffF4FAFF),
                        btncolor: kSecondaryColor,
                        heights: mHeight * 0.075,
                        btnfontsize: 15.0,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(SignInPage());
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: kSecondaryColor,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  SizedBox(
                    height: mHeight * 0.02,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
