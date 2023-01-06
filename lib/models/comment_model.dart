import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
    CommentModel({
        required this.code,
        required this.success,
        required this.message,
        required this.data,
    });

    final int? code;
    final bool? success;
    final String? message;
    final List<CommentDatum>? data;

    factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        code: json["code"] == null ? null : json["code"],
        success: json["success"] == null ? null : json["success"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<CommentDatum>.from(json["data"].map((x) => CommentDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "success": success == null ? null : success,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CommentDatum {
    CommentDatum({
        required this.comments,
        required this.userDetails,
    });

    final Comments? comments;
    final UserDetails? userDetails;

    factory CommentDatum.fromJson(Map<String, dynamic> json) => CommentDatum(
        comments: json["comments"] == null ? null : Comments.fromJson(json["comments"]),
        userDetails: json["userDetails"] == null ? null : UserDetails.fromJson(json["userDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "comments": comments == null ? null : comments!.toJson(),
        "userDetails": userDetails == null ? null : userDetails!.toJson(),
    };
}

class Comments {
    Comments({
        required this.comment,
        required this.userId,
        required this.id,
    });

    final String? comment;
    final String? userId;
    final String? id;

    factory Comments.fromJson(Map<String, dynamic> json) => Comments(
        comment: json["comment"] == null ? null : json["comment"],
        userId: json["userID"] == null ? null : json["userID"],
        id: json["_id"] == null ? null : json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "comment": comment == null ? null : comment,
        "userID": userId == null ? null : userId,
        "_id": id == null ? null : id,
    };
}

class UserDetails {
    UserDetails({
        required this.role,
        required this.isActive,
        required this.status,
        required this.verified,
        required this.deviceToken,
        required this.subscriptionId,
        required this.profileImage,
        required this.bio,
        required this.otherDetails,
        required this.id,
        required this.location,
        required this.channelList,
        required this.name,
        required this.email,
        required this.phone,
        required this.otp,
        required this.createdAt,
        required this.updatedAt,
        required this.userDetailsId,
    });

    final String? role;
    final bool? isActive;
    final bool? status;
    final bool? verified;
    final dynamic deviceToken;
    final String? subscriptionId;
    final String? profileImage;
    final String? bio;
    final String? otherDetails;
    final String? id;
    final Location? location;
    final List<dynamic>? channelList;
    final String? name;
    final String? email;
    final String? phone;
    final int? otp;
    final DateTime? createdAt;
    final DateTime? updatedAt;
    final String? userDetailsId;

    factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        role: json["role"] == null ? null : json["role"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        status: json["status"] == null ? null : json["status"],
        verified: json["verified"] == null ? null : json["verified"],
        deviceToken: json["device_token"],
        subscriptionId: json["subscriptionId"] == null ? null : json["subscriptionId"],
        profileImage: json["profileImage"] == null ? null : json["profileImage"],
        bio: json["bio"] == null ? null : json["bio"],
        otherDetails: json["otherDetails"] == null ? null : json["otherDetails"],
        id: json["_id"] == null ? null : json["_id"],
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        channelList: json["channelList"] == null ? null : List<dynamic>.from(json["channelList"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        phone: json["phone"] == null ? null : json["phone"],
        otp: json["otp"] == null ? null : json["otp"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        userDetailsId: json["id"] == null ? null : json["id"],
    );

    Map<String, dynamic> toJson() => {
        "role": role == null ? null : role,
        "isActive": isActive == null ? null : isActive,
        "status": status == null ? null : status,
        "verified": verified == null ? null : verified,
        "device_token": deviceToken,
        "subscriptionId": subscriptionId == null ? null : subscriptionId,
        "profileImage": profileImage == null ? null : profileImage,
        "bio": bio == null ? null : bio,
        "otherDetails": otherDetails == null ? null : otherDetails,
        "_id": id == null ? null : id,
        "location": location == null ? null : location!.toJson(),
        "channelList": channelList == null ? null : List<dynamic>.from(channelList!.map((x) => x)),
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "phone": phone == null ? null : phone,
        "otp": otp == null ? null : otp,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "id": userDetailsId == null ? null : userDetailsId,
    };
}

class Location {
    Location({
        required this.coordinates,
    });

    final List<dynamic>? coordinates;

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        coordinates: json["coordinates"] == null ? null : List<dynamic>.from(json["coordinates"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
    };
}
