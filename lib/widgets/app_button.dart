import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatefulWidget {
  final VoidCallback onpress;
  final widths;
  final heights;
  final btnfontsize;
  final String btntext;
  final Color textcolor;
  var bordercolor;
  final Color btncolor;

  AppButton(
      {Key? key,
      this.widths,
      required this.onpress,
      required this.btntext,
      this.btnfontsize,
      required this.textcolor,
      required this.btncolor,
      this.heights,
      this.bordercolor})
      : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.widths ?? double.infinity,
      height: widget.heights ?? Get.height * 0.05,
      child: TextButton(
        onPressed: widget.onpress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(widget.btncolor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: widget.bordercolor ?? widget.btncolor)),
          ),
        ),
        child: Text(
          widget.btntext,
          style: TextStyle(
              color: widget.textcolor,
              fontSize: widget.btnfontsize ?? 18,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
