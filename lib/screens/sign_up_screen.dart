import 'package:blades/screens/verify_otp_screen.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../widgets/custom_snackbar.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'sign_in_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController lastnameController = TextEditingController(text: "");
  TextEditingController phonenumberController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmpasswordController =
      TextEditingController(text: "");
  var selectedText = 0;
  bool checkdvalue = false;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    PhoneInputFormatter.replacePhoneMask(
      countryCode: 'US',
      newMask: '+0 (000) 000-0000',
    );
    PhoneInputFormatter.addAlternativePhoneMasks(
      countryCode: 'US',
      alternativeMasks: [
        '+0 (000) 000-0000',
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "First name",
        "controller": nameController,
        "icon": "person",
        "hint": "Name"
      },
      {
        "name": "Last name",
        "controller": lastnameController,
        "icon": "contactcall",
        "hint": "Last Name"
      },
      {
        "name": "Phone number",
        "controller": phonenumberController,
        "icon": "contactcall",
        "hint": "+1 (234) 567-7890"
      },
      {
        "name": "Email address",
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
      {
        "name": "Confirm password",
        "controller": confirmpasswordController,
        "icon": "lock",
        "hint": "Confirm Password"
      },
    ];

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Get.width * 0.04,
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: mWidth * 0.03),
                  child: SizedBox(
                      height: mHeight * 0.2,
                      width: mHeight * 0.2,
                      child: Image.asset(
                        "assets/images/logo1.png",
                        // fit: BoxFit.fill,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: mWidth * 0.05),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: mHeight * 0.01,
                      );
                    },
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profiles.length,
                    itemBuilder: (BuildContext context, int index) {
                      var thisController = profiles[index]["controller"];

                      if (index == 2) {
                        return TextFormField(
                          keyboardType: TextInputType.phone,
                          autocorrect: false,
                          controller: thisController,
                          decoration:
                              InputDecoration(hintText: "+1 (123) 456-7890"),
                          inputFormatters: [
                            PhoneInputFormatter(
                              allowEndlessPhone: true,
                            )
                          ],
                        );
                      }

                      return TextFormField(
                        controller: thisController,
                        obscureText: index == 4 ? hidePassword : false,
                        decoration: InputDecoration(
                            hintText: profiles[index]["name"],
                            suffixIcon: index == 4
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
                      // return index == selectedText
                      //     ? Container(
                      //         alignment: Alignment.center,
                      //         height: mHeight * 0.075,
                      //         child: TextFormField(
                      //           obscureText: index == 3 || index == 4
                      //               ? hidePassword
                      //               : false,
                      //           controller: profiles[index]["controller"],
                      //           cursorColor: kBlack,
                      //           autofocus: true,
                      //           keyboardType:
                      //               profiles[index]["name"] == 'Phone Number'
                      //                   ? TextInputType.number
                      //                   : TextInputType.text,
                      //           decoration: InputDecoration(
                      //               contentPadding:
                      //                   const EdgeInsets.only(top: 10),
                      //               prefixIcon: Padding(
                      //                 padding: EdgeInsets.only(
                      //                     left: mWidth * 0.08,
                      //                     right: 10,
                      //                     top: 15,
                      //                     bottom: 20),
                      //                 child: SvgPicture.asset(
                      //                   "assets/icons/${profiles[index]["icon"]}.svg",
                      //                   height: 20,
                      //                   width: 20,
                      //                   color: kBlack,
                      //                   fit: BoxFit.contain,
                      //                 ),
                      //               ),
                      //               suffixIcon: index == 3 || index == 4
                      //                   ? InkWell(
                      //                       onTap: () {
                      //                         setState(() {
                      //                           hidePassword = !hidePassword;
                      //                         });
                      //                       },
                      //                       child: hidePassword
                      //                           ? Icon(
                      //                               Icons.visibility_off,
                      //                               color: Colors.black,
                      //                               size: 22,
                      //                             )
                      //                           : Icon(
                      //                               Icons.visibility_outlined,
                      //                               color: Colors.black,
                      //                               size: 22,
                      //                             ))
                      //                   : SizedBox(),
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
                      //             selectedText = index;
                      //           });
                      //         },
                      //         child: Container(
                      //           alignment: Alignment.center,
                      //           decoration: BoxDecoration(
                      //               color: kWhite,
                      //               borderRadius: BorderRadius.circular(90)),
                      //           height: mHeight * 0.075,
                      //           width: mWidth,
                      //           padding: EdgeInsets.only(
                      //               left: mWidth * 0.05, right: mWidth * 0.03),
                      //           child: Row(
                      //             children: [
                      //               SvgPicture.asset(
                      //                 "assets/icons/${profiles[index]["icon"]}.svg",
                      //                 height: 20,
                      //                 width: 20,
                      //                 fit: BoxFit.contain,
                      //                 color: Color(0xff9E9E9E),
                      //               ),
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
                      //                   style: TextStyle(
                      //                       color: Color(0xff9E9E9E),
                      //                       fontSize: 15),
                      //                 ),
                      //               ),
                      //               index == 3 || index == 4
                      //                   ? Icon(
                      //                       Icons.visibility_off,
                      //                       size: 20,
                      //                     )
                      //                   : SizedBox(),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: mWidth * 0.03, left: mWidth * 0.03),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: GradientColorA,
                        value: checkdvalue,
                        onChanged: (value) {
                          setState(() {
                            checkdvalue = value!;
                          });
                        },
                      ),
                      Text(
                        'I agree with the Terms and Conditions.',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontSize: 10),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.05),
                    child: AppButton(
                      onpress: () => _signUp(
                          nameController,
                          phonenumberController,
                          emailController,
                          passwordController,
                          confirmpasswordController),
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.07,
                      btnfontsize: 15.0,
                      btntext: 'Submit',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already Have An Account ?  ',
                      style: TextStyle(
                          fontSize: 14,
                          color: TextGreyColor,
                          fontFamily: "Poppins"),
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SignInPage());
                      },
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: GradientColorA,
                            fontFamily: "Poppins"),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: mHeight * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void _signUp(
      TextEditingController nameController,
      TextEditingController phonenumberController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController confrimpasswordController) async {
    String _name = nameController.text.trim();
    String _phonenumber = phonenumberController.text.trim();
    String _email = emailController.text.trim();
    String _password = passwordController.text.trim();
    String _confirmpassword = confirmpasswordController.text.trim();

    print(phonenumberController.text.length);
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    RegExp passwordreg =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

    RegExp emailvalidation = RegExp(pattern);
    if (_name.isEmpty) {
      showCustomSnackBar('Enter Your Name');
    } else if (_email.isEmpty) {
      showCustomSnackBar('Enter Your Email');
    } else if (!emailvalidation.hasMatch(_email)) {
      showCustomSnackBar('Enter a valid email address');
    } else if (_phonenumber.isEmpty) {
      showCustomSnackBar('Enter Your Phone Number');
    } else if (_phonenumber.length != 17) {
      showCustomSnackBar('Enter valid Phone Number');
    } else if (_password.isEmpty) {
      showCustomSnackBar('Enter Your Password');
    } else if (!passwordreg.hasMatch(_password)) {
      showCustomSnackBar(
          'Password contain at least one upper, lower, digit, special character');
    } else if (_password.length < 8) {
      showCustomSnackBar('Password must be at least 8 characters in length');
    } else if (_confirmpassword.isEmpty) {
      showCustomSnackBar('Enter Confirm Password');
    } else if (_password != _confirmpassword) {
      showCustomSnackBar('Password do not match');
    } else if (!checkdvalue) {
      showCustomSnackBar('Please agree with the terms and conditions');
    } else {
      print(_name + _phonenumber + _email + _password + _confirmpassword);

      Map data = {
        "name": _name,
        "email": _email,
        "phone": _phonenumber,
        "password": _password,
      };
      EasyLoading.show(status: 'Loading...');
      signup(data).whenComplete(() {
        EasyLoading.removeAllCallbacks();
        EasyLoading.dismiss();
      });
    }
  }
}
