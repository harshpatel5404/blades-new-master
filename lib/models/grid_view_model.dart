// // To parse this JSON data, do
// //
// //     final gridviewModel = gridviewModelFromJson(jsonString);

// import 'package:meta/meta.dart';
// import 'dart:convert';

// GridviewModel gridviewModelFromJson(String str) => GridviewModel.fromJson(json.decode(str));

// String gridviewModelToJson(GridviewModel data) => json.encode(data.toJson());

// class GridviewModel {
//     GridviewModel({
//         required this.code,
//         required this.success,
//         required this.message,
//         required this.data,
//     });

//     final int code;
//     final bool success;
//     final String message;
//     final Data data;

//     factory GridviewModel.fromJson(Map<String, dynamic> json) => GridviewModel(
//         code: json["code"],
//         success: json["success"],
//         message: json["message"],
//         data: Data.fromJson(json["data"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "code": code,
//         "success": success,
//         "message": message,
//         "data": data.toJson(),
//     };
// }

// class Data {
//     Data({
//         required this.userId,
//         required this.channelId,
//         required this.id,
//         required this.uploadContent,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//     });

//     final String userId;
//     final String channelId;
//     final String id;
//     final List<UploadContent> uploadContent;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final int v;

//     factory Data.fromJson(Map<String, dynamic> json) => Data(
//         userId: json["userId"],
//         channelId: json["channelId"],
//         id: json["_id"],
//         uploadContent: List<UploadContent>.from(json["uploadContent"].map((x) => UploadContent.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "userId": userId,
//         "channelId": channelId,
//         "_id": id,
//         "uploadContent": List<dynamic>.from(uploadContent.map((x) => x.toJson())),
//         "createdAt": createdAt.toIso8601String(),
//         "updatedAt": updatedAt.toIso8601String(),
//         "__v": v,
//     };
// }

// class UploadContent {
//     UploadContent({
//         required this.contentTitle,
//         required this.contentDescription,
//         required this.content,
//         required this.isActive,
//         required this.likes,
//         required this.comments,
//         required this.id,
//     });

//     final String contentTitle;
//     final String contentDescription;
//     final String content;
//     final bool isActive;
//     final int likes;
//     final List<dynamic> comments;
//     final String id;

//     factory UploadContent.fromJson(Map<String, dynamic> json) => UploadContent(
//         contentTitle: json["contentTitle"],
//         contentDescription: json["contentDescription"],
//         content: json["content"],
//         isActive: json["isActive"],
//         likes: json["likes"],
//         comments: List<dynamic>.from(json["comments"].map((x) => x)),
//         id: json["_id"],
//     );

//     Map<String, dynamic> toJson() => {
//         "contentTitle": contentTitle,
//         "contentDescription": contentDescription,
//         "content": content,
//         "isActive": isActive,
//         "likes": likes,
//         "comments": List<dynamic>.from(comments.map((x) => x)),
//         "_id": id,
//     };
// }
