import 'dart:io';
import 'dart:ui';
import 'package:blades/utils/colors.dart';
import 'package:blades/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dimentions.dart';

Future deactivatedDialog(context) {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
          onWillPop: () => Future.value(false),
          child: AlertDialog(
            actionsAlignment: MainAxisAlignment.center,
            alignment: Alignment.center,
            title: Align(
                alignment: Alignment.center,
                child: Text(
                  "You are not activated.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                )),
            content: SingleChildScrollView(
              child: Container(),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text("Ok"),
                onPressed: () {
                  // exit(0);
                  Get.back();
                },
              ),
            ],
          ));
    },
  );
}
