import 'package:blades/utils/colors.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeactivateScreen extends StatefulWidget {
  const DeactivateScreen({Key? key}) : super(key: key);

  @override
  State<DeactivateScreen> createState() => _DeactivateScreenState();
}

class _DeactivateScreenState extends State<DeactivateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "You are not activated.",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, color: kBlack),
      )),
    );
  }
}
