import 'dart:async';

import 'package:blades/controller/subscription_controller.dart';
import 'package:blades/models/subscription_model.dart';
import 'package:blades/screens/notifications.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/filter_dialog.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:blades/widgets/app_icon.dart';
import 'package:blades/widgets/bottom_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  List carouselSliderList = [
    {"title": "Premium"},
    {"title": "Gold"},
  ];
  PageController controller = PageController(viewportFraction: 0.9);
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  Timer? subTimer;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AppHelper.setStatusbar();
      getSubscriptionDetails();
      Timer.periodic(Duration(seconds: 3), ((timer) {
        getSubscriptionDetails().whenComplete(() {
          subscriptionController.isloading.value = false;
        });
      }));
    });
  }

  ScrollController scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    controller.dispose();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(Get.height * 0.13), // here the desired height
            child: Padding(
              padding: EdgeInsets.only(
                  left: Get.width * 0.04,
                  right: Get.width * 0.04,
                  top: Get.width * 0.03),
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
                  Text(
                    " Subscription",
                    style: TextStyle(
                        fontSize: 15,
                        // fontFamily: "Poppins",
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                        color: kBlack.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                    padding: EdgeInsets.only(
                        top: mWidth * 0.02,
                        left: mWidth * 0.04,
                        right: mWidth * 0.04),
                    child:
                        subscriptionController.subscriptionmsg.value != ""
                            ? Container(
                                width: mWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: const Color(0xffBFDEEC)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.03,
                                      vertical: Get.width * 0.04),
                                  child: Text(
                                    // "Your paid subscription will expire on 15 August 2022",
                                    subscriptionController
                                        .subscriptionmsg.value,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff3981A1)),
                                  ),
                                ),
                              )
                            : Container()),
                SizedBox(
                  height: mHeight * 0.02,
                ),
                subscriptionController.subsctiptionList.isNotEmpty
                    ? Column(
                        children: [
                          Text(
                            "   Current Plan",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.7,
                                fontWeight: FontWeight.w500,
                                color: kBlack.withOpacity(0.9)),
                          ),
                          SizedBox(
                            height: mHeight * 0.02,
                          ),
                          SizedBox(
                            height: mHeight * 0.45,
                            child: ListView.builder(
                              shrinkWrap: true,
                              controller: scrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: subscriptionController
                                  .subsctiptionList.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                var data = subscriptionController
                                    .subsctiptionList[index];
                                return Padding(
                                  padding: const EdgeInsets.only(
                                    right: 6.0,
                                    left: 6.0,
                                  ),
                                  child: Container(
                                    height: mHeight * 0.45,
                                    width: Get.width * 0.88,
                                    decoration: BoxDecoration(
                                        color: kWhite,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          data.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              letterSpacing: 0.7,
                                              fontWeight: FontWeight.bold,
                                              color: kBlack),
                                        ),
                                        Text(
                                          // "\$4.59/mo",
                                          "\$${data.cost}/mo",
                                          style: TextStyle(
                                              fontSize: mWidth * 0.1,
                                              letterSpacing: 0.7,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  const Color(0xff5990AA)),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  data.features.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var featureText =
                                                    data.features[index];
                                                return Container(
                                                  width: mWidth * 0.75,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: mWidth * 0.1,
                                                      ),
                                                      const Icon(Icons.star,
                                                          size: 18,
                                                          color: Color(
                                                              0xff5990AA)),
                                                      Text(
                                                        featureText,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            letterSpacing:
                                                                0.7,
                                                            color: Color(
                                                                0xff636363)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: mWidth * 0.03,
                                              horizontal: mWidth * 0.03),
                                          child: AppButton(
                                            onpress: () {
                                              addSubscription(data.id)
                                                  .whenComplete(() {
                                                getSubscriptionBYId();
                                              });
                                            },
                                            btntext: "Get Subscription",
                                            textcolor:
                                                const Color(0xffF4FAFF),
                                            btncolor: kSecondaryColor,
                                            heights: mHeight * 0.07,
                                            btnfontsize: 15.0,
                                            widths: mWidth,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: mHeight * 0.03,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  subscriptionController
                                      .currentIndex.value--;
                                  if (subscriptionController
                                          .currentIndex.value <=
                                      0) {
                                    subscriptionController
                                        .currentIndex.value = 0;
                                  }

                                  final contentSize = scrollController
                                          .position.viewportDimension +
                                      scrollController
                                          .position.maxScrollExtent;
                                  final target = contentSize *
                                      subscriptionController
                                          .currentIndex.value /
                                      subscriptionController
                                          .subsctiptionList.length;
                                  scrollController.position.animateTo(
                                    target,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Card(
                                  shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: kSecondaryColor)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.all(Get.width * 0.02),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                        color: kSecondaryColor,
                                      )),
                                ),
                              ),
                              const SizedBox(),
                              InkWell(
                                onTap: () {
                                  subscriptionController
                                      .currentIndex.value++;
                                  if (subscriptionController
                                          .subsctiptionList.length <
                                      subscriptionController
                                          .currentIndex.value) {
                                    subscriptionController
                                            .currentIndex.value =
                                        subscriptionController
                                            .subsctiptionList.length;
                                  }
                                  final contentSize = scrollController
                                          .position.viewportDimension +
                                      scrollController
                                          .position.maxScrollExtent;
                                  final target = contentSize *
                                      subscriptionController
                                          .currentIndex.value /
                                      subscriptionController
                                          .subsctiptionList.length;
                                  scrollController.position.animateTo(
                                    target,
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Card(
                                  shape: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          width: 1,
                                          color: kSecondaryColor)),
                                  child: Padding(
                                      padding:
                                          EdgeInsets.all(Get.width * 0.02),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        size: 30,
                                        color: kSecondaryColor,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    : subscriptionController.isloading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: kSecondaryColor,
                            ),
                          )
                        : Center(child: Text("Subscription not available"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
