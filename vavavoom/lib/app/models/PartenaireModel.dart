import 'dart:convert';

List<PartenaireModel> partenaireModelFromJson(String str) => List<PartenaireModel>.from(json.decode(str).map((x) => PartenaireModel.fromJson(x)));

String partenaireModelToJson(List<PartenaireModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PartenaireModel {
  
    PartenaireModel({
        required this.id,
        required this.imageIllustration,
        this.lienIllustration,
        required this.url,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String imageIllustration;
    dynamic lienIllustration;
    String url;
    DateTime createdAt;
    DateTime updatedAt;
 
    factory PartenaireModel.fromJson(Map<String, dynamic> json) => PartenaireModel(
        id: json["id"],
        imageIllustration: json["image_illustration"],
        lienIllustration: json["lien_illustration"],
        url: json["url"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_illustration": imageIllustration,
        "lien_illustration": lienIllustration,
        "url": url,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
    };
}
