import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  void initState() {
    super.initState();

    AppHelper.setStatusbar();
  }

  TextEditingController cardnoController = TextEditingController();
  TextEditingController validController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                            child: Icon(Icons.arrow_back)),
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
                  " Manage Payment",
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
        body: Padding(
          padding: EdgeInsets.only(
              top: mWidth * 0.1, left: mWidth * 0.04, right: mWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Add Credit/Debit Cards",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w500,
                    color: kBlack.withOpacity(0.9)),
              ),
              SizedBox(
                height: mHeight * 0.03,
              ),
              Container(
                alignment: Alignment.center,
                height: mHeight * 0.075,
                child: TextFormField(
                  cursorColor: kBlack,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(top: 10),
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(
                            left: mWidth * 0.05, right: 5, top: 15, bottom: 20),
                        child: SvgPicture.asset(
                          "assets/icons/person.svg",
                          height: 20,
                          width: 20,
                          fit: BoxFit.contain,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: mWidth * 0.05),
                        child: Image.asset(
                          "assets/images/card.png",
                          height: mWidth * 0.06,
                          width: mWidth * 0.12,
                          fit: BoxFit.contain,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(
                          color: kBlack,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(
                          color: kBlack,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90.0)),
                        borderSide: BorderSide(
                          color: kBlack,
                          width: 1,
                        ),
                      ),
                      // labelText: "Name",
                      // labelStyle:
                      //     TextStyle(color: Colors.black, fontFamily: "Poppins"),
                      hintStyle:
                          TextStyle(color: Colors.black, fontFamily: "Poppins"),
                      filled: true,
                      fillColor: kPrimaryColor,
                      hintText: 'Name'),
                ),
              ),
              SizedBox(
                height: mHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: Get.width * 0.45,
                    height: mHeight * 0.075,
                    child: TextFormField(
                      cursorColor: kBlack,
                      controller: validController,
                      decoration: InputDecoration(
                          hintText: "Valid Till",
                          hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Poppins"),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)))),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.45,
                    height: mHeight * 0.075,
                    // padding: EdgeInsets.only(left: Get.width * 0.02),
                    child: TextFormField(
                      cursorColor: kBlack,
                      controller: cvvController,
                      decoration: InputDecoration(
                          hintText: "CVV",
                          hintStyle: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontFamily: "Poppins"),
                          filled: true,
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kWhite),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32)))),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: mHeight * 0.03,
              ),
              Container(
                width: Get.width,
                height: mHeight * 0.075,
                // padding: EdgeInsets.only(left: Get.width * 0.02),
                child: TextFormField(
                  cursorColor: kBlack,
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Name on the Card",
                      hintStyle: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: "Poppins"),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kWhite),
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kWhite),
                          borderRadius: BorderRadius.all(Radius.circular(32)))),
                ),
              ),
              SizedBox(
                height: mHeight * 0.05,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mWidth * 0.03, horizontal: mWidth * 0.03),
                  child: AppButton(
                    onpress: () {},
                    btntext: "Save",
                    textcolor: const Color(0xffF4FAFF),
                    btncolor: kSecondaryColor,
                    heights: mHeight * 0.07,
                    btnfontsize: 15.0,
                    widths: mWidth * 0.75,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
