import 'package:blades/controller/video_page_controller.dart';
import 'package:blades/models/channel_model.dart';
import 'package:blades/models/video_model.dart';
import 'package:blades/screens/contact_us.dart';
import 'package:blades/utils/download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/utils/status_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share/share.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import '../controller/detail_video_controller.dart';
import '../services/api_services.dart';
import 'comment_screen.dart';

class VideoDetailPage extends StatefulWidget {
  final UploadContent content;
  const VideoDetailPage({Key? key, required this.content}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBlack,
         
          body: Stack(
            children: [
              VideoPage(
                videocontent: widget.content,
              ),
              Positioned(
                top: mHeight * 0.01,
                child: Container(
                  width: mWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                          height: mHeight * 0.06,
                          width: mHeight * 0.06,
                          child: Image.asset(
                            "assets/images/15logo.png",
                          )),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class VideoPage extends StatefulWidget {
  final UploadContent videocontent;
  const VideoPage({
    Key? key,
    required this.videocontent,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  DetailVideoController detailvideocontroller =
      Get.put(DetailVideoController());
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      "https://nodeserver.mydevfactory.com:3309/channelContent/${widget.videocontent.content}",
    );

    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.play();
    print("isliked ${detailvideocontroller.isLiked.value}");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print("isliked ${detailvideocontroller.isLiked.value}");

    detailvideocontroller.isLiked.value
        ? editContent(1, widget.videocontent.id, widget.videocontent.userID)
        : null;
  }

  bool isEnable = true;
  bool isbuttonvisible = false;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                isbuttonvisible = !isbuttonvisible;
                setState(() {});
              },
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: mHeight,
                      width: mWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: VideoPlayer(_controller),
                    ),
                    Container(
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withOpacity(0.8)
                          ],
                          begin: Alignment.center,
                          end: Alignment.bottomCenter,
                          stops: [0, 0, 0, 1],
                        ),
                      ),
                    ),
                    isbuttonvisible
                        ? FadeIn(
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: mWidth * 0.12,
                                  left: mWidth * 0.04,
                                  right: mWidth * 0.06,
                                  bottom: mHeight * 0.05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // const SizedBox(
                                  //   height: 10,
                                  // ),
                                  MaterialButton(
                                      shape: const CircleBorder(),
                                      color: Colors.white,
                                      padding: const EdgeInsets.all(10),
                                      onPressed: () {
                                        setState(() {
                                          _controller.value.isPlaying
                                              ? _controller.pause()
                                              : _controller.play();
                                        });
                                      },
                                      child: _controller.value.isPlaying
                                          ? Icon(Icons.pause)
                                          : Icon(Icons.play_arrow)),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container(),
                    Obx(() => Positioned(
                          right: mWidth * 0.02,
                          bottom: mWidth * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      detailvideocontroller.isLiked.toggle();
                                    },
                                    child: Icon(
                                      Icons.favorite,
                                      size: 35,
                                      color: detailvideocontroller.isLiked.value
                                          ? Colors.red
                                          : Colors.white,
                                    ),
                                  ),
                                  // SizedBox(height: 3),
                                  Text(
                                    detailvideocontroller.isLiked.value
                                        ? (widget.videocontent.likes + 1)
                                            .toString()
                                        : widget.videocontent.likes.toString(),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 8),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(CommentScreen(
                                        contentId: widget.videocontent.id, userID: widget.videocontent.userID,
                                      ));
                                    },
                                    child: Icon(
                                      MdiIcons.comment,
                                      size: 35,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    widget.videocontent.comments
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ToastContext().init(context);
                                      Toast.show("Downloading...",
                                          duration: Toast.lengthLong,
                                          gravity: Toast.bottom);
                                      savegalleryFile(
                                              widget.videocontent.content)
                                          .whenComplete(() {
                                        Toast.show("Downloaded",
                                            gravity: Toast.bottom);
                                      });
                                    },
                                    child: Icon(
                                      MdiIcons.downloadCircle,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   "12",
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     color: Colors.white,
                                  //   ),
                                  // )
                                ],
                              ),
                              SizedBox(height: 5),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ToastContext().init(context);
                                      Toast.show("Please Wait...",
                                          duration: Toast.lengthLong,
                                          gravity: Toast.bottom);
                                      savegalleryFile(
                                              widget.videocontent.content)
                                          .then((value) async {
                                        await Share.shareFiles(
                                          [value],
                                        );
                                      });
                                    },
                                    child: Icon(
                                      MdiIcons.share,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // SizedBox(height: 3),
                                  // Text(
                                  //   "12",
                                  //   style: TextStyle(
                                  //     fontSize: 18,
                                  //     color: Colors.white,
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        )),
                    Positioned(
                      bottom: mWidth * 0.05,
                      left: mWidth * 0.05,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   "Roman Reigns WWE",
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: const TextStyle(
                          //     fontSize: 17,
                          //     color: Colors.white,
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                          Text(
                            // "John Cena vs Roman Reigns Match Short Video. Please Like this video.",
                            widget.videocontent.contentTitle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: kWhite,
              child: Center(
                child: Lottie.asset('assets/loader.json',
                    height: mWidth * 0.2,
                    width: mWidth * 0.2,
                    fit: BoxFit.cover),
              ),
            );
          }
        });
  }
}
