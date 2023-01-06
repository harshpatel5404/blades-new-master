import 'dart:convert';

SubscriptionModel subscriptionModelFromJson(String str) =>
    SubscriptionModel.fromJson(json.decode(str));

String subscriptionModelToJson(SubscriptionModel data) =>
    json.encode(data.toJson());

class SubscriptionModel {
  SubscriptionModel({
    required this.code,
    required this.success,
    required this.message,
    required this.data,
  });

  int code;
  bool success;
  String message;
  List<Subscription> data;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionModel(
        code: json["code"],
        success: json["success"],
        message: json["message"],
        data: List<Subscription>.from(
            json["data"].map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Subscription {
  Subscription({
    required this.userId,
    required this.status,
    required this.isActive,
    required this.title,
    required this.type,
    required this.validity,
    required this.features,
    required this.cost,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.subscriptionId,
  });

  List<dynamic> userId;
  bool status;
  bool isActive;
  String title;
  String type;
  String validity;
  List<String> features;
  String cost;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  String subscriptionId;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        userId: List<dynamic>.from(json["userId"].map((x) => x)),
        status: json["status"],
        isActive: json["isActive"],
        title: json["title"],
        type: json["type"],
        validity: json["validity"],
        features: List<String>.from(json["features"].map((x) => x)),
        cost: json["cost"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        subscriptionId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": List<dynamic>.from(userId.map((x) => x)),
        "status": status,
        "isActive": isActive,
        "title": title,
        "type": type,
        "validity": validity,
        "features": List<dynamic>.from(features.map((x) => x)),
        "cost": cost,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": subscriptionId,
      };
}

class UserIdClass {
  UserIdClass({
    required this.id,
    required this.currentDate,
    required this.toDate,
  });

  String id;
  DateTime currentDate;
  DateTime toDate;

  factory UserIdClass.fromJson(Map<String, dynamic> json) => UserIdClass(
        id: json["id"],
        currentDate: DateTime.parse(json["CurrentDate"]),
        toDate: DateTime.parse(json["toDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "CurrentDate": currentDate.toIso8601String(),
        "toDate": toDate.toIso8601String(),
      };
}
