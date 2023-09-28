// To parse this JSON data, do
//
//     final chatMessageModel = chatMessageModelFromJson(jsonString);

import 'dart:convert';

ChatMessageModel chatMessageModelFromJson(String str) => ChatMessageModel.fromJson(json.decode(str));

String chatMessageModelToJson(ChatMessageModel data) => json.encode(data.toJson());

class ChatMessageModel {
  String id;
  String text;
  String userId;
  String imageLink;
  DateTime sentAt;
  bool sentByAdmin;
  bool readByAdmin;
  bool readByUser;

  ChatMessageModel({
    required this.id,
    required this.text,
    required this.userId,
    required this.imageLink,
    required this.sentAt,
    required this.sentByAdmin,
    required this.readByAdmin,
    required this.readByUser,
  });

  ChatMessageModel copyWith({
    String? id,
    String? text,
    String? userId,
    String? imageLink,
    DateTime? sentAt,
    bool? sentByAdmin,
    bool? readByAdmin,
    bool? readByUser,
  }) =>
      ChatMessageModel(
        id: id ?? this.id,
        text: text ?? this.text,
        userId: userId ?? this.userId,
        imageLink: imageLink ?? this.imageLink,
        sentAt: sentAt ?? this.sentAt,
        sentByAdmin: sentByAdmin ?? this.sentByAdmin,
        readByAdmin: readByAdmin ?? this.readByAdmin,
        readByUser: readByUser ?? this.readByUser,
      );

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) => ChatMessageModel(
    id: json["id"],
    text: json["text"],
    userId: json["user_id"],
    imageLink: json["image_link"],
    sentAt: DateTime.parse(json["sent_at"]),
    sentByAdmin: json["sent_by_admin"],
    readByAdmin: json["read_by_admin"],
    readByUser: json["read_by_user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "user_id": userId,
    "image_link": imageLink,
    "sent_at": sentAt.toIso8601String(),
    "sent_by_admin": sentByAdmin,
    "read_by_admin": readByAdmin,
    "read_by_user": readByUser,
  };
}
