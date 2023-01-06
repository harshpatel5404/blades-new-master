import 'package:blades/livestream/broadcast_screen.dart';
import 'package:blades/utils/dimentions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../utils/colors.dart';
import 'broadcast_screen.dart';
import 'firestore_methods.dart';
import 'livestream_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: kWhite,
                  ),
                ),
                SizedBox(
                  width: mWidth * 0.1,
                ),
                Text(
                  'Live Users',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: kWhite,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            StreamBuilder<dynamic>(
              stream: FirebaseFirestore.instance
                  .collection('livestream')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: kSecondaryColor,
                  );
                }
                if (snapshot.hasData && snapshot.data.size == 0) {
                  return Container(
                    height: mHeight * 0.2,
                    child: Center(
                      child: Text(
                        "Users not live",
                        style: const TextStyle(
                          color: kWhite,
                        ),
                      ),
                    ),
                  );
                }

                return Container(
                  height: mHeight * 0.25,
                  child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 4,
                        );
                      },
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        LiveStream post = LiveStream.fromMap(
                            snapshot.data.docs[index].data());
                        return InkWell(
                          onTap: () async {
                            await FirestoreMethods()
                                .updateViewCount(post.channelId, true);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => BroadcastScreen(
                                  isBroadcaster: false,
                                  channelId: post.channelId,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: size.height * 0.1,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                      imageUrl: post.image,
                                      height: mHeight * 0.13,
                                      width: mHeight * 0.13,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                // AspectRatio(
                                //   aspectRatio: 16 / 9,
                                //   child: Image.network(post.image),
                                // ),
                                const SizedBox(height: 5),
                                Text(
                                  post.username,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: kWhite,
                                    fontSize: 16,
                                  ),
                                ),
                                // Column(
                                //   // mainAxisAlignment:
                                //   //     MainAxisAlignment.spaceEvenly,
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       post.username,
                                //       style: const TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         color: kWhite,
                                //         fontSize: 20,
                                //       ),
                                //     ),
                                // Text(
                                //   post.title,
                                //   style: const TextStyle(
                                //     color: kWhite,
                                //   ),
                                // ),
                                //     Text(
                                //       '${post.viewers} watching',
                                //       style: const TextStyle(
                                //         color: kWhite,
                                //       ),
                                //     ),
                                //     Text(
                                //         'Started ${timeago.format(post.startedAt.toDate())}',
                                //         style: const TextStyle(
                                //           color: kWhite,
                                //         )),
                                //   ],
                                // ),

                                // IconButton(
                                //   onPressed: () {},
                                //   icon: const Icon(
                                //     Icons.more_vert,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
