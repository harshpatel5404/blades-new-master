import 'dart:ui';

import 'package:blades/screens/forget_password_screen.dart';
import 'package:blades/screens/home.dart';
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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedText = 0;
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Email",
        "controller": emailController,
        "icon": "contactemail",
        "hint": "Email"
      },
      {
        "name": "Password",
        "controller": passwordController,
        "icon": "lock",
        "hint": "Password"
      },
    ];
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              // Positioned(
              //   // alignment: Alignment.bottomRight,
              //   bottom: 0,
              //   right: 0,
              //   child: SizedBox(
              //       height: mHeight * 0.15,
              //       width: mHeight * 0.15,
              //       child: Image.asset(
              //         "assets/images/corner.png",
              //       )),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: mHeight * 0.2,
                    ),
                    SizedBox(
                        height: mHeight * 0.33,
                        width: mHeight * 0.33,
                        child: Image.asset(
                          "assets/images/logo1.png",
                        )),
                    SizedBox(height: mHeight * 0.09),
                    Column(
                      children: [
                        Theme(
                          data: ThemeData(
                            primaryColor: kSecondaryColor,
                            fontFamily: 'Poppins',
                            inputDecorationTheme: InputDecorationTheme(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kSecondaryColor, width: 1.5),
                              ),
                            ),
                            textSelectionTheme: TextSelectionThemeData(
                                cursorColor: kSecondaryColor,
                                selectionColor: kSecondaryColor),
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: profiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              var thisController =
                                  profiles[index]["controller"];
                              return TextFormField(
                                controller: thisController,
                                obscureText: index == 1 ? hidePassword : false,
                                decoration: InputDecoration(
                                    hintText: profiles[index]["hint"],
                                    suffixIcon: index == 1
                                        ? InkWell(
                                            onTap: () {
                                              setState(() {
                                                hidePassword = !hidePassword;
                                              });
                                            },
                                            child: hidePassword
                                                ? Icon(
                                                    Icons.visibility_off,
                                                    color: Colors.black,
                                                    size: 22,
                                                  )
                                                : Icon(
                                                    Icons.visibility_outlined,
                                                    color: Colors.black,
                                                    size: 22,
                                                  ))
                                        : SizedBox(),
                                    border: UnderlineInputBorder()),
                                keyboardType: TextInputType.text,
                              );
                            },
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: mHeight * 0.03, bottom: mHeight * 0.02),
                            child: AppButton(
                              onpress: () =>
                                  _signIn(emailController, passwordController),
                              btntext: "Sign In",
                              textcolor: const Color(0xffF4FAFF),
                              btncolor: kSecondaryColor,
                              heights: mHeight * 0.075,
                              btnfontsize: 15.0,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(ForgetPasswordScreen());
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                                fontFamily: "Poppins"),
                          ),
                        ),
                        SizedBox(
                          height: mHeight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't Have An Account?",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: TextGreyColor,
                                  fontFamily: "Poppins"),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(SignUpScreen());
                              },
                              child: Text(
                                " Sign Up",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: GradientColorA,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: mHeight * 0.03,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signIn(TextEditingController emailController,
      TextEditingController passwordController) async {
    String _email = emailController.text.trim();
    String _password = passwordController.text.trim();
    if (_email.isEmpty) {
      showCustomSnackBar('Enter Your Email');
    } else if (_password.isEmpty) {
      showCustomSnackBar('Enter Your Password');
    } else {
      EasyLoading.show(status: 'Loading...');
      login(_email, _password).whenComplete(() {
        EasyLoading.removeAllCallbacks();
        EasyLoading.dismiss();
      });
    }
  }
}
