import 'package:blades/controller/channel_controller.dart';
import 'package:blades/controller/search_controller.dart';
import 'package:blades/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../utils/dimentions.dart';
import 'upload_content.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController textController = TextEditingController(text: "");
  SearchController searchController = Get.put(SearchController());
  ChannelController channelController = Get.put(ChannelController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kBlack,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: SizedBox(
                          height: mHeight * 0.06,
                          width: mHeight * 0.06,
                          child: Icon(
                            Icons.arrow_back,
                            color: kWhite,
                          )),
                    ),
                    Container(
                      width: mWidth * 0.8,
                      height: Get.height * 0.065,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                          maxHeight: Get.height * 0.065, maxWidth: mWidth),
                      padding: EdgeInsets.only(
                        left: Get.width * 0.02,
                      ),
                      child: TextFormField(
                        autofocus: true,
                        cursorColor: kWhite,
                        style: TextStyle(color: Colors.white),
                        controller: textController,
                        onChanged: (val) {
                          if (textController.text == "") {
                            searchController.ishomeSearch.value = false;
                            searchController.homesearchlist.clear();
                          } else {
                            searchController.ishomeSearch.value = true;
                            searchController.homesearchlist.clear();
                            channelController.channelList.forEach((e) {
                              e.title.toString().toLowerCase().contains(
                                      textController.text.toLowerCase())
                                  ? searchController.homesearchlist.add(e)
                                  : null;
                            });
                          }
                        },
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
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: mWidth * 0.04,
                  left: mWidth * 0.03,
                  right: mWidth * 0.02,
                ),
                child: channelController.channelList.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 5,
                        ),
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: searchController.ishomeSearch.value
                            ? searchController.homesearchlist.length
                            : channelController.channelList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var channel = searchController.ishomeSearch.value
                              ? searchController.homesearchlist[index]
                              : channelController.channelList[index];
                          var url =
                              "https://nodeserver.mydevfactory.com:3309/channelProfile/${channel.profileImage}";
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
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
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: mWidth * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      channel.title,
                                      style: TextStyle(
                                          fontSize: 15.5,
                                          letterSpacing: 0.7,
                                          fontWeight: FontWeight.w600,
                                          color: kWhite.withOpacity(0.9)),
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
                            ],
                          );
                        },
                      )
                    : channelController.isChannelmsg.value == ""
                        ? CircularProgressIndicator(
                            color: kSecondaryColor,
                          )
                        : Container(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
