import 'dart:async';
import 'package:blades/controller/verify_otp_controller.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../widgets/app_button.dart';

class VerifyOtpScreen extends StatefulWidget {
  final Map data;
  final String otp;
  const VerifyOtpScreen({Key? key, required this.data, required this.otp})
      : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  OtpFieldController otpController = OtpFieldController();
  VerifyOtpController verifyOtpController = Get.put(VerifyOtpController());
  var otp = "";
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (verifyOtpController.secondsRemaining.value != 0) {
        setState(() {
          verifyOtpController.secondsRemaining.value--;
        });
      } else {
        setState(() {
          verifyOtpController.enableResend.value = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  void resendCode() {
    verifyOtpController.secondsRemaining.value = 30;
    verifyOtpController.enableResend.value = false;
    EasyLoading.show(status: 'Loading...');
    signup(widget.data, isResendOtp: true).whenComplete(() {
      EasyLoading.removeAllCallbacks();
      EasyLoading.dismiss();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          backgroundColor: Primary,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.width * 0.04),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: mHeight * 0.02,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Stack(children: [
                        Positioned(
                          child: Container(
                            padding: EdgeInsets.only(
                                left: mWidth * 0.02, right: mWidth * 0.02),
                            width: mWidth * 0.12,
                            height: mHeight * 0.06,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            alignment: Alignment.center,
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: mHeight * 0.02,
                    ),
                    Text(
                      'Verification Code',
                      style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.7,
                          fontWeight: FontWeight.w500,
                          color: kBlack.withOpacity(0.8)),
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: mHeight * 0.06,
                    ),
                    Center(
                      child: Container(
                        width: mWidth * 0.15,
                        height: mHeight * 0.10,
                        child: Image.asset("assets/images/phonelogo.png"),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.05,
                    ),
                    const Center(
                      child: Text(
                        'Verification Code',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.01,
                    ),
                    const Text(
                      'Please enter your confirmation code that you just received by SMS. ',
                      style: TextStyle(
                          color: TextGreyColor,
                          fontSize: 15,
                          fontFamily: "Poppins"),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                    Container(
                      height: mHeight * 0.06,
                      padding: EdgeInsets.only(
                          left: mWidth * 0.05, right: mWidth * 0.05),
                    ),
                    Center(
                      child: Theme(
                        data: ThemeData(
                            fontFamily: "Poppins",
                            textSelectionTheme: const TextSelectionThemeData(
                              cursorColor: kBlack,
                            )),
                        child: OTPTextField(
                            controller: otpController,
                            length: 4,
                            width: MediaQuery.of(context).size.width,
                            otpFieldStyle: OtpFieldStyle(
                                backgroundColor: kWhite,
                                disabledBorderColor: kWhite,
                                enabledBorderColor: kWhite,
                                borderColor: kWhite,
                                focusBorderColor: kWhite),
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: mWidth * 0.2,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 30,
                            style: TextStyle(fontSize: 17),
                            onChanged: (pin) {
                              print("Changed: " + pin);
                            },
                            onCompleted: (pin) {
                              otp = pin;
                              setState(() {});
                            }),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.05,
                    ),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: mWidth * 0.1),
                        child: AppButton(
                          onpress: () async {
                            var emailotp = await getotp();
                            if (otp.length != 4) {
                              showCustomSnackBar("Fill the OTP fields");
                            } else if (otp.toString() != emailotp) {
                              showCustomSnackBar("OTP is Wrong!");
                            } else {
                              EasyLoading.show(status: 'Loading...');
                              verifyOtp(otp, widget.data).whenComplete(() {
                                EasyLoading.removeAllCallbacks();
                                EasyLoading.dismiss();
                              });
                            }
                          },
                          btntext: "Submit",
                          textcolor: const Color(0xffF4FAFF),
                          btncolor: kSecondaryColor,
                          heights: mHeight * 0.07,
                          btnfontsize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'If OTP Is Not Received ?  ',
                          style: TextStyle(
                              fontSize: 14,
                              color: TextGreyColor,
                              fontFamily: "Poppins"),
                        ),
                        verifyOtpController.enableResend.value
                            ? InkWell(
                                onTap: () {
                                  resendCode();
                                },
                                child: const Text(
                                  "Resend",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: GradientColorA,
                                      fontFamily: "Poppins"),
                                ),
                              )
                            : Text(
                                "Resend",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: GradientColorA.withOpacity(0.4),
                                    fontFamily: "Poppins"),
                              ),
                      ],
                    ),
                    Center(
                      child: Text(
                        "Resend code after ${verifyOtpController.secondsRemaining.value} seconds",
                        style: TextStyle(
                            fontSize: 12,
                            color: GreyColor.withOpacity(0.7),
                            fontFamily: "Poppins"),
                      ),
                    ),
                    SizedBox(
                      height: mHeight * 0.03,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
