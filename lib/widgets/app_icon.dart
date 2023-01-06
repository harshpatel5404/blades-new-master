import 'package:blades/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppIcon extends StatelessWidget {
  final String icon;
  const AppIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
          borderSide: const BorderSide(width: 0, color: Colors.white)),
      elevation: 3.5,
      child: Padding(
        padding: EdgeInsets.all(Get.width * 0.03),
        child: SvgPicture.asset(
          "assets/icons/$icon.svg",
          height: mWidth * 0.05,
          width: mWidth * 0.05,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
