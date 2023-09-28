// To parse this JSON data, do
//
//     final offerModel = offerModelFromJson(jsonString);

import 'dart:convert';

OfferModel offerModelFromJson(String str) => OfferModel.fromJson(json.decode(str));

String offerModelToJson(OfferModel data) => json.encode(data.toJson());

class OfferModel {
  String id;
  String name;
  String description;
  String imageLink;

  OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageLink,
  });

  OfferModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageLink,
  }) =>
      OfferModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageLink: imageLink ?? this.imageLink,
      );

  factory OfferModel.fromJson(Map<String, dynamic> json) => OfferModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    imageLink: json["image_link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image_link": imageLink,
  };
}
