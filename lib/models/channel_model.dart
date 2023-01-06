// import 'dart:convert';

// ChannelModel channelModelFromJson(String str) =>
//     ChannelModel.fromJson(json.decode(str));

// String channelModelToJson(ChannelModel data) => json.encode(data.toJson());

// class ChannelModel {
//   ChannelModel({
//   required this.code,
//   required this.data,
//   required this.success,
//   });

//   int code;
//   List<Datum> data;
//   bool success;

//   factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
//         code: json["code"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//         success: json["success"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "success": success,
//       };
// }

// class Datum {
//   Datum({
//    required this.userId,
//    required this.id,
//    required this.channelList,
//    required this.createdAt,
//    required this.updatedAt,
//    required this.v,
//   });

//   String userId;
//   String id;
//   List<ChannelList> channelList;
//   DateTime createdAt;
//   DateTime updatedAt;
//   int v;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         userId: json["userId"],
//         id: json["_id"],
//         channelList: List<ChannelList>.from(
//             json["channelList"].map((x) => ChannelList.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//       );

//   Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "_id": id,
//         "channelList": List<dynamic>.from(channelList.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//       };
// }

// class ChannelList {
//   ChannelList({
//    required this.title,
//    required this.description,
//    required this.profileImage,
//    required this.id,
//    required this.uploadContent,
//   });

//   String title;
//   String description;
//   String profileImage;
//   String id;
//   List<UploadContent> uploadContent;

//   factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
//         title: json["title"],
//         description: json["description"],
//         profileImage: json["profileImage"],
//         id: json["_id"],
//         uploadContent: List<UploadContent>.from(
//             json["uploadContent"].map((x) => UploadContent.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "description": description,
//         "profileImage": profileImage,
//         "_id": id,
//         "uploadContent":
//             List<dynamic>.from(uploadContent.map((x) => x.toJson())),
//       };
// }

// class UploadContent {
//   UploadContent({
//    required this.contentTitle,
//    required this.contentDescription,
//    required this.content,
//    required this.id,
//   });

//   String contentTitle;
//   String contentDescription;
//   String content;
//   String id;

//   factory UploadContent.fromJson(Map<String, dynamic> json) => UploadContent(
//         contentTitle: json["contentTitle"],
//         contentDescription: json["contentDescription"],
//         content: json["content"],
//         id: json["_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "contentTitle": contentTitle,
//         "contentDescription": contentDescription,
//         "content": content,
//         "_id": id,
//       };
// }


// To parse this JSON data, do
//
//     final channelModel = channelModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final channelModel = channelModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChannelModel channelModelFromJson(String str) => ChannelModel.fromJson(json.decode(str));

String channelModelToJson(ChannelModel data) => json.encode(data.toJson());

class ChannelModel {
    ChannelModel({
        required this.code,
        required this.data,
        required this.contentData,
        required this.success,
    });

    final int code;
    final List<Datum> data;
    final List<ContentDatum> contentData;
    final bool success;

    factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        code: json["code"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        contentData: List<ContentDatum>.from(json["contentData"].map((x) => ContentDatum.fromJson(x))),
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "contentData": List<dynamic>.from(contentData.map((x) => x.toJson())),
        "success": success,
    };
}

class ContentDatum {
    ContentDatum({
        required this.userId,
        required this.channelId,
        required this.id,
        required this.uploadContent,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String userId;
    final String channelId;
    final String id;
    final List<UploadContent> uploadContent;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory ContentDatum.fromJson(Map<String, dynamic> json) => ContentDatum(
        userId: json["userId"],
        channelId: json["channelId"],
        id: json["_id"],
        uploadContent: List<UploadContent>.from(json["uploadContent"].map((x) => UploadContent.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "channelId": channelId,
        "_id": id,
        "uploadContent": List<dynamic>.from(uploadContent.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class UploadContent {
    UploadContent({
        required this.contentTitle,
        required this.contentDescription,
        required this.content,
        required this.isActive,
        required this.likes,
        required this.comments,
        required this.id,
        required this.userID,
    });

    final String contentTitle;
    final String contentDescription;
    final String content;
    final bool isActive;
    final int likes;
    final int comments;
    final String id;
    final String userID;

    factory UploadContent.fromJson(Map<String, dynamic> json) => UploadContent(
        contentTitle: json["contentTitle"],
        contentDescription: json["contentDescription"],
        content: json["content"],
        isActive: json["isActive"],
        likes: json["likes"],
        comments: json["comments"],
        id: json["_id"],
        userID: json["userID"],
    );

    Map<String, dynamic> toJson() => {
        "contentTitle": contentTitle,
        "contentDescription": contentDescription,
        "content": content,
        "isActive": isActive,
        "likes": likes,
        "comments": comments,
        "_id": id,
        "userID": userID,
    };
}

class Datum {
    Datum({
        required this.userId,
        required this.id,
        required this.channelList,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    final String userId;
    final String id;
    final List<ChannelList> channelList;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["userId"],
        id: json["_id"],
        channelList: List<ChannelList>.from(json["channelList"].map((x) => ChannelList.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "_id": id,
        "channelList": List<dynamic>.from(channelList.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ChannelList {
    ChannelList({
        required this.title,
        required this.description,
        required this.profileImage,
        required this.isActive,
        required this.id,
    });

    final String title;
    final String description;
    final String profileImage;
    final bool isActive;
    final String id;

    factory ChannelList.fromJson(Map<String, dynamic> json) => ChannelList(
        title: json["title"],
        description: json["description"],
        profileImage: json["profileImage"],
        isActive: json["isActive"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "profileImage": profileImage,
        "isActive": isActive,
        "_id": id,
    };
}
