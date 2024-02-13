// To parse this JSON data, do
// final gare = gareFromJson(jsonString);

import 'dart:convert';
List<GareModel> gareFromJson(String str) => List<GareModel>.from(json.decode(str).map((x) => GareModel.fromJson(x)));
String gareToJson(List<GareModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GareModel {
  
    GareModel({ required this.lieuVille, });

    String lieuVille;

    factory GareModel.fromJson(Map<String, dynamic> json) => GareModel(
        lieuVille: json["lieu_ville"],
    );

    Map<String, dynamic> toJson() => {
        "lieu_ville": lieuVille,
    };
}
