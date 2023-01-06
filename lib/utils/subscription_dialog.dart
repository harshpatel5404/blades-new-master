import 'dart:ui';

import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dimentions.dart';

Future subsctiptionDialog(context) {
  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.8),
    builder: (ctx) => Dialog(
      child: Container(
        height: mHeight * 0.35,
        width: mWidth * 0.8,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 10,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Card(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xffF1EFEF))),
                  elevation: 0,
                  child: Padding(
                    padding: EdgeInsets.all(Get.width * 0.01),
                    child: Icon(
                      Icons.close,
                      color: Color(0xffF1EFEF),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    "assets/images/subscription.png",
                    height: mWidth * 0.2,
                    width: mWidth * 0.2,
                  ),
                  Center(
                    child: Text(
                      "Please Upgrade your subscription.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kSecondaryColor, fontSize: 16),
                    ),
                  ),
                  AppButton(
                    onpress: () {
                      Get.back();
                    },
                    btntext: 'Ok',
                    btnfontsize: 13.5,
                    widths: mWidth * 0.4,
                    heights: mHeight * 0.06,
                    textcolor: Colors.white,
                    btncolor: kSecondaryColor,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
