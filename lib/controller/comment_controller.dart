import 'package:blades/models/comment_model.dart';
import 'package:get/get.dart';

class CommentController extends GetxController {
  // RxList commentList = [].obs;

  RxList<CommentDatum> commentdataList = <CommentDatum>[].obs;
  RxString commentMsg = "".obs;
}
