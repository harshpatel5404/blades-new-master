import 'package:blades/controller/video_page_controller.dart';
import 'package:blades/models/channel_model.dart';
import 'package:blades/utils/download.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

import 'comment_screen.dart';

class ImageDetailPage extends StatefulWidget {
  final dynamic content;
  const ImageDetailPage({Key? key, required this.content}) : super(key: key);

  @override
  _ImageDetailPageState createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  @override
  void initState() {
    super.initState();
    AppHelper.setStatusbar();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Get.height * 0.12), // here the desired height
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
              ],
            ),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              color: kBlack,
            ),
            Container(
              height: mHeight,
              width: mWidth,
              margin: EdgeInsets.only(
                top: mWidth * 0.04,
                left: mWidth * 0.03,
                right: mWidth * 0.1,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FancyShimmerImage(
                  imageUrl:
                      "https://nodeserver.mydevfactory.com:3309/channelContent/${widget.content.content}",
                  boxFit: BoxFit.fill,
                  shimmerBackColor: Colors.black,
                  shimmerBaseColor: Colors.black54,
                  shimmerHighlightColor: Colors.white38,
                ),
              ),
            ),

            // Padding(
            //   padding: EdgeInsets.only(
            //       top: mWidth * 0.12,
            //       left: mWidth * 0.04,
            //       right: mWidth * 0.06,
            //       bottom: mHeight * 0.05),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Padding(
            //         padding: EdgeInsets.all(10.0),
            //         child: Text(
            //           widget.content.contentDescription,
            //           maxLines: 2,
            //           overflow: TextOverflow.ellipsis,
            //           style: TextStyle(
            //               height: 1.2,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: kWhite),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Positioned(
              right: mWidth * 0.02,
              bottom: mWidth * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          ToastContext().init(context);
                          Toast.show("Downloading...",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                          savegalleryFile(widget.content.content)
                              .whenComplete(() {
                            Toast.show("Downloaded", gravity: Toast.bottom);
                          });
                        },
                        child: SvgPicture.asset(
                          "assets/icons/download.svg",
                          height: mWidth * 0.045,
                          width: mWidth * 0.045,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        height: mHeight * 0.04,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () async {
                          ToastContext().init(context);
                          Toast.show("Please wait...",
                              duration: Toast.lengthLong,
                              gravity: Toast.bottom);
                          await saveimgpath(widget.content.content)
                              .then((path) async {
                            await Share.shareFiles([path]);
                          });
                        },
                        child: Image.asset(
                          "assets/icons/share.png",
                          height: mWidth * 0.065,
                          width: mWidth * 0.065,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: mWidth * 0.06),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/icons/like.svg",
                            height: mWidth * 0.05,
                            width: mWidth * 0.05,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        const Text(
                          "1k",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: kWhite),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                        },
                        child: SvgPicture.asset(
                          "assets/icons/comment.svg",
                          height: mWidth * 0.045,
                          width: mWidth * 0.045,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      const Text(
                        "0",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: kWhite),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // BottomBar(
            //   onTapIndex: 0,
            // )
          ],
        ),
      ),
    );
  }
}
