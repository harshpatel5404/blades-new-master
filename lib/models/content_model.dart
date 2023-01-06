import 'dart:convert';

ContentModel contentModelFromJson(String str) =>
    ContentModel.fromJson(json.decode(str));

String contentModelToJson(ContentModel data) => json.encode(data.toJson());

class ContentModel {
  ContentModel({
    required this.code,
    required this.data,
    required this.contentData,
  });

  final int code;
  final List<Data> data;
  final List<ContentData> contentData;

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        code: json["code"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        contentData: List<ContentData>.from(
            json["contentData"].map((x) => ContentData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "contentData": List<dynamic>.from(contentData.map((x) => x.toJson())),
      };
}

class ContentData {
  ContentData({
    required this.userId,
    required this.channelId,
    required this.id,
    required this.homeuploadContent,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String userId;
  final String channelId;
  final String id;
  final List<HomeUploadContent> homeuploadContent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory ContentData.fromJson(Map<String, dynamic> json) => ContentData(
        userId: json["userId"],
        channelId: json["channelId"],
        id: json["_id"],
        homeuploadContent: List<HomeUploadContent>.from(
            json["uploadContent"].map((x) => HomeUploadContent.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "channelId": channelId,
        "_id": id,
        "uploadContent":
            List<dynamic>.from(homeuploadContent.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class HomeUploadContent {
  HomeUploadContent({
    required this.contentTitle,
    required this.contentDescription,
    required this.content,
    required this.isActive,
    required this.likes,
    required this.comments,
    required this.id,
    required this.userID,
    required this.channelProfileImage,
    required this.channelId,
    required this.channelTitle,
    required this.channelDescription,
  });

  final String contentTitle;
  final String contentDescription;
  final String content;
  final bool isActive;
  final int likes;
  final String comments;
  final String id;
  final String userID;
  final String channelProfileImage;
  final String channelId;
  final String channelTitle;
  final String channelDescription;

  factory HomeUploadContent.fromJson(Map<String, dynamic> json) =>
      HomeUploadContent(
        contentTitle: json["contentTitle"],
        contentDescription: json["contentDescription"],
        content: json["content"],
        isActive: json["isActive"],
        likes: json["likes"],
        comments: json["comments"].toString(),
        id: json["_id"],
        userID: json["userID"],
        channelProfileImage: json["channelProfileImage"],
        channelId: json["channelId"],
        channelTitle: json["channelTitle"],
        channelDescription: json["channelDescription"],
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
        "channelProfileImage": channelProfileImage,
        "channelId": channelId,
        "channelTitle" :channelTitle,
        "channelDescription" : channelDescription
      };
}

class Data {
  Data({
    required this.userId,
    required this.id,
    required this.homechannelList,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String userId;
  final String id;
  final List<HomeChannelList> homechannelList;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        id: json["_id"],
        homechannelList: List<HomeChannelList>.from(
            json["channelList"].map((x) => HomeChannelList.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "_id": id,
        "channelList":
            List<dynamic>.from(homechannelList.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class HomeChannelList {
  HomeChannelList({
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

  factory HomeChannelList.fromJson(Map<String, dynamic> json) =>
      HomeChannelList(
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
