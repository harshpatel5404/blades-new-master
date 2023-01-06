import 'package:blades/services/api_services.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';
import '../utils/dimentions.dart';
import '../widgets/custom_snackbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController(text: "");

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
                    " Forgot Password",
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
                        height: mHeight * 0.15,
                        child: Image.asset("assets/images/phonelogo.png")),
                  ),
                ),
                SizedBox(height: Get.height * 0.02),
                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: mHeight * 0.03,
                ),
                Text(
                  'Please enter your registered email to confirm',
                  style: TextStyle(
                      color: TextGreyColor,
                      fontSize: 15,
                      fontFamily: "Poppins"),
                  textAlign: TextAlign.center,
                  maxLines: 3,
                ),
                SizedBox(
                  height: mHeight * 0.03,
                ),
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
                      obscureText: index == 1 ? hidePassword : false,
                      decoration: InputDecoration(
                          hintText: profiles[index]["hint"],
                          border: UnderlineInputBorder()),
                      keyboardType: TextInputType.text,
                    );
                  },
                ),
                SizedBox(height: mHeight * 0.04),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.05),
                    child: AppButton(
                      onpress: () => _forgetPassword(emailController),
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

  _forgetPassword(TextEditingController emailController) async {
    String _email = emailController.text.trim();
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";

    RegExp emailvalidation = RegExp(pattern);
    if (_email.isEmpty) {
      showCustomSnackBar('Enter Your Email');
    } else if (!emailvalidation.hasMatch(_email)) {
      showCustomSnackBar('Enter a valid email address');
    } else {
      EasyLoading.show(status: 'Loading...');
      forgetPassword(_email).whenComplete(() {
        EasyLoading.removeAllCallbacks();
        EasyLoading.dismiss();
      });
    }
  }
}
