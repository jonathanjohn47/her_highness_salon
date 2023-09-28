import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/core/app_constants.dart';

import '../models/notification_model.dart';

class NotificationsGetController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  late StreamSubscription notificationListen;

  void loadNotifications() {
    notificationListen = FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.notifications)
        .snapshots()
        .listen((event) {
      notifications.value =
          event.docs.map((e) => NotificationModel.fromJson(e.data())).toList();
    });
  }

  @override
  void onInit() {
    loadNotifications();
    super.onInit();
  }

  @override
  void onClose() {
    notificationListen.cancel();
    super.onClose();
  }
}
