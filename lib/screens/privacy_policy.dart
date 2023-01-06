import 'package:blades/controller/get_information.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../services/api_services.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  GetInformationController getInformationController =
      Get.put(GetInformationController());

  @override
  void initState() {
    super.initState();
    getInformationController.data.value = "";
    getInformation('get-privacy-data');
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: kPrimaryColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: kWhite,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                            child: Icon(Icons.arrow_back)),
                      ),
                    ),
                    Container(
                      height: mHeight * 0.08,
                      // width: mWidth * 0.2,
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
                    " Privacy Policy",
                    style: TextStyle(
                        fontSize: 15,
                        // fontFamily: "Poppins",
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                        color: kBlack.withOpacity(0.8)),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(
          () => getInformationController.data.value != ""
              ? Padding(
                  padding: EdgeInsets.only(
                    top: mWidth * 0.02,
                    left: Get.width * 0.04,
                    right: Get.width * 0.04,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Html(data: getInformationController.data.value),
                        SizedBox(height: Get.height * 0.03),
                      ],
                    ),
                  ),
                )
              : Center(
                  child: getInformationController.infomsg.value != ""
                      ? Text(
                          getInformationController.infomsg.value,
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 0.7,
                              color: kBlack.withOpacity(0.8)),
                        )
                      : CircularProgressIndicator(
                          color: kSecondaryColor,
                        )),
        ),
      ),
    );
  }
}
