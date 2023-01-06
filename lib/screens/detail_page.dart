// import 'package:blades/controller/video_page_controller.dart';
// import 'package:blades/models/video_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:blades/utils/colors.dart';
// import 'package:blades/utils/dimentions.dart';
// import 'package:blades/utils/status_bar.dart';
// import 'package:video_player/video_player.dart';

// import 'comment_screen.dart';

// class DetailPage extends StatefulWidget {
//   const DetailPage({Key? key}) : super(key: key);

//   @override
//   _DetailPageState createState() => _DetailPageState();
// }

// class _DetailPageState extends State<DetailPage> {
//   @override
//   void initState() {
//     super.initState();
//     AppHelper.setStatusbar();
//   }

//   VideoPageController videoPageController = Get.put(VideoPageController());
//   PageController pageController = PageController();
//   List videoUrls = [
//     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4",
//     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
//     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4"
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: PreferredSize(
//           preferredSize:
//               Size.fromHeight(Get.height * 0.12), // here the desired height
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Card(
//                         shape: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(9),
//                             borderSide: const BorderSide(
//                                 width: 0, color: Colors.white)),
//                         elevation: 3.5,
//                         child: Padding(
//                             padding: EdgeInsets.all(Get.width * 0.02),
//                             child: const Icon(Icons.arrow_back)),
//                       ),
//                     ),
//                     Container(
//                       height: mHeight * 0.07,
//                       child: Image.asset(
//                         "assets/icons/logo.png",
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                     SizedBox(
//                       width: Get.width * 0.12,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//         body: StreamBuilder<List<Video>>(
//           stream: videoPageController.getvideo(),
//           builder: (BuildContext context, AsyncSnapshot<List<Video>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(
//                   color: kSecondaryColor,
//                 ),
//               );
//             }
//             if (snapshot.data != null) {
//               return PageView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: snapshot.data!.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var url = snapshot.data![index].sources;
//                   var title = snapshot.data![index].title;
//                   return VideoPage(
//                     url: url,
//                     title: title,
//                   );
//                 },
//               );
//             }
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: kSecondaryColor,
//               ),
//             );
//           },
//         ),

//         //  PageView(
//         //  PageView(
//         //  PageView(
//         //   controller: pageController,
//         //   onPageChanged: (val) {},
//         //   scrollDirection: Axis.vertical,
//         //   children: videoUrls
//         //       .map((url) => VideoPage(
//         //             url: url,
//         //           ))
//         //       .toList(),
//         // ),
//       ),
//     );
//   }
// }

// class VideoPage extends StatefulWidget {
//   final String url;
//   final String title;
//   const VideoPage({
//     Key? key,
//     required this.url,
//     required this.title,
//   }) : super(key: key);

//   @override
//   State<VideoPage> createState() => _VideoPageState();
// }

// class _VideoPageState extends State<VideoPage> {
//   late VideoPlayerController videoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     videoPlayerController = VideoPlayerController.network(
//       widget.url,
//     )..initialize().then((value) {
//         setState(() {
//           videoPlayerController.play();
//           videoPlayerController.setLooping(true);
//         });
//       });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     videoPlayerController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       alignment: Alignment.center,
//       children: [
//         Container(
//           color: kBlack,
//         ),
//         Container(
//           height: mHeight,
//           width: mWidth,
//           margin: EdgeInsets.only(
//             top: mWidth * 0.04,
//             left: mWidth * 0.03,
//             right: mWidth * 0.1,
//           ),
//           // foregroundDecoration: const BoxDecoration(
//           //   gradient: LinearGradient(
//           //     colors: [
//           //       Colors.black,
//           //       Colors.transparent,
//           //       Colors.transparent,
//           //       Colors.black
//           //     ],
//           //     begin: Alignment.topCenter,
//           //     end: Alignment.bottomCenter,
//           //     stops: [0, 0, 0, 1],
//           //   ),
//           //   // borderRadius: BorderRadius.circular(10),
//           // ),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             // image: DecorationImage(
//             //   image: AssetImage(
//             //     "assets/images/img.png",
//             //   ),
//             //   fit: BoxFit.fitHeight,
//             // ),
//           ),
//           child: VideoPlayer(videoPlayerController),
//         ),
//         Padding(
//           padding: EdgeInsets.only(
//               top: mWidth * 0.12,
//               left: mWidth * 0.04,
//               right: mWidth * 0.06,
//               bottom: mHeight * 0.05),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 10,
//               ),
//               InkWell(
//                 onTap: () {
//                   setState(() {
//                     videoPlayerController.value.isPlaying
//                         ? videoPlayerController.pause()
//                         : videoPlayerController.play();
//                   });
//                 },
//                 child: videoPlayerController.value.isPlaying
//                     ? const Icon(Icons.pause)
//                     : Container(
//                         height: mWidth * 0.15,
//                         width: mWidth * 0.15,
//                         decoration: const BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: const Color(0xff2ACDA7),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(15.0),
//                           child: SvgPicture.asset(
//                             "assets/icons/img.svg",
//                           ),
//                         ),
//                       ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0),
//                 child: Text(
//                   widget.title,
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                       height: 1.2,
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: kWhite),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           right: mWidth * 0.02,
//           bottom: mWidth * 0.4,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Column(
//                 children: [
//                   InkWell(
//                     onTap: () {},
//                     child: SvgPicture.asset(
//                       "assets/icons/download.svg",
//                       height: mWidth * 0.045,
//                       width: mWidth * 0.045,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                   SizedBox(
//                     height: mHeight * 0.04,
//                   )
//                 ],
//               ),
//               Column(
//                 children: [
//                   InkWell(
//                     onTap: () {},
//                     child: Image.asset(
//                       "assets/icons/share.png",
//                       height: mWidth * 0.065,
//                       width: mWidth * 0.065,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 6,
//                   )
//                 ],
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: mWidth * 0.06),
//                 child: Column(
//                   children: [
//                     InkWell(
//                       onTap: () {},
//                       child: SvgPicture.asset(
//                         "assets/icons/like.svg",
//                         height: mWidth * 0.05,
//                         width: mWidth * 0.05,
//                         fit: BoxFit.fitHeight,
//                       ),
//                     ),
//                     const Text(
//                       "1k",
//                       overflow: TextOverflow.ellipsis,
//                       style: TextStyle(
//                           fontSize: 10,
//                           fontWeight: FontWeight.w400,
//                           color: kWhite),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                        Get.to(CommentScreen());
//                     },
//                     child: SvgPicture.asset(
//                       "assets/icons/comment.svg",
//                       height: mWidth * 0.045,
//                       width: mWidth * 0.045,
//                       fit: BoxFit.fitHeight,
//                     ),
//                   ),
//                   const Text(
//                     "121",
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                         fontSize: 10,
//                         fontWeight: FontWeight.w400,
//                         color: kWhite),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         // BottomBar(
//         //   onTapIndex: 0,
//         // )
//       ],
//     );
//   }
// }
