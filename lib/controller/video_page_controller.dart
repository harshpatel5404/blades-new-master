import 'dart:async';
import 'dart:convert';

import 'package:blades/models/video_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// class VideoPageController extends GetxController {
//   StreamController streamController = StreamController();

//   final RxInt counter = 0.obs;
//   int get counters => counter.value;

//   Stream<List<Video>> getvideo() =>
//       Stream.periodic(const Duration(seconds: 2)).asyncMap((_) => getVideos());

//   Future<List<Video>> getVideos() async {
//     print("getvideo");
//     final jsondata = await rootBundle.loadString('assets/myvideos.json');
//     var data = VideoModel.fromJson(jsonDecode(jsondata));
//     List<Video> videolist = data.videos;
//     return videolist;
//   }
// }
