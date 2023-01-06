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

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  void initState() {
    super.initState();
    // AppHelper.setStatusbar();
  }

  bool thisindexExpanded = false;
  int currentIndex = 0;

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
                    " FAQ",
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
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return SizedBox(
                height: mHeight * 0.01,
              );
            },
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: kWhite,
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 0, color: Colors.white)),
                child: Theme(
                  data: ThemeData(
                          fontFamily: 'Poppins',
                          iconTheme: IconThemeData(color: kBlack))
                      .copyWith(
                    dividerColor: Colors.transparent,
                  ),
                  child: ExpansionTile(
                    onExpansionChanged: (value) {
                      thisindexExpanded = value;
                      currentIndex = index;
                      setState(() {});
                    },
                    collapsedIconColor: kBlack,
                    iconColor: kBlack,
                    trailing: thisindexExpanded && currentIndex == index
                        ? Container(
                            height: mWidth * 0.13,
                            width: mWidth * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffc1f3e8)),
                            child: Icon(Icons.expand_less))
                        : Container(
                            height: mWidth * 0.13,
                            width: mWidth * 0.13,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffc1f3e8)),
                            child: Icon(Icons.expand_more)),
                    title: Text(
                      "What is Lorem Ipsum?",
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color(0xff31D3B2),
                          fontWeight: FontWeight.w500),
                    ),
                    children: [
                      Divider(
                        color: Colors.grey.shade300,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: mWidth * 0.04),
                        child: ListTile(
                          title: Text(
                            "From its medieval origins to the digital era, learn everything there is to know about the ubiquitous lorem ipsum passage.",
                            textAlign: TextAlign.justify,
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
