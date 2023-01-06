import 'dart:convert';

VideoModel videoModelFromJson(String str) => VideoModel.fromJson(json.decode(str));

String videoModelToJson(VideoModel data) => json.encode(data.toJson());

class VideoModel {
    VideoModel({
        required this.videos,
    });

    List<Video> videos;

    factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
    };
}

class Video {
    Video({
        required this.description,
        required this.sources,
        required this.thumb,
        required this.title,
    });

    String description;
    String sources;
    String thumb;
    String title;

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        description: json["description"],
        sources: json["sources"],
        thumb: json["thumb"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "description": description,
        "sources": sources,
        "thumb": thumb,
        "title": title,
    };
}
