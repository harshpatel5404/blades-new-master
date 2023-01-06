import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxString id = "".obs;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString contact = "".obs;
  RxString otherDetails = "".obs;
  RxString bio = "".obs;  
  RxString image = "".obs;
  RxBool isverified = false.obs;
}
