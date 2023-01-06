import 'package:blades/controller/channel_controller.dart';
import 'package:blades/controller/home_controller.dart';
import 'package:blades/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dimentions.dart';

Future filterDialog(context) {
  ChannelController channelController = Get.put(ChannelController());
  List names = ["Photo", "Video", "PDF", ".Docx", "PPT", "Excel"];
  List icon = ["img", "video", "files", "img", "video", "files"];
  // var selectedIndex = 10;
  return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.8),
      builder: (ctx) => StatefulBuilder(
            builder: (context, setState) => Dialog(
              alignment: const Alignment(1.5, 0.5),
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: mWidth * 0.55,
                    height: mHeight * 0.65,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder: (context, index) {
                              return const Divider();
                            },
                            shrinkWrap: true,
                            itemCount: names.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  var fileType = "";

                                  if (index == 0) {
                                    fileType = "jpg";
                                  }

                                  switch (index) {
                                    case 0:
                                      fileType = "jpg";
                                      break;
                                    case 1:
                                      fileType = "mp4";
                                      break;
                                    case 2:
                                      fileType = "pdf";
                                      break;
                                    case 3:
                                      fileType = "doc";
                                      break;
                                    case 4:
                                      fileType = "ppt";
                                      break;
                                    case 5:
                                      fileType = "xlsx";
                                      break;
                                    default:
                                      fileType = "";
                                  }

                                  channelController.isSelectedFilter.value =
                                      index;
                                  channelController.isSearch.value = true;
                                  channelController.searchlist.clear();
                                  channelController.contentList.forEach((e) {
                                    if (e.content
                                        .split('.')
                                        .last
                                        .toString()
                                        .toLowerCase()
                                        .contains(fileType)) {
                                      print(e.content);
                                      channelController.searchlist.add(e);
                                    }
                                  });
                                  Get.back();
                                },
                                child: Container(
                                  color: channelController
                                              .isSelectedFilter.value ==
                                          index
                                      ? kSecondaryColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: mWidth * 0.03),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: mWidth * 0.1,
                                        ),
                                        SvgPicture.asset(
                                          "assets/icons/${icon[index]}.svg",
                                          height: mWidth * 0.06,
                                          width: mWidth * 0.06,
                                          color: channelController
                                                      .isSelectedFilter.value ==
                                                  index
                                              ? Colors.white
                                              : iconcolor,
                                          fit: BoxFit.fitHeight,
                                        ),
                                        SizedBox(
                                          width: mWidth * 0.04,
                                        ),
                                        Text(
                                          names[index],
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: channelController
                                                          .isSelectedFilter
                                                          .value ==
                                                      index
                                                  ? Colors.white
                                                  : textcolor),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                          TextButton(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        kSecondaryColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: kSecondaryColor)))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: mWidth * 0.05,
                              ),
                              child: const Text('clear'),
                            ),
                            onPressed: () {
                              channelController.isSelectedFilter.value = 10;
                              channelController.isSearch.value = false;
                              channelController.searchlist.clear();
                              Get.back();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
}

Future homefilterDialog(context) {
  HomeController homeController = Get.put(HomeController());
  List names = ["Photo", "Video", "PDF", ".Docx", "PPT", "Excel"];
  List icon = ["img", "video", "files", "img", "video", "files"];

  return showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.8),
    barrierDismissible: true,
    builder: (ctx) => Dialog(
      // alignment: const Alignment(2.8, -0.08),
      alignment: const Alignment(1.5, 0.5),
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Container(
            width: mWidth * 0.55,
            height: mHeight * 0.65,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    shrinkWrap: true,
                    itemCount: names.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          var fileType = "";
                          if (index == 0) {
                            fileType = "jpg";
                          }

                          switch (index) {
                            case 0:
                              fileType = "jpg";
                              break;
                            case 1:
                              fileType = "mp4";
                              break;
                            case 2:
                              fileType = "pdf";
                              break;
                            case 3:
                              fileType = "doc";
                              break;
                            case 4:
                              fileType = "ppt";
                              break;
                            case 5:
                              fileType = "xlsx";
                              break;
                            default:
                              fileType = "";
                          }

                          homeController.ishomeSelectedFilter.value = index;
                          homeController.ishomeSearch.value = true;
                          homeController.homesearchlist.clear();
                          homeController.homecontentList.forEach((e) {
                            if (e.content
                                .split('.')
                                .last
                                .toString()
                                .toLowerCase()
                                .contains(fileType)) {
                              print(e.content);
                              homeController.homesearchlist.add(e);
                            }
                          });
                          Get.back();
                        },
                        child: Container(
                          color:
                              homeController.ishomeSelectedFilter.value == index
                                  ? kSecondaryColor
                                  : Colors.white,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: mWidth * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: mWidth * 0.1,
                                ),
                                SvgPicture.asset(
                                  "assets/icons/${icon[index]}.svg",
                                  height: mWidth * 0.06,
                                  width: mWidth * 0.06,
                                  color: homeController
                                              .ishomeSelectedFilter.value ==
                                          index
                                      ? Colors.white
                                      : iconcolor,
                                  fit: BoxFit.fitHeight,
                                ),
                                SizedBox(
                                  width: mWidth * 0.04,
                                ),
                                Text(
                                  names[index],
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: homeController
                                                  .ishomeSelectedFilter.value ==
                                              index
                                          ? Colors.white
                                          : textcolor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(kSecondaryColor),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: kSecondaryColor)))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mWidth * 0.05,
                      ),
                      child: const Text('clear'),
                    ),
                    onPressed: () {
                      homeController.ishomeSelectedFilter.value = 10;
                      homeController.ishomeSearch.value = false;
                      homeController.homesearchlist.clear();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
