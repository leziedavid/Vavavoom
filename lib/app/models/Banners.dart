// To parse this JSON data, do
//
//     final bannerModel = bannerModelFromJson(jsonString);

import 'dart:convert';

List<BannerModel> bannerModelFromJson(String str) => List<BannerModel>.from(json.decode(str).map((x) => BannerModel.fromJson(x)));

String bannerModelToJson(List<BannerModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerModel {
    int id;
    String bannerName;
    String bannerPath;
    int national;
    dynamic international;
    DateTime createdAt;
    DateTime updatedAt;

    BannerModel({
        required this.id,
        required this.bannerName,
        required this.bannerPath,
        required this.national,
        required this.international,
        required this.createdAt,
        required this.updatedAt,
    });

    factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        id: json["id"],
        bannerName: json["banner_name"],
        bannerPath: json["banner_path"],
        national: json["national"],
        international: json["international"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "banner_name": bannerName,
        "banner_path": bannerPath,
        "national": national,
        "international": international,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
