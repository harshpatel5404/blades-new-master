import 'package:blades/models/content_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  RxString ishomeChannelmsg = "".obs;
  RxString homecontentmsg = "".obs;
  RxBool ishomeContent = false.obs;
  RxBool ishomeSearch = false.obs;
  RxList<HomeUploadContent> homecontentList = <HomeUploadContent>[].obs;
  RxList<HomeUploadContent> homesearchlist = <HomeUploadContent>[].obs;
  RxInt ishomeSelectedFilter = 10.obs;
  RxBool isWhite = true.obs;
}
