// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'dart:convert';

import 'user_model.dart';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  String id;
  String title;
  UserModel userModel;
  DateTime from;
  DateTime to;
  bool finished;
  bool cancelled;
  bool readByAdmin;

  AppointmentModel({
    required this.id,
    required this.title,
    required this.userModel,
    required this.from,
    required this.to,
    required this.finished,
    required this.cancelled,
    required this.readByAdmin,
  });

  AppointmentModel copyWith({
    String? id,
    String? title,
    UserModel? userModel,
    DateTime? from,
    DateTime? to,
    bool? finished,
    bool? cancelled,
    bool? readByAdmin,
  }) =>
      AppointmentModel(
        id: id ?? this.id,
        title: title ?? this.title,
        userModel: userModel ?? this.userModel,
        from: from ?? this.from,
        to: to ?? this.to,
        finished: finished ?? this.finished,
        cancelled: cancelled ?? this.cancelled,
        readByAdmin: readByAdmin ?? this.readByAdmin,
      );

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        id: json["id"],
        title: json["title"],
        userModel: UserModel.fromJson(json["user_model"]),
        from: DateTime.parse(json["from"]),
        to: DateTime.parse(json["to"]),
        finished: json["finished"],
        cancelled: json["cancelled"],
        readByAdmin: json["read_by_admin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "user_model": userModel.toJson(),
        "from": from.toIso8601String(),
        "to": to.toIso8601String(),
        "finished": finished,
        "cancelled": cancelled,
        "read_by_admin": readByAdmin,
      };
}
