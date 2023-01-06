import 'dart:ui';
import 'package:blades/controller/comment_controller.dart';
import 'package:blades/controller/profile_controller.dart';
import 'package:blades/services/api_services.dart';
import 'package:blades/services/shared_preference_service.dart';
import 'package:blades/utils/colors.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:blades/widgets/app_drawer.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  final String contentId;
  final String userID;
  final bool isHideAppbar;

  const CommentScreen({
    Key? key,
    required this.contentId,
    required this.userID,
    this.isHideAppbar = false,
  }) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  CommentController controller = Get.put(CommentController());
  GlobalKey<ScaffoldState> scaffoldkey = GlobalKey<ScaffoldState>();
  ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
    getCommentsBYId(widget.contentId);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          key: scaffoldkey,
          backgroundColor: kWhite,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.08),
            child: widget.isHideAppbar
                ? SizedBox(
                    height: Get.height * 0.08,
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: AppBar(
                      leading: InkWell(
                        onTap: () {
                          scaffoldkey.currentState!.openDrawer();
                        },
                        child: SizedBox(
                            height: mHeight * 0.05,
                            width: mHeight * 0.05,
                            child: Image.asset(
                              "assets/images/15logo.png",
                              fit: BoxFit.contain,
                              height: mHeight * 0.05,
                              width: mHeight * 0.05,
                            )),
                      ),
                      automaticallyImplyLeading: false,
                      title: const Text(
                        "Comments",
                        // style: TextStyle(color: Colors.white),
                      ),
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor: Colors.white,
                      systemOverlayStyle: const SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.light),
                    ),
                  ),
          ),
          drawer: AppDrawer(drawerkey: scaffoldkey),
          body: Container(
            child: CommentBox(
                userImage: profileController.image.value == ""
                    ? "https://randomuser.me/api/portraits/men/1.jpg"
                    : "https://nodeserver.mydevfactory.com:3309/userProfile/${profileController.image.value}",
                labelText: 'Write a comment...',
                withBorder: false,
                errorText: 'Comment cannot be blank',
                sendButtonMethod: () async {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    editContent(
                        0,
                        widget.contentId,
                        comment: commentController.text,
                        widget.userID);
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: kWhite,
                textColor: kBlack,
                sendWidget:
                    const Icon(Icons.send, size: 30, color: Colors.black),
                child: controller.commentdataList.isNotEmpty
                    ? ListView.separated(
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: mWidth * 0.08),
                            child: Divider(
                              color: kBlack.withOpacity(0.5),
                            ),
                          );
                        },
                        itemCount: controller.commentdataList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var commentdata = controller.commentdataList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ListTile(
                              leading: GestureDetector(
                                onTap: () async {},
                                child: Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: const BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(commentdata
                                                .userDetails!.profileImage ==
                                            null
                                        ? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png"
                                        : "https://nodeserver.mydevfactory.com:3309/userProfile/${commentdata.userDetails!.profileImage}"),
                                  ),
                                ),
                              ),
                              title: Text(
                                commentdata.userDetails!.name == null
                                    ? "User"
                                    : commentdata.userDetails!.name.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, color: kBlack),
                              ),
                              subtitle: Text(
                                commentdata.comments!.comment.toString(),
                                style: const TextStyle(color: kBlack),
                              ),
                            ),
                          );
                        },
                      )
                    : controller.commentMsg.value != ""
                        ? Center(
                            child: Text(
                              "No Comments Found!",
                              style: TextStyle(color: kBlack),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            color: kSecondaryColor,
                          ))),
          ),
        ),
      ),
    );
  }
}
