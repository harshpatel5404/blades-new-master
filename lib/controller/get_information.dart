import 'package:get/get.dart';

class GetInformationController extends GetxController {
  RxString data = "".obs;
  RxString infomsg = "".obs;
  // String get getAbout => aboutus.value;

  @override
  void onInit() {
    super.onInit();
    data.value = "";
  }
}
