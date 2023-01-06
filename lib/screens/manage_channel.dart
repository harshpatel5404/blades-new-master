import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:blades/controller/channel_controller.dart';
import 'package:blades/screens/create_channel.dart';
import 'package:blades/screens/detail_file_page.dart';
import 'package:blades/screens/detail_image_page.dart';
import 'package:blades/screens/detail_video_page.dart';
import 'package:blades/screens/edit_channel.dart';
import 'package:blades/screens/upload_content.dart';
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

class ManageChannel extends StatefulWidget {
  const ManageChannel({Key? key}) : super(key: key);

  @override
  State<ManageChannel> createState() => _ManageChannelState();
}

class _ManageChannelState extends State<ManageChannel> {
  ChannelController channelController = Get.put(ChannelController());
  TextEditingController searchController = TextEditingController(text: "");

  @override
  void initState() {
    super.initState();
    getChannelDetails();
  }

  Future<String> createFolder() async {
    Directory tempDir = await getTemporaryDirectory();
    String temppath = tempDir.path;
    final path = Directory(temppath);
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }

  Future<void> saveFile(url) async {
    var savePath = await createFolder();
    savePath = "$savePath/myfile.doc";
    print(savePath);
    await Dio().download(url, savePath).then((value) {
      // Get.to(FileDetailPage(
      //   contentUrl: savePath,
      // ));
    });
  }

  Future getThumbnail(url) async {
    try {
      return await VideoThumbnail.thumbnailFile(
        video: url,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxHeight: 300,
        quality: 100,
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
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
                    " Manage Channel",
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: mWidth * 0.04,
                      left: mWidth * 0.03,
                      right: mWidth * 0.02,
                    ),
                    child: channelController.channelList.isNotEmpty
                        ? ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            reverse: true,
                            itemCount: channelController.channelList.length,
                            itemBuilder: (BuildContext context, int index) {
                              var channel =
                                  channelController.channelList[index];
                              var url =
                                  "https://nodeserver.mydevfactory.com:3309/channelProfile/${channel.profileImage}";
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Card(
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
                                        imageUrl: url,
                                        height: Get.width * 0.15,
                                        width: Get.width * 0.15,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: mWidth * 0.5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // "Jhon’s Medical Blog",
                                          channel.title,
                                          style: TextStyle(
                                              fontSize: 15.5,
                                              letterSpacing: 0.7,
                                              fontWeight: FontWeight.w600,
                                              color: kBlack.withOpacity(0.8)),
                                        ),
                                        ReadMoreText(
                                          // 'Lorem ipsum is place holder text commonly in the graphic, print, and publishing industries for previewing layouts',
                                          channel.description,
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
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(UploadContentScreen(
                                            channelId: channel.id,
                                          ));
                                        },
                                        child: Container(
                                          height: mWidth * 0.11,
                                          width: mWidth * 0.11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: kSecondaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              "assets/icons/upload.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(EditChannel(
                                            channelid: channel.id,
                                            channelImg: url,
                                            desc: channel.description,
                                            title: channel.title,
                                          ));
                                        },
                                        child: Container(
                                          height: mWidth * 0.11,
                                          width: mWidth * 0.11,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: kSecondaryColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: SvgPicture.asset(
                                              "assets/icons/edit.svg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          )
                        : channelController.isChannelmsg.value == ""
                            ? const CircularProgressIndicator(
                                color: kSecondaryColor,
                              )
                            : Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(const CreateChannel());
                                    },
                                    child: Container(
                                      height: mWidth * 0.18,
                                      width: mWidth * 0.18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: kSecondaryColor,
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: kWhite,
                                        size: 35,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: mHeight * 0.02,
                                  ),
                                  Text(
                                    "Create Channel",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                  ),
                  SizedBox(
                    height: mHeight * 0.02,
                  ),
                  channelController.contentList.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: mWidth * 0.04, right: mWidth * 0.04),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  " Content",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 15,
                                      // fontFamily: "Poppins",
                                      letterSpacing: 0.7,
                                      fontWeight: FontWeight.w500,
                                      color: kBlack.withOpacity(0.9)),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: mHeight * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: mWidth * 0.04,
                                      right: mWidth * 0.04),
                                  child: Container(
                                    width: mWidth * 0.75,
                                    height: Get.height * 0.065,
                                    decoration: BoxDecoration(
                                      color: kWhite,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 10,
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 1,
                                        )
                                      ],
                                    ),
                                    constraints: BoxConstraints(
                                        maxHeight: Get.height * 0.065,
                                        maxWidth: mWidth),
                                    padding: EdgeInsets.only(
                                      left: Get.width * 0.02,
                                    ),
                                    child: TextFormField(
                                      cursorColor: kBlack,
                                      controller: searchController,
                                      onChanged: (val) {
                                        if (searchController.text == "") {
                                          channelController.isSearch.value =
                                              false;
                                          channelController.searchlist.clear();
                                        } else {
                                          channelController.isSearch.value =
                                              true;
                                          channelController.searchlist.clear();
                                          channelController.contentList
                                              .forEach((e) {
                                            e.contentTitle
                                                    .toString()
                                                    .toLowerCase()
                                                    .contains(searchController
                                                        .text
                                                        .toLowerCase())
                                                ? channelController.searchlist
                                                    .add(e)
                                                : null;
                                          });
                                        }
                                        print(channelController.searchlist);
                                      },
                                      decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.search_rounded,
                                            color: Color(0xFF859CA6),
                                          ),
                                          hintText: "Search ",
                                          hintStyle: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF859CA6),
                                              fontFamily: "Poppins"),
                                          filled: true,
                                          contentPadding: EdgeInsets.all(15),
                                          fillColor: kWhite,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kWhite, width: 0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: kWhite, width: 0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)))),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    filterDialog(context);
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: kWhite,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 10,
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(Get.width * 0.035),
                                          child: SvgPicture.asset(
                                            "assets/icons/filter.svg",
                                            height: mWidth * 0.06,
                                            width: mWidth * 0.06,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        ),
                                      ),
                                      channelController
                                                  .isSelectedFilter.value !=
                                              10
                                          ? Positioned(
                                              right: mWidth * 0.02,
                                              top: mWidth * 0.018,
                                              child: Container(
                                                width: mWidth * 0.03,
                                                height: mWidth * 0.03,
                                                decoration: BoxDecoration(
                                                  color: kSecondaryColor,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: mHeight * 0.02,
                            ),
                            Container(
                              width: mWidth,
                              color: Colors.white,
                              child: GridView.builder(
                                shrinkWrap: true,
                                // reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisSpacing: 2.5,
                                        mainAxisSpacing: 2.5,
                                        crossAxisCount: 3,
                                        childAspectRatio: 0.8),
                                itemCount: channelController.isSearch.value
                                    ? channelController.searchlist.length
                                    : channelController.contentList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var contentdata = channelController
                                          .isSearch.value
                                      ? channelController.searchlist[index]
                                      : channelController.contentList[index];
                                  var content =
                                      contentdata.content.split('.').last;
                                  print("content $content");
                                  var url =
                                      "https://nodeserver.mydevfactory.com:3309/channelContent/${contentdata.content}";

                                  if (content == "mp4") {
                                    return FutureBuilder(
                                        future: getThumbnail(url),
                                        builder: (context, snapshot) {
                                          if (snapshot.data != null) {
                                            print("dataa ->> ${snapshot.data}");
                                            print(contentdata.id);
                                            return InkWell(
                                              onTap: () {
                                                Get.to(VideoDetailPage(
                                                    content: contentdata));
                                              },
                                              child: Stack(
                                                children: [
                                                  Container(
                                                    color: kBlack,
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
                                                        padding: EdgeInsets.all(
                                                            10.0),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: Text(
                                                            contentdata
                                                                .contentTitle,
                                                            maxLines: 2,
                                                            overflow:
                                                                TextOverflow
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
                                          return InkWell(
                                            onTap: () {
                                              print(contentdata.id);

                                              Get.to(VideoDetailPage(
                                                  content: contentdata));
                                            },
                                            child: Container(
                                              color: kBlack,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          );
                                        });
                                  }
                                  return Container(
                                    color: kBlack,
                                  );
                                },
                              ),
                            ),
                            channelController.isSearch.value &&
                                    channelController.searchlist.isEmpty
                                ? const Center(
                                    child: Text("Search result not found"),
                                  )
                                : Container(
                                    color: kBlack,
                                    // height: mHeight * 0.12,
                                  ),
                          ],
                        )
                      : channelController.contentmsg.value == ""
                          ? SizedBox()
                          : const Center(
                              child: Text("Content is not available"),
                            ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
