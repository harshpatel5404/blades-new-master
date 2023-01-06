import 'dart:typed_data';
import 'package:blades/controller/profile_controller.dart';
import 'package:blades/widgets/custom_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'livestream_model.dart';
import 'storage_methods.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods();

  Future<String> startLiveStream(
      BuildContext context, String title, Uint8List? image) async {
    ProfileController profileController = Get.put(ProfileController());
    // final user = Provider.of<UserProvider>(context, listen: false);
    var uid = profileController.id.value;
    var username = profileController.name.value;
    String channelId = '';
    try {
      if (title.isNotEmpty && image != null) {
        // if (!((await _firestore
        //         .collection('livestream')
        //         .doc('${uid}${username}')
        //         .get())
        //     .exists)) {
        String thumbnailUrl = await _storageMethods.uploadImageToStorage(
          'livestream-thumbnails',
          image,
          uid,
        );
        channelId = '${uid}${username}';

        LiveStream liveStream = LiveStream(
          title: title,
          image: thumbnailUrl,
          uid: uid,
          username: username,
          viewers: 0,
          channelId: channelId,
          startedAt: DateTime.now(),
        );

        _firestore
            .collection('livestream')
            .doc(channelId)
            .set(liveStream.toMap());
        // }
        //  else {
        //   showCustomSnackBar('Two Livestreams cannot start at the same time.');
        // }
      } else {
        showCustomSnackBar('Please enter all the fields');
      }
    } on FirebaseException catch (e) {
      showCustomSnackBar(e.message!);
    }
    return channelId;
  }

  Future<void> chat(String text, String id, BuildContext context) async {
    // final user = Provider.of<UserProvider>(context, listen: false);
    ProfileController profileController = Get.put(ProfileController());

    // final user = Provider.of<UserProvider>(context, listen: false);

    var uid = profileController.id.value;
    var username = profileController.name.value;

    try {
      String commentId = const Uuid().v1();
      await _firestore
          .collection('livestream')
          .doc(id)
          .collection('comments')
          .doc(commentId)
          .set({
        'username': username,
        'message': text,
        'uid': uid,
        'createdAt': DateTime.now(),
        'commentId': commentId,
      });
    } on FirebaseException catch (e) {
      showCustomSnackBar(e.message.toString());
    }
  }

  Future<void> updateViewCount(String id, bool isIncrease) async {
    try {
      await _firestore.collection('livestream').doc(id).update({
        'viewers': FieldValue.increment(isIncrease ? 1 : -1),
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> endLiveStream(String channelId) async {
    try {
      QuerySnapshot snap = await _firestore
          .collection('livestream')
          .doc(channelId)
          .collection('comments')
          .get();

      for (int i = 0; i < snap.docs.length; i++) {
        await _firestore
            .collection('livestream')
            .doc(channelId)
            .collection('comments')
            .doc(
              ((snap.docs[i].data()! as dynamic)['commentId']),
            )
            .delete();
      }
      await _firestore.collection('livestream').doc(channelId).delete();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
