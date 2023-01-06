import 'package:get/get.dart';

class DetailVideoController extends GetxController {
  RxBool isLiked = false.obs;

  @override
  void onInit() {
    isLiked.value = false;
    super.onInit();
  }
}
