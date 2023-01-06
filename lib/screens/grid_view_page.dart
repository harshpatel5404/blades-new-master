import 'dart:convert';
import 'dart:io';
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

class GridViewVideo extends StatefulWidget {
  final String contentId;
  const GridViewVideo({Key? key, required this.contentId}) : super(key: key);
  @override
  State<GridViewVideo> createState() => _GridViewVideoState();
}

class _GridViewVideoState extends State<GridViewVideo> {
  GridController gridController = Get.put(GridController());

  @override
  void initState() {
    super.initState();
    getContentByChannel(widget.contentId);
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
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: gridController.gridcontentList.isNotEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: mHeight * 0.12),
                    child: Container(
                      width: mWidth,
                      height: mHeight,
                      color: kWhite,
                      child: GridView.builder(
                        shrinkWrap: true,
                        // reverse: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 2.5,
                                mainAxisSpacing: 2.5,
                                crossAxisCount: 3,
                                childAspectRatio: 0.8),
                        itemCount: gridController.gridcontentList.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          var contentdata =
                              gridController.gridcontentList[index];
                          var content = contentdata.content.split('.').last;
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
                                                File(snapshot.data.toString()),
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
                                                padding: EdgeInsets.all(10.0),
                                                child: Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Text(
                                                    contentdata.contentTitle,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        height: 1.2,
                                                        fontSize: 13.5,
                                                        fontWeight:
                                                            FontWeight.w500,
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
