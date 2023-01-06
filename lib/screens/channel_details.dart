import 'dart:convert';
import 'dart:io';
import 'package:blades/controller/channel_details_controller.dart';
import 'package:blades/screens/detail_video_page.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/filter_dialog.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:blades/widgets/bottom_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readmore/readmore.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../controller/grid_controller.dart';

class ChannelDetails extends StatefulWidget {
  final String channelID;
  final String channelName;
  final String channelDesc;
  final String channelImg;

  const ChannelDetails(
      {Key? key,
      required this.channelID,
      required this.channelName,
      required this.channelDesc,
      required this.channelImg})
      : super(key: key);
  @override
  State<ChannelDetails> createState() => _ChannelDetailsState();
}

class _ChannelDetailsState extends State<ChannelDetails> {
  // GridController gridController = Get.put(GridController());
  ChannelDetailController channelDetailController =
      Get.put(ChannelDetailController());

  @override
  void initState() {
    super.initState();
    getContentByChannelId(widget.channelID);
  }

  Future getThumbnail(url) async {
    return await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 200,
      quality: 40,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: kWhite,
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(Get.height * 0.15), // here the desired height
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.04, vertical: Get.width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Card(
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9),
                              borderSide: const BorderSide(
                                  width: 0, color: Colors.white)),
                          elevation: 3.5,
                          child: Padding(
                              padding: EdgeInsets.all(Get.width * 0.02),
                              child: const Icon(Icons.arrow_back)),
                        ),
                      ),
                      Container(
                        height: mHeight * 0.07,
                        child: Image.asset(
                          "assets/icons/logo.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        width: Get.width * 0.12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.width * 0.02,
                  ),
                  Text(
                    " Channel Details",
                    style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.w500,
                        color: kBlack.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: channelDetailController.channelcontentList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.01),
                    child: Container(
                      width: mWidth,
                      height: mHeight,
                      color: kWhite,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Card(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      side: BorderSide(
                                          color: kSecondaryColor, width: 2),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        progressIndicatorBuilder:
                                            (context, url, progress) => Center(
                                          child: CircularProgressIndicator(
                                            color: kSecondaryColor,
                                            value: 0.5,
                                          ),
                                        ),
                                        imageUrl:
                                            "https://nodeserver.mydevfactory.com:3309/channelProfile/${widget.channelImg}",
                                        height: Get.width * 0.2,
                                        width: Get.width * 0.2,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: mWidth * 0.65,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        // "Jhon’s Medical Blog",
                                        widget.channelName,
                                        style: TextStyle(
                                            fontSize: 15.5,
                                            letterSpacing: 0.7,
                                            fontWeight: FontWeight.w600,
                                            color: kBlack.withOpacity(0.8)),
                                      ),
                                      ReadMoreText(
                                        widget.channelDesc,
                                        style: TextStyle(
                                          fontSize: 11.5,
                                          letterSpacing: 0.7,
                                          color: Colors.grey,
                                        ),
                                        trimLines: 3,
                                        colorClickableText: kSecondaryColor,
                                        trimMode: TrimMode.Line,
                                        trimCollapsedText: 'Readmore',
                                        trimExpandedText: 'Show less',
                                        moreStyle: TextStyle(
                                          fontSize: 11.5,
                                          letterSpacing: 0.7,
                                          fontWeight: FontWeight.w400,
                                          color: kSecondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 2.5,
                                      mainAxisSpacing: 2.5,
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.8),
                              itemCount: channelDetailController
                                  .channelcontentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                var contentdata = channelDetailController
                                    .channelcontentList[index];
                                var content =
                                    contentdata.content.split('.').last;
                                var url =
                                    "https://nodeserver.mydevfactory.com:3309/channelContent/${contentdata.content}";
                                if (content == "mp4") {
                                  return FutureBuilder(
                                      future: getThumbnail(url),
                                      builder: (context, snapshot) {
                                        if (snapshot.data != null) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(VideoDetailPage(
                                                  content: contentdata));
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  color: kWhite,
                                                  child: Center(
                                                    child: Image.file(
                                                      File(snapshot.data
                                                          .toString()),
                                                      fit: BoxFit.fill,
                                                      height: mHeight,
                                                      width: mWidth,
                                                    ),
                                                  ),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Align(
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: Text(
                                                          contentdata
                                                              .contentTitle,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              height: 1.2,
                                                              fontSize: 13.5,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: kWhite),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                        return Container(
                                          color: kBlack.withOpacity(0.4),
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      });
                                }
                                return Container(
                                  color: kBlack,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: kSecondaryColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    color: kWhite,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
