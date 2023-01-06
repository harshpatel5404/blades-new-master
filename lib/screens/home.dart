import 'package:blades/controller/home_controller.dart';
import 'package:blades/controller/profile_controller.dart';
import 'package:blades/controller/subscription_controller.dart';
import 'package:blades/screens/deactivated_screen.dart';
import 'package:blades/screens/notifications.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/filter_dialog.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/app_drawer.dart';
import 'package:blades/widgets/app_icon.dart';
import 'package:blades/widgets/bottom_bar.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vimeo_player_flutter/vimeo_player_flutter.dart';
import '../utils/deactivated_dialog.dart';
import 'comment_screen.dart';
import 'detail_image_page.dart';
import 'detail_video_page.dart';
import 'pageview_video.dart';
import 'sign_in_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  ProfileController profileController = Get.put(ProfileController());
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  HomeController homeController = Get.put(HomeController());
  TextEditingController searchController = TextEditingController(text: "");
  ScrollController scrollController =
      ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      
      Get.offAll(PageViewVideo());
      getContent().whenComplete(() {
        homeController.ishomeContent.value = false;
      });
      getProfileDetails().whenComplete(() {
        // if (!profileController.isverified.value) {
        //   Get.offAll(DeactivateScreen());
        // }
      });
      getChannelDetails();
      getSubscriptionBYId();
      // scrollController.addListener(() {
      //   if (scrollController.position.pixels == 0) {
      //     homeController.isWhite.value = true;
      //   } else if (scrollController.position.pixels >= Get.height * 0.12) {
      //     homeController.isWhite.value = false;
      //   }
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kBlack,
          key: scaffoldkey,
          // drawer: AppDrawer(drawerkey: scaffoldkey),
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(Get.height * 0.17),
          //   child: Container(
          //     color: Colors.black,
          //     child: Padding(
          //       padding: EdgeInsets.only(
          //         top: mWidth * 0.04,
          //         left: mWidth * 0.04,
          //         right: mWidth * 0.04,
          //         bottom: mWidth * 0.035,
          //       ),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           InkWell(
          //             onTap: () {
          //               scaffoldkey.currentState!.openDrawer();
          //             },
          //             child: SizedBox(
          //                 height: mHeight * 0.06,
          //                 width: mHeight * 0.06,
          //                 child: Image.asset(
          //                   "assets/images/15logo.png",
          //                 )),
          //           ),
          //           InkWell(
          //             onTap: () {
          //               Get.to(const NotificationScreen());
          //             },
          //             child: const AppIcon(
          //               icon: 'notification',
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // body: SingleChildScrollView(
          //   controller: scrollController,
          //   child: Container(
          //     color: Colors.black,
          //     child: Column(
          //       children: [
          //         SizedBox(
          //           height: mHeight * 0.02,
          //         ),
          //         homeController.homecontentList.isNotEmpty
          //             ? Column(
          //                 crossAxisAlignment: CrossAxisAlignment.center,
          //                 children: [
          //                   Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     crossAxisAlignment: CrossAxisAlignment.center,
          //                     children: [
          //                       Padding(
          //                         padding: EdgeInsets.only(
          //                             left: mWidth * 0.04,
          //                             right: mWidth * 0.04),
          //                         child: Container(
          //                           width: mWidth * 0.75,
          //                           height: Get.height * 0.065,
          //                           decoration: BoxDecoration(
          //                             color: kWhite,
          //                             borderRadius: BorderRadius.circular(10),
          //                             boxShadow: [
          //                               BoxShadow(
          //                                 blurRadius: 10,
          //                                 color: Colors.grey.withOpacity(0.3),
          //                                 spreadRadius: 1,
          //                               )
          //                             ],
          //                           ),
          //                           constraints: BoxConstraints(
          //                               maxHeight: Get.height * 0.065,
          //                               maxWidth: mWidth),
          //                           padding: EdgeInsets.only(
          //                             left: Get.width * 0.02,
          //                           ),
          //                           child: TextFormField(
          //                             cursorColor: kBlack,
          //                             controller: searchController,
          //                             onChanged: (val) {
          //                               if (searchController.text == "") {
          //                                 homeController.ishomeSearch.value =
          //                                     false;
          //                                 homeController.homesearchlist.clear();
          //                               } else {
          //                                 homeController.ishomeSearch.value =
          //                                     true;
          //                                 homeController.homesearchlist.clear();
          //                                 homeController.homecontentList
          //                                     .forEach((e) {
          //                                   e.contentTitle
          //                                           .toString()
          //                                           .toLowerCase()
          //                                           .contains(searchController
          //                                               .text
          //                                               .toLowerCase())
          //                                       ? homeController.homesearchlist
          //                                           .add(e)
          //                                       : null;
          //                                 });
          //                               }
          //                               print(homeController.homesearchlist);
          //                             },
          //                             decoration: const InputDecoration(
          //                                 prefixIcon: Icon(
          //                                   Icons.search_rounded,
          //                                   color: Color(0xFF859CA6),
          //                                 ),
          //                                 hintText: "Search ",
          //                                 hintStyle: TextStyle(
          //                                     fontSize: 14,
          //                                     color: Color(0xFF859CA6),
          //                                     fontFamily: "Poppins"),
          //                                 filled: true,
          //                                 contentPadding: EdgeInsets.all(15),
          //                                 fillColor: kWhite,
          //                                 focusedBorder: OutlineInputBorder(
          //                                     borderSide: BorderSide(
          //                                         color: kWhite, width: 0),
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(10))),
          //                                 enabledBorder: OutlineInputBorder(
          //                                     borderSide: BorderSide(
          //                                         color: kWhite, width: 0),
          //                                     borderRadius: BorderRadius.all(
          //                                         Radius.circular(10)))),
          //                           ),
          //                         ),
          //                       ),
          //                       InkWell(
          //                         onTap: () {
          //                           homefilterDialog(context);
          //                         },
          //                         child: Stack(
          //                           children: [
          //                             Container(
          //                               decoration: BoxDecoration(
          //                                 color: kWhite,
          //                                 borderRadius:
          //                                     BorderRadius.circular(10),
          //                                 boxShadow: [
          //                                   BoxShadow(
          //                                     blurRadius: 10,
          //                                     color:
          //                                         Colors.grey.withOpacity(0.3),
          //                                     spreadRadius: 1,
          //                                   )
          //                                 ],
          //                               ),
          //                               child: Padding(
          //                                 padding:
          //                                     EdgeInsets.all(Get.width * 0.035),
          //                                 child: SvgPicture.asset(
          //                                   "assets/icons/filter.svg",
          //                                   height: mWidth * 0.06,
          //                                   width: mWidth * 0.06,
          //                                   fit: BoxFit.fitHeight,
          //                                 ),
          //                               ),
          //                             ),
          //                             homeController
          //                                         .ishomeSelectedFilter.value !=
          //                                     10
          //                                 ? Positioned(
          //                                     right: mWidth * 0.02,
          //                                     top: mWidth * 0.018,
          //                                     child: Container(
          //                                       width: mWidth * 0.03,
          //                                       height: mWidth * 0.03,
          //                                       decoration: BoxDecoration(
          //                                         color: kSecondaryColor,
          //                                         shape: BoxShape.circle,
          //                                       ),
          //                                     ),
          //                                   )
          //                                 : Container(),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                   // SizedBox(
          //                   //   height: mHeight * 0.01,
          //                   // ),
          //                   Container(
          //                     width: mWidth,
          //                     color: Colors.black,
          //                     child: ListView.separated(
          //                       shrinkWrap: true,
          //                       reverse: true,
          //                       physics: const NeverScrollableScrollPhysics(),
          //                       separatorBuilder: (context, index) {
          //                         return SizedBox(
          //                           height: mWidth * 0.01,
          //                         );
          //                       },
          //                       itemCount: homeController.ishomeSearch.value
          //                           ? homeController.homesearchlist.length
          //                           : homeController.homecontentList.length,
          //                       itemBuilder: (BuildContext context, int index) {
          //                         var contentdata = homeController
          //                                 .ishomeSearch.value
          //                             ? homeController.homesearchlist[index]
          //                             : homeController.homecontentList[index];
          //                         var content =
          //                             contentdata.content.split('.').last;
          //                         var url =
          //                             "https://nodeserver.mydevfactory.com:3309/channelContent/${contentdata.content}";
          //                         return InkWell(
          //                           onTap: () {
          //                             Get.to(PageViewVideo());
          //                             // if (content == "jpg" ||
          //                             //     content == "png") {
          //                             //   Get.to(ImageDetailPage(
          //                             //       content: contentdata));
          //                             // } else if (content == "mp4") {
          //                             //   Get.to(VideoDetailPage(
          //                             //     content: contentdata,
          //                             //   ));
          //                             // } else {}
          //                           },
          //                           child: Column(
          //                             children: [
          //                               Container(
          //                                 margin: EdgeInsets.only(
          //                                   left: mWidth * 0.04,
          //                                   right: mWidth * 0.02,
          //                                   top: mHeight * 0.02,
          //                                   bottom: mHeight * 0.005,
          //                                 ),
          //                                 padding: const EdgeInsets.all(1),
          //                                 height: mHeight * 0.27,
          //                                 width: mWidth * 0.9,
          //                                 decoration: BoxDecoration(
          //                                     color: kWhite,
          //                                     borderRadius:
          //                                         BorderRadius.circular(10),
          //                                     border: Border.all(
          //                                         color: kWhite, width: 0)),
          //                                 child: Stack(
          //                                   alignment: Alignment.center,
          //                                   children: [
          //                                     Container(
          //                                       height: mWidth,
          //                                       width: mWidth,
          //                                       foregroundDecoration:
          //                                           BoxDecoration(
          //                                         gradient:
          //                                             const LinearGradient(
          //                                           colors: [
          //                                             Colors.black,
          //                                             Colors.transparent,
          //                                             Colors.transparent,
          //                                             Colors.black
          //                                           ],
          //                                           begin: Alignment.topCenter,
          //                                           end: Alignment.bottomCenter,
          //                                           stops: [0, 0, 0, 1],
          //                                         ),
          //                                         borderRadius:
          //                                             BorderRadius.circular(10),
          //                                       ),
          //                                       child: ClipRRect(
          //                                         borderRadius:
          //                                             BorderRadius.circular(10),
          //                                         child: content == "jpg" ||
          //                                                 content == "png"
          //                                             ? FancyShimmerImage(
          //                                                 imageUrl: url,
          //                                                 boxFit: BoxFit.fill,
          //                                                 shimmerBackColor:
          //                                                     Colors.black,
          //                                                 shimmerBaseColor:
          //                                                     Colors.black54,
          //                                                 shimmerHighlightColor:
          //                                                     Colors.white38,
          //                                               )
          //                                             : Container(),
          //                                       ),
          //                                       // decoration: BoxDecoration(
          //                                     ),
          //                                     Container(
          //                                       height: mWidth * 0.11,
          //                                       width: mWidth * 0.11,
          //                                       decoration: const BoxDecoration(
          //                                         shape: BoxShape.circle,
          //                                         color: Color(0xff2ACDA7),
          //                                       ),
          //                                       child: Padding(
          //                                           padding:
          //                                               const EdgeInsets.all(
          //                                                   8.0),
          //                                           child: content == "jpg" ||
          //                                                   content == "png"
          //                                               ? SvgPicture.asset(
          //                                                   "assets/icons/img.svg",
          //                                                 )
          //                                               : SvgPicture.asset(
          //                                                   "assets/icons/video.svg",
          //                                                 )),
          //                                     ),
          //                                     Column(
          //                                       mainAxisAlignment:
          //                                           MainAxisAlignment.end,
          //                                       children: [
          //                                         Padding(
          //                                           padding:
          //                                               EdgeInsets.all(10.0),
          //                                           child: Align(
          //                                             alignment:
          //                                                 Alignment.topLeft,
          //                                             child: Text(
          //                                               contentdata
          //                                                   .contentTitle,
          //                                               maxLines: 2,
          //                                               overflow: TextOverflow
          //                                                   .ellipsis,
          //                                               textAlign:
          //                                                   TextAlign.start,
          //                                               style: TextStyle(
          //                                                   height: 1.2,
          //                                                   fontSize: 13.5,
          //                                                   fontWeight:
          //                                                       FontWeight.w500,
          //                                                   color: kWhite),
          //                                             ),
          //                                           ),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                               ),
          //                               Padding(
          //                                 padding: const EdgeInsets.symmetric(
          //                                     horizontal: 18.0),
          //                                 child: Container(
          //                                   width: mWidth * 0.45,
          //                                   child: Row(
          //                                     mainAxisAlignment:
          //                                         MainAxisAlignment
          //                                             .spaceBetween,
          //                                     children: [
          //                                       Column(
          //                                         children: [
          //                                           InkWell(
          //                                             onTap: () {},
          //                                             child: SvgPicture.asset(
          //                                               "assets/icons/download.svg",
          //                                               height: mWidth * 0.035,
          //                                               width: mWidth * 0.035,
          //                                               fit: BoxFit.fitHeight,
          //                                             ),
          //                                           ),
          //                                           const SizedBox(
          //                                             height: 10,
          //                                           )
          //                                         ],
          //                                       ),
          //                                       Column(
          //                                         children: [
          //                                           const SizedBox(
          //                                             height: 2,
          //                                           ),
          //                                           InkWell(
          //                                             onTap: () {},
          //                                             child: Image.asset(
          //                                               "assets/icons/share.png",
          //                                               height: mWidth * 0.045,
          //                                               width: mWidth * 0.045,
          //                                               fit: BoxFit.fitHeight,
          //                                             ),
          //                                           ),
          //                                           const SizedBox(
          //                                             height: 6,
          //                                           )
          //                                         ],
          //                                       ),
          //                                       Padding(
          //                                         padding: const EdgeInsets
          //                                             .symmetric(vertical: 6.0),
          //                                         child: Column(
          //                                           children: [
          //                                             InkWell(
          //                                               onTap: () {},
          //                                               child: SvgPicture.asset(
          //                                                 "assets/icons/like.svg",
          //                                                 height: mWidth * 0.04,
          //                                                 width: mWidth * 0.04,
          //                                                 fit: BoxFit.fitHeight,
          //                                               ),
          //                                             ),
          //                                             const Text(
          //                                               "1k",
          //                                               overflow: TextOverflow
          //                                                   .ellipsis,
          //                                               style: const TextStyle(
          //                                                   fontSize: 8,
          //                                                   fontWeight:
          //                                                       FontWeight.w400,
          //                                                   color: kWhite),
          //                                             ),
          //                                           ],
          //                                         ),
          //                                       ),
          //                                       Column(
          //                                         children: [
          //                                           InkWell(
          //                                             onTap: () {
          //                                               Get.to(CommentScreen());
          //                                             },
          //                                             child: SvgPicture.asset(
          //                                               "assets/icons/comment.svg",
          //                                               height: mWidth * 0.035,
          //                                               width: mWidth * 0.035,
          //                                               fit: BoxFit.fitHeight,
          //                                             ),
          //                                           ),
          //                                           const Text(
          //                                             "121",
          //                                             overflow:
          //                                                 TextOverflow.ellipsis,
          //                                             style: const TextStyle(
          //                                                 fontSize: 8,
          //                                                 fontWeight:
          //                                                     FontWeight.w400,
          //                                                 color: kWhite),
          //                                           ),
          //                                         ],
          //                                       ),
          //                                     ],
          //                                   ),
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   ),
          //                   homeController.ishomeSearch.value &&
          //                           homeController.homesearchlist.isEmpty
          //                       ? const Center(
          //                           child: Text("Search result not found"),
          //                         )
          //                       : Container(
          //                           color: kBlack,
          //                           // height: mHeight * 0.12,
          //                         ),
          //                 ],
          //               )
          //             : homeController.ishomeContent.value
          //                 ? Center(
          //                     child: CircularProgressIndicator(
          //                       color: kSecondaryColor,
          //                     ),
          //                   )
          //                 : const Center(
          //                     child: Text("Content is not available"),
          //                   ),
          //       ],
          //     ),
          //   ),
          // ),
      
      
        ),
      
    );
  }
}
