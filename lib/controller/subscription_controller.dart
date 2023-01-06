import 'package:get/get.dart';

import '../models/subscription_model.dart';

class SubscriptionController extends GetxController {
  RxBool isloading = false.obs;
  RxInt currentIndex = 0.obs;
  RxList<Subscription> subsctiptionList = <Subscription>[].obs;

  RxString subscriptionmsg =
      "Your free subscription will expire after 60 days".obs;
}
