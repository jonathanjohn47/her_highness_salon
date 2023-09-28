// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String id;
  String fullName;
  String email;
  DateTime dateOfBirth;
  String address;
  String profilePicLink;
  String fcmToken;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.dateOfBirth,
    required this.address,
    required this.profilePicLink,
    required this.fcmToken,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    DateTime? dateOfBirth,
    String? address,
    String? profilePicLink,
    String? fcmToken,
  }) =>
      UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        address: address ?? this.address,
        profilePicLink: profilePicLink ?? this.profilePicLink,
        fcmToken: fcmToken ?? this.fcmToken,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        address: json["address"],
        profilePicLink: json["profile_pic_link"],
        fcmToken: json["fcm_token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "date_of_birth": dateOfBirth.toIso8601String(),
        "address": address,
        "profile_pic_link": profilePicLink,
        "fcm_token": fcmToken,
      };

  factory UserModel.empty() => UserModel(
        id: '',
        fullName: '',
        email: '',
        dateOfBirth: DateTime.now(),
        address: '',
        profilePicLink: '',
        fcmToken: '',
      );
}
