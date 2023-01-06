import 'package:blades/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/dimentions.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if (message.isNotEmpty) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: isError ? Colors.redAccent : kSecondaryColor,
      message: message,
      maxWidth: mWidth,
      duration: Duration(seconds: 3),
      snackStyle: SnackStyle.FLOATING,
      margin: EdgeInsets.all(10),
      borderRadius: 15,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    ));
  }
}
