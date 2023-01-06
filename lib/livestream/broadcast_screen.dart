import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:blades/config/config.dart';
import 'package:blades/livestream/responsive_layout.dart';
import 'package:blades/screens/pageview_video.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:http/http.dart' as http;
import '../controller/profile_controller.dart';
import '../widgets/app_drawer.dart';
import 'firestore_methods.dart';

class BroadcastScreen extends StatefulWidget {
  final bool isBroadcaster;
  final String channelId;
  const BroadcastScreen({
    Key? key,
    required this.isBroadcaster,
    required this.channelId,
  }) : super(key: key);

  @override
  State<BroadcastScreen> createState() => _BroadcastScreenState();
}

class _BroadcastScreenState extends State<BroadcastScreen> {
  late final RtcEngine _engine;
  List<int> remoteUid = [];
  List listofusers = ["Live stream started!"];
  bool switchCamera = true;
  bool isMuted = false;
  bool isScreenSharing = false;
  RxBool liveStreamEnd = false.obs;
  ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // AppHelper.setStatusbar();
      _initEngine();
    });
  }

  void _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(appId));
    _addListeners();
    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    if (widget.isBroadcaster) {
      _engine.setClientRole(ClientRole.Broadcaster);
    } else {
      _engine.setClientRole(ClientRole.Audience);
    }
    _joinChannel();
  }

  // String baseUrl = "https://rnappz-node-production.up.railway.app";
  String baseUrl = "https://nodeserver.mydevfactory.com:3309/frontendRouter";

  String? token;

  Future<void> getToken() async {
    try {
      var uid = profileController.id.value;
      final res = await http.get(
        Uri.parse(
            '$baseUrl/rtc/${widget.channelId}/publisher/userAccount/$uid/'),
      );

      if (res.statusCode == 200) {
        setState(() {
          token = res.body;
          token = jsonDecode(token!)['rtcToken'];
          print("token... $token");
        });
      } else {
        print('Failed to fetch the token');
      }
    } catch (e) {
      print("error get token $e");
    }
  }

  void _addListeners() {
    var name = profileController.name.value;
    _engine.setEventHandler(
        RtcEngineEventHandler(joinChannelSuccess: (channel, uid, elapsed) {
      print('joinChannelSuccess $channel $uid $elapsed');
    }, userJoined: (uid, elapsed) {
      print('userJoined $uid $elapsed');
      setState(() {
        listofusers.add("$name Joined!");
        remoteUid.add(uid);
      });
    }, userOffline: (uid, reason) {
      print('userOffline $uid $reason');
      setState(() {
        remoteUid.removeWhere((element) => element == uid);
      });
    }, leaveChannel: (stats) {
      print('leaveChannel $stats');
      setState(() {
        listofusers.add("$name Leave");
        remoteUid.clear();
      });
    }, tokenPrivilegeWillExpire: (token) async {
      await getToken();
      await _engine.renewToken(token);
    }));
  }

  void _joinChannel() async {
    var uid = profileController.id.value;
    await getToken();
    if (token != null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        await [Permission.microphone, Permission.camera].request();
      }
      await _engine.joinChannelWithUserAccount(
        token,
        widget.channelId,
        uid,
      );
    }
  }

  void _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  void onToggleMute() async {
    setState(() {
      isMuted = !isMuted;
    });
    await _engine.muteLocalAudioStream(isMuted);
  }

  _leaveChannel() async {
    var uid = profileController.id.value;
    var username = profileController.name.value;
    await _engine.leaveChannel();
    if ('${uid}${username}' == widget.channelId) {
      await FirestoreMethods().endLiveStream(widget.channelId);
    } else {
      await FirestoreMethods().updateViewCount(widget.channelId, false);
    }
    Get.off(PageViewVideo());
  }

  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var uid = profileController.id.value;
    var username = profileController.name.value;
    return WillPopScope(
      onWillPop: () async {
        await _leaveChannel();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          key: scaffoldkey,
          backgroundColor: kWhite,
          drawer: AppDrawer(drawerkey: scaffoldkey),
          body: Obx(
            () => liveStreamEnd.value
                ? Center(
                    child: Text("Live Stream Ended!"),
                  )
                : Stack(
                    children: [
                      _renderVideo(uid, username, isScreenSharing),
                      Positioned(
                        top: mHeight * 0.01,
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: mWidth * 0.05),
                          child: Container(
                            width: mWidth * 0.9,
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
                                Container(
                                  color: Colors.red,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 5),
                                    child: Text(
                                      "Live",
                                      style: TextStyle(
                                          fontSize: 15, color: kWhite),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  // width: mWidth * 0.13,
                                  width: mWidth * 0.2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.visibility),
                                        Container(
                                          width: 30,
                                          height: 25,
                                          alignment: Alignment.center,
                                          child:
                                              StreamBuilder<DocumentSnapshot>(
                                            stream: FirebaseFirestore.instance
                                                .collection('livestream')
                                                .doc(widget.channelId)
                                                .snapshots(),
                                            builder: (context,
                                                AsyncSnapshot<DocumentSnapshot>
                                                    snapshot) {
                                              if (snapshot.hasError) {
                                                return Text("errx");
                                              }

                                              if (snapshot.hasData &&
                                                  !snapshot.data!.exists) {
                                                _leaveChannel();
                                                return Text(" ");
                                              }
                                              if (snapshot.data != null) {
                                                var data = snapshot.data;
                                                var viewers =
                                                    data!["viewers"] ?? "0";
                                                return Text(
                                                  " $viewers",
                                                );
                                              }

                                              // if (!snapshot.hasData) {
                                              //   return Center(
                                              //     child:
                                              //         CircularProgressIndicator(),
                                              //   );
                                              // }
                                              // if (snapshot.hasData &&
                                              //     snapshot.data != null) {
                                              // var data = snapshot.data;
                                              // var viewers = data["viewers"];
                                              // return Text(
                                              //   " $viewers",
                                              // );
                                              // } else {
                                              //   if (!snapshot.data.exists) {
                                              // _leaveChannel();
                                              //     return Center(
                                              //       child: Text(""),
                                              //     );
                                              //   }
                                              // }
                                              return Text(
                                                " 0",
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      "${uid}${username}" == widget.channelId
                          ? Positioned(
                              bottom: mWidth * 0.1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mWidth * 0.1),
                                child: Container(
                                  width: mWidth * 0.8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: onToggleMute,
                                        child: Container(
                                          height: mHeight * 0.08,
                                          width: mHeight * 0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: isMuted
                                              ? Icon(
                                                  Icons.music_off_rounded,
                                                  size: 35,
                                                  color: kSecondaryColor,
                                                )
                                              : Icon(
                                                  Icons.music_note,
                                                  size: 35,
                                                  color: kSecondaryColor,
                                                ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _leaveChannel,
                                        child: Container(
                                          height: mHeight * 0.08,
                                          width: mHeight * 0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Icon(
                                            Icons.call_end,
                                            size: 35,
                                            color: kWhite,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: _switchCamera,
                                        child: Container(
                                            height: mHeight * 0.08,
                                            width: mHeight * 0.08,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: Icon(
                                              Icons.flip_camera_ios_rounded,
                                              size: 35,
                                              color: kSecondaryColor,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              bottom: mWidth * 0.1,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: mWidth * 0.1),
                                child: Container(
                                  width: mWidth * 0.8,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: _leaveChannel,
                                        child: Container(
                                          height: mHeight * 0.08,
                                          width: mHeight * 0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Icon(
                                            Icons.call_end,
                                            size: 35,
                                            color: kWhite,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      // Positioned(
                      //     bottom: mHeight * 0.15,
                      //     child: Container(
                      //       height: mHeight * 0.25,
                      //       width: mWidth * 0.8,
                      //       child: ListView.builder(
                      //         shrinkWrap: true,
                      //         itemCount: listofusers.length,
                      //         itemBuilder: (BuildContext context, int index) {
                      //           return Padding(
                      //             padding: const EdgeInsets.symmetric(
                      //                 horizontal: 3.0, vertical: 1),
                      //             child: Container(
                      //                 decoration: BoxDecoration(
                      //                     color: Colors.grey.withOpacity(0.8),
                      //                     borderRadius:
                      //                         BorderRadius.circular(5)),
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(6.0),
                      //                   child: Text(
                      //                     listofusers[index],
                      //                     style: TextStyle(
                      //                         color: kWhite, fontSize: 14),
                      //                   ),
                      //                 )),
                      //           );
                      //         },
                      //       ),
                      //     ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  _renderVideo(uid, username, isScreenSharing) {
    return Container(
      // aspectRatio: 16 / 9,
      height: mHeight,
      width: mWidth,
      child: "${uid}${username}" == widget.channelId
          ? isScreenSharing
              ? kIsWeb
                  ? const RtcLocalView.SurfaceView.screenShare()
                  : const RtcLocalView.TextureView.screenShare()
              : const RtcLocalView.SurfaceView(
                  zOrderMediaOverlay: true,
                  zOrderOnTop: true,
                )
          : isScreenSharing
              ? kIsWeb
                  ? const RtcLocalView.SurfaceView.screenShare()
                  : const RtcLocalView.TextureView.screenShare()
              : remoteUid.isNotEmpty
                  ? kIsWeb
                      ? RtcRemoteView.SurfaceView(
                          uid: remoteUid[0],
                          channelId: widget.channelId,
                        )
                      : RtcRemoteView.TextureView(
                          uid: remoteUid[0],
                          channelId: widget.channelId,
                        )
                  : Container(),
    );
  }
}
