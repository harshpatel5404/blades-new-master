import 'package:blades/models/channel_model.dart';
import 'package:get/get.dart';

class ChannelController extends GetxController {
  RxString isChannelmsg = "".obs;
  RxString contentmsg = "".obs;
  RxBool isChannel = false.obs;
  RxBool  isSearch = false.obs;
  RxList<ChannelList> channelList = <ChannelList>[].obs;
  RxList<UploadContent> contentList = <UploadContent>[].obs;
  RxList<UploadContent> searchlist = <UploadContent>[].obs;
  RxInt isSelectedFilter = 10.obs;
}
