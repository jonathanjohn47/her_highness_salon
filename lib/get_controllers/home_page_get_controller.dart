import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/core/app_constants.dart';
import 'package:her_highness_salon/models/offer_model.dart';

import '../models/user_model.dart';

class HomePageGetController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;

  RxList<UserModel> hairStylists = <UserModel>[].obs;
  RxList<UserModel> makeUpArtists = <UserModel>[].obs;
  RxList<OfferModel> offers = <OfferModel>[].obs;

  RxInt unreadNotificationsCount = 0.obs;

  Future<void> loadCurrentUser() async {
    final userSnapshot = await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    currentUser.value = UserModel.fromJson(userSnapshot.data()!);
  }

  Future<void> loadHairStylists() async {
    final hairStylistsSnapshot = await FirebaseFirestore.instance
        .collection(AppConstants.hairStylists)
        .get();

    hairStylists.value = hairStylistsSnapshot.docs
        .map((e) => UserModel.fromJson(e.data()))
        .toList();
  }

  Future<void> loadMakeUpArtists() async {
    final makeUpArtistsSnapshot = await FirebaseFirestore.instance
        .collection(AppConstants.makeUpArtists)
        .get();

    makeUpArtists.value = makeUpArtistsSnapshot.docs
        .map((e) => UserModel.fromJson(e.data()))
        .toList();
  }

  Future<void> loadOffers() async {
    final offersSnapshot =
        await FirebaseFirestore.instance.collection(AppConstants.offers).get();

    offers.value =
        offersSnapshot.docs.map((e) => OfferModel.fromJson(e.data())).toList();
  }

  late StreamSubscription<QuerySnapshot> notificationListen;

  void getUnreadNotificationsCount() {
    notificationListen = FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.notifications)
        .where('read', isEqualTo: false)
        .snapshots()
        .listen((event) {
      unreadNotificationsCount.value = event.docs.length;
    });
  }

  void saveFcmToken() {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({'fcm_token': value});
    });
  }

  @override
  void onInit() {
    loadCurrentUser();
    loadHairStylists();
    loadMakeUpArtists();
    loadOffers();
    saveFcmToken();
    getUnreadNotificationsCount();

    super.onInit();
  }

  @override
  void onClose() {
    notificationListen.cancel();
    super.onClose();
  }
}
