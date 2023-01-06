import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../services/api_services.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../widgets/app_button.dart';
import '../widgets/custom_snackbar.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController passwordController = TextEditingController(text: "");
  TextEditingController confirmpasswordController =
      TextEditingController(text: "");
  TextEditingController newpasswordController = TextEditingController(text: "");
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var selectedText = 0;

  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    List profiles = [
      {
        "name": "Old Password",
        "controller": passwordController,
        "icon": "lock",
        "hint": "Old Password"
      },
      {
        "name": "New Password",
        "controller": newpasswordController,
        "icon": "lock",
        "hint": "New Password"
      },
      {
        "name": "Confirm Password",
        "controller": confirmpasswordController,
        "icon": "lock",
        "hint": "Confirm Password"
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
                    " Change Password",
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: mHeight * 0.04),
                  child: Center(
                    child: Container(
                        height: mHeight * 0.10,
                        child: Image.asset("assets/images/phonelogo.png")),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                const Text(
                  "Change Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
                          hintText: profiles[index]["hint"],
                          // prefixIcon:
                          //     Icon(Icons.email, color: kSecondaryColor),
                          prefixIcon: Padding(
                            padding: EdgeInsets.all(mWidth * 0.03),
                            child: SvgPicture.asset(
                              "assets/icons/${profiles[index]["icon"]}.svg",
                              height: mWidth * 0.02,
                              width: mWidth * 0.02,
                            ),
                          ),
                          // suffixIcon: index == 1
                          //     ? InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             hidePassword = !hidePassword;
                          //           });
                          //         },
                          //         child: hidePassword
                          //             ? Icon(
                          //                 Icons.visibility_off,
                          //                 color: Colors.black,
                          //                 size: 22,
                          //               )
                          //             : Icon(
                          //                 Icons.visibility_outlined,
                          //                 color: Colors.black,
                          //                 size: 22,
                          //               ))
                          //     : SizedBox(),
                          border: UnderlineInputBorder()),
                      keyboardType: TextInputType.text,
                    );
                    // return index == selectedText
                    //     ? Container(
                    //         alignment: Alignment.center,
                    //         height: mHeight * 0.075,
                    //         child: TextFormField(
                    //           obscureText: hidePassword,
                    //           controller: profiles[index]["controller"],
                    //           cursorColor: kBlack,
                    //           autofocus: true,
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
                    //               suffixIcon: InkWell(
                    //                   onTap: () {
                    //                     setState(() {
                    //                       hidePassword = !hidePassword;
                    //                     });
                    //                   },
                    //                   child: hidePassword
                    //                       ? Icon(Icons.visibility_off,
                    //                           color: Colors.black)
                    //                       : Icon(
                    //                           Icons.visibility_outlined,
                    //                           color: Colors.black,
                    //                         )),
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
                    //               left: mWidth * 0.05, right: mWidth * 0.05),
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
                    //                   maxLines: 4,
                    //                   style: TextStyle(
                    //                       color: Color(0xff9E9E9E),
                    //                       fontSize: 15),
                    //                 ),
                    //               ),
                    //               SvgPicture.asset(
                    //                 "assets/icons/visibility_off.svg",
                    //                 height: 15,
                    //                 width: 15,
                    //                 fit: BoxFit.contain,
                    //                 color: Color(0xff9E9E9E),
                    //               ),
                    //             ],
                    //           ),
                    //         ),
                    //       );
                  },
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.1),
                    child: AppButton(
                      onpress: () => _changePassword(passwordController,
                          confirmpasswordController, newpasswordController),
                      btntext: "Submit",
                      textcolor: const Color(0xffF4FAFF),
                      btncolor: kSecondaryColor,
                      heights: mHeight * 0.07,
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

  _changePassword(
      TextEditingController passwordController,
      TextEditingController confirmpasswordController,
      TextEditingController newpasswordController) async {
    String _password = passwordController.text.trim();
    String _confirmpassword = confirmpasswordController.text.trim();
    String _newpassword = newpasswordController.text.trim();

    if (_password.isEmpty) {
      showCustomSnackBar('Enter your new password');
    } else if (_confirmpassword.isEmpty) {
      showCustomSnackBar('Enter your confirm password');
    } else if (_newpassword != _confirmpassword) {
      showCustomSnackBar('Password do not match');
    } else if (_newpassword.isEmpty) {
      showCustomSnackBar('Enter Your New Password');
    } else if (_newpassword.length < 6) {
      showCustomSnackBar('Enter more than 6 digit ');
    } else {
      changePassword(_password, _newpassword);
    }
  }
}
