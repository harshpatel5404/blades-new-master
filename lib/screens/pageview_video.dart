import 'package:blades/controller/channel_controller.dart';
import 'package:blades/controller/detail_video_controller.dart';
import 'package:blades/controller/home_controller.dart';
import 'package:blades/models/channel_model.dart';
import 'package:blades/models/content_model.dart';
import 'package:blades/screens/channel_details.dart';
import 'package:blades/screens/create_channel.dart';
import 'package:blades/screens/grid_view_page.dart';
import 'package:blades/screens/search_page.dart';
import 'package:blades/screens/sign_in_page.dart';
import 'package:blades/screens/upload_content.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/download.dart';
import 'package:blades/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import 'package:get/get.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:get/get_navigation/src/routes/get_transition_mixin.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';
import 'comment_screen.dart';

class PageViewVideo extends StatefulWidget {
  const PageViewVideo({
    Key? key,
  }) : super(key: key);

  @override
  _PageViewVideoState createState() => _PageViewVideoState();
}

class _PageViewVideoState extends State<PageViewVideo> {
  ChannelController channelController = Get.put(ChannelController());
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  Future getpermission() async {
    await [
      Permission.camera,
      Permission.storage,
      Permission.microphone,
    ].request();
  }

  @override
  void initState() {
    super.initState();
    getContent().whenComplete(() {
      homeController.ishomeContent.value = false;
    });
    getProfileDetails().whenComplete(() {});
    getChannelDetails();
    getSubscriptionBYId();
    getpermission();
  }

  PageController pageController = PageController();
  TextEditingController searchController = TextEditingController(text: "");
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
            backgroundColor: kWhite,
            key: scaffoldkey,
            drawer: AppDrawer(drawerkey: scaffoldkey),
            body: Stack(
              children: [
                homeController.homecontentList.isNotEmpty
                    ? PageView.builder(
                        controller: pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: homeController.homecontentList.length,
                        itemBuilder: (context, index) {
                          var uploadcontent =
                              homeController.homecontentList[index];
                          return VideoPage(
                            videocontent: uploadcontent,
                            pageController: pageController,
                          );
                        },
                      )
                    : homeController.homecontentmsg.value == ""
                        ? Container(
                            color: kWhite,
                          )
                        : const Center(
                            child: Text(
                              "Content is not available",
                              style: TextStyle(color: kBlack),
                            ),
                          ),
                Positioned(
                  top: mHeight * 0.01,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: mWidth * 0.05),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            scaffoldkey.currentState!.openDrawer();
                          },
                          child: SizedBox(
                              height: mHeight * 0.06,
                              width: mHeight * 0.06,
                              child: Image.asset(
                                "assets/images/15logo.png",
                              )),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(SearchPage());
                          },
                          child: Container(
                            width: mWidth * 0.8,
                            height: Get.height * 0.065,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: BoxConstraints(
                                maxHeight: Get.height * 0.065,
                                maxWidth: mWidth),
                            padding: EdgeInsets.only(
                              left: Get.width * 0.02,
                            ),
                            child: TextFormField(
                              enabled: false,
                              cursorColor: kWhite,
                              style: TextStyle(color: Colors.white),
                              controller: searchController,
                              onChanged: (val) {},
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search_rounded,
                                  color: kWhite,
                                ),
                                hintText: "Search ",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: kWhite,
                                    fontFamily: "Poppins"),
                                filled: true,
                                contentPadding: EdgeInsets.all(15),
                                fillColor: Color.fromARGB(166, 46, 45, 45),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(166, 46, 45, 45),
                                        width: 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(166, 46, 45, 45),
                                        width: 0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final PageController pageController;
  final HomeUploadContent videocontent;
  const VideoPage({
    Key? key,
    required this.videocontent,
    required this.pageController,
  }) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  DetailVideoController detailvideocontroller =
      Get.put(DetailVideoController());
  PageController pagevideoController = PageController(initialPage: 1);

  @override
  void initState() {
    super.initState();
    print("content id is - ${widget.videocontent.id}");
    _controller = VideoPlayerController.network(
      "https://nodeserver.mydevfactory.com:3309/channelContent/${widget.videocontent.content}",
    );
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(false);
    _controller.play();
    print(widget.videocontent.channelProfileImage);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print("isliked ${detailvideocontroller.isLiked.value}");
    detailvideocontroller.isLiked.value
        ? editContent(1, widget.videocontent.id, widget.videocontent.userID)
        : null;
    detailvideocontroller.isLiked.value = false;
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
              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: PageView(
                  controller: pagevideoController,
                  onPageChanged: (value) {
                    _controller.pause();
                    setState(() {});
                  },
                  children: [
                    CommentScreen(
                      contentId: widget.videocontent.id,
                      userID: widget.videocontent.userID,
                      isHideAppbar: true,
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                isEnable = !isEnable;
                              });
                            },
                            child: Container(
                              height: mHeight,
                              width: mWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: VideoPlayer(_controller),
                            ),
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
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: mWidth * 0.12,
                                        left: mWidth * 0.04,
                                        right: mWidth * 0.06,
                                        bottom: mHeight * 0.05),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
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
                                    widget.videocontent.channelProfileImage !=
                                            ""
                                        ? GestureDetector(
                                            onTap: () {
                                              Get.to(ChannelDetails(
                                                channelID: widget
                                                    .videocontent.channelId,
                                                channelDesc: widget.videocontent
                                                    .channelDescription,
                                                channelName: widget
                                                    .videocontent.channelTitle,
                                                channelImg: widget.videocontent
                                                    .channelProfileImage,
                                              ));
                                            },
                                            child: CircleAvatar(
                                                radius: Get.width * 0.06,
                                                backgroundColor: Colors.white,
                                                backgroundImage: NetworkImage(
                                                    "https://nodeserver.mydevfactory.com:3309/channelProfile/${widget.videocontent.channelProfileImage}")),
                                          )
                                        : CircleAvatar(
                                            radius: Get.width * 0.1,
                                            backgroundImage: const AssetImage(
                                                "assets/images/person.png"),
                                          ),
                                    SizedBox(
                                      height: Get.width * 0.03,
                                    ),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            detailvideocontroller.isLiked
                                                .toggle();
                                          },
                                          child: Icon(
                                            Icons.favorite,
                                            size: 35,
                                            color: detailvideocontroller
                                                    .isLiked.value
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        // SizedBox(height: 3),
                                        Text(
                                          detailvideocontroller.isLiked.value
                                              ? (widget.videocontent.likes + 1)
                                                  .toString()
                                              : widget.videocontent.likes
                                                  .toString(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(height: 7),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(CommentScreen(
                                                contentId:
                                                    widget.videocontent.id,
                                                userID: widget
                                                    .videocontent.userID));
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
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(height: 5),
                                    Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            var channelId =
                                                await getChannelId();
                                            if (channelId != null) {
                                              Get.to(UploadContentScreen(
                                                channelId: channelId,
                                              ));
                                            } else {
                                              Get.to(CreateChannel());
                                            }
                                          },
                                          child: Icon(
                                            Icons.upload_rounded,
                                            size: 40,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
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
                                Container(
                                  width: mWidth * 0.7,
                                  child: Text(
                                    widget.videocontent.channelTitle.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: mWidth * 0.7,
                                  child: Text(
                                    widget.videocontent.contentTitle,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    GridViewVideo(
                      contentId: widget.videocontent.id,
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
