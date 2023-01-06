import 'package:blades/screens/notifications.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/filter_dialog.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/app_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();

    // AppHelper.setStatusbar();
  }

  List<String> notitext = [
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
    "Lorem ipsum dolor sit amet, adipiscing elit. Cras cursus...",
  ];
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
                      height: mHeight * 0.07,
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
                    " Notifications",
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
        body: Padding(
          padding: EdgeInsets.only(
              top: mWidth * 0.02, left: mWidth * 0.04, right: mWidth * 0.04),
          child: Column(
            children: [
              Expanded(
                // height: Get.height * 0.8,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: notitext.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index % 2 != 0) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xffCAE9F6),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.03,
                                vertical: Get.width * 0.05),
                            child: Text(
                              notitext[index],
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                        ),
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Card(
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(width: 0, color: Colors.white)),
                        elevation: 5,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.03,
                              vertical: Get.width * 0.05),
                          child: Text(
                            notitext[index],
                            style: TextStyle(fontSize: 15, color: textcolor),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
