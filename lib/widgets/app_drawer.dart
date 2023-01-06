import 'package:blades/controller/profile_controller.dart';
import 'package:blades/screens/aboutus.dart';
import 'package:blades/screens/change_password_screen.dart';
import 'package:blades/screens/contact_us.dart';
import 'package:blades/screens/create_channel.dart';
import 'package:blades/screens/faq.dart';
import 'package:blades/screens/home.dart';
import 'package:blades/screens/manage_channel.dart';
import 'package:blades/screens/manage_payment.dart';
import 'package:blades/screens/privacy_policy.dart';
import 'package:blades/screens/profile_screen.dart';
import 'package:blades/screens/sign_in_page.dart';
import 'package:blades/screens/subscription.dart';
import 'package:blades/screens/terms_and_condition.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../livestream/go_live_screen.dart';
import '../screens/pageview_video.dart';

class AppDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerkey;
  const AppDrawer({Key? key, required this.drawerkey}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var onTapIndex = 20;

  List drawerdata = [
    {"name": "Dashboard", "icon": "bottom1"},
    {"name": "Create Channel", "icon": "bottom3"},
    {"name": "Manage Channel", "icon": "bottom4"},
    // {"name": "Subscription", "icon": "icon3"},
    {"name": "Go Live", "icon": "icon3"},
    {"name": "Change Password", "icon": "icon1"},
    {"name": "Manage payment", "icon": "icon4"},
    {"name": "Contact", "icon": "icon5"},
    {"name": "About Us", "icon": "icon6"},
    {"name": "FAQ", "icon": "icon7"},
    {"name": "Terms & Conditions", "icon": "icon8"},
    {"name": "Privacy Policy", "icon": "icon9"},
    {"name": "Logout", "icon": "icon10"},
  ];
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    launchAboutus() async {
      await launch(
          "https://nodeserver.mydevfactory.com/jajakul/blades/#/About");
    }

    Size size = MediaQuery.of(context).size;
    return Obx(
      () => Drawer(
        width: size.width * 0.9,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  elevation: 2,
                  child: Stack(
                    children: [
                      Positioned(
                        right: 10,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            widget.drawerkey.currentState!.openEndDrawer();
                          },
                          child: Card(
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xffF1EFEF))),
                            elevation: 0,
                            child: Padding(
                              padding: EdgeInsets.all(Get.width * 0.01),
                              child: Icon(
                                Icons.close,
                                color: Color(0xffF1EFEF),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.025,
                            vertical: size.height * 0.03),
                        child: InkWell(
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Get.to(ProfileScreen());
                          },
                          child: Row(
                            children: [
                              profileController.image.value != ""
                                  ? CircleAvatar(
                                      radius: Get.width * 0.1,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          "https://nodeserver.mydevfactory.com:3309/userProfile/${profileController.image.value}"))
                                  : CircleAvatar(
                                      radius: Get.width * 0.1,
                                      backgroundImage: AssetImage(
                                          "assets/images/person.png"),
                                    ),
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  profileController.name.value != ""
                                      ? Text(
                                          profileController.name.value,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF292929)),
                                        )
                                      : Text(
                                          "John Doe",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF292929)),
                                        ),
                                  profileController.email.value != ""
                                      ? Container(
                                          width: mWidth * 0.47,
                                          child: Text(
                                            profileController.email.value,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Color(0xFFA8A8A8)),
                                          ),
                                        )
                                      : Text(
                                          "info@johndeo.com",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Color(0xFFA8A8A8)),
                                        )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Divider(
                  height: size.height * 0.05,
                  color: Color(0xFFE0E0E0),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: drawerdata.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 6 || index == 8) {
                    return SizedBox();
                  }
                  if (index == onTapIndex) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 15, top: 4, bottom: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: size.height * 0.08,
                            width: size.width,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 2),
                            decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.7),
                                    blurRadius: 10.0,
                                    spreadRadius: 1,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(30)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                              width: 1,
                                              color: Color(0xffD6D6D6))),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: SvgPicture.asset(
                                          "assets/icons/${drawerdata[index]['icon']}.svg",
                                          color: Color(0xff3C3C3C),
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.03,
                                    ),
                                    Text(
                                      "${drawerdata[index]['name']}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        onTapIndex = index;
                      });
                      widget.drawerkey.currentState!.openEndDrawer();
                      switch (index) {
                        case 0:
                          print(index);
                          Get.to(PageViewVideo());
                          break;
                        case 1:
                          Get.to(CreateChannel());
                          break;
                        case 2:
                          Get.to(ManageChannel());
                          break;
                        case 3:
                          // Get.to(SubscriptionScreen());
                          Get.to(GoLiveScreen());
                          break;
                        case 4:
                          Get.to(ChangePasswordScreen());
                          break;
                        case 5:
                          Get.to(ManagePayment());
                          break;
                        case 6:
                          Get.to(ContactUs());
                          break;
                        case 7:
                          launchAboutus();
                          break;
                        case 8:
                          Get.to(FaqScreen());
                          break;
                        case 9:
                          Get.to(TermsandCondition());
                          break;
                        case 10:
                          Get.to(PrivacyPolicy());
                          break;
                        case 11:
                          removelogin();
                          removechannelList();
                          removeToken();
                          removeuserid();
                          Get.off(SignInPage());
                          break;

                        default:
                      }
                    },
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.06, vertical: 4),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        width: 1, color: Color(0xffD6D6D6))),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(
                                    "assets/icons/${drawerdata[index]['icon']}.svg",
                                    color: Color(0xff3C3C3C),
                                    height: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.03,
                              ),
                              Text(
                                "${drawerdata[index]['name']}",
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0xff696969)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
