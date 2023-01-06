import 'package:blades/screens/add_card.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ManagePayment extends StatefulWidget {
  const ManagePayment({Key? key}) : super(key: key);

  @override
  State<ManagePayment> createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  @override
  void initState() {
    super.initState();

    // AppHelper.setStatusbar();
  }

  var ischecked = 0;

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
              top: mWidth * 0.02, left: mWidth * 0.04, right: mWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Credit/Debit Cards",
                style: TextStyle(
                    fontSize: 15,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.w500,
                    color: kBlack.withOpacity(0.9)),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 7.0),
                      child: Container(
                        height: Get.height * 0.22,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height * 0.19,
                              width: Get.width,
                              child: Card(
                                elevation: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: Get.width * 0.05,
                                    bottom: Get.width * 0.05,
                                    left: Get.width * 0.05,
                                    right: Get.width * 0.03,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            " John doe",
                                            style: TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 16,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              ischecked = index;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: Get.width * 0.08,
                                              width: Get.width * 0.08,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Card(
                                                elevation: 3,
                                                child: ischecked == index
                                                    ? Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(3.0),
                                                        child: SvgPicture.asset(
                                                          "assets/icons/mark.svg",
                                                          // color: kPrimaryColor,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        " XXXX  XXXX  XXXX  7895",
                                        style: TextStyle(
                                          color: Color(0xff8A8A8A),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Image.asset(
                                        "assets/images/card.png",
                                        height: Get.height * 0.05,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: Get. width * 0.05,
                              child: InkWell(
                                onTap: () {},
                                child: Card(
                                  shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(60),
                                      borderSide: BorderSide(
                                          width: 0, color: Colors.white)),
                                  elevation: 8,
                                  child: Padding(
                                      padding: EdgeInsets.all(Get.width * 0.04),
                                      child: SvgPicture.asset(
                                        "assets/icons/delete.svg",
                                        height: 20,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mWidth * 0.03, horizontal: mWidth * 0.03),
                  child: AppButton(
                    onpress: () {
                      Get.to(AddCardScreen());
                    },
                    btntext: "Add New Card",
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
