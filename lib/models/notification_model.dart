// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  String id;
  String title;
  String description;
  DateTime date;
  String imageLink;
  bool read;

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.imageLink,
    required this.read,
  });

  NotificationModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    String? imageLink,
    bool? read,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        date: date ?? this.date,
        imageLink: imageLink ?? this.imageLink,
        read: read ?? this.read,
      );

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    date: DateTime.parse(json["date"]),
    imageLink: json["image_link"],
    read: json["read"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "date": date.toIso8601String(),
    "image_link": imageLink,
    "read": read,
  };
}
