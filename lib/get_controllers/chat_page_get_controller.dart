import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/core/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/chat_message_model.dart';

class ChatPageGetController extends GetxController {
  TextEditingController messageController = TextEditingController();

  RxList<ChatMessageModel> allMessages = <ChatMessageModel>[].obs;

  RxString messageImage = ''.obs;

  late StreamSubscription messageListen;

  void loadMessages() {
    messageListen = FirebaseFirestore.instance
        .collection(AppConstants.messages)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.messages)
        .orderBy('sent_at', descending: true)
        .snapshots()
        .listen((event) {
      allMessages.value =
          event.docs.map((e) => ChatMessageModel.fromJson(e.data())).toList();
      allMessages.sort((a, b) => a.sentAt.compareTo(b.sentAt));
      markAllMessagesAsReadByUser();
    });
  }

  void getImage() {
    ImagePicker picker = ImagePicker();
    picker
        .pickImage(source: ImageSource.gallery, imageQuality: 33)
        .then((value) {
      if (value != null) {
        messageImage.value = value.path;
      }
    });
  }

  Future<void> sendMessage() async {
    // Create a unique message id
    final String messageId = Uuid().v4();

    // If the message image is not empty, upload it to FirebaseStorage
    if (messageImage.isNotEmpty) {
      final storageRef = FirebaseStorage.instance.ref(
          '${AppConstants.messages}/${FirebaseAuth.instance.currentUser!.uid}/${messageId}');
      final uploadTask = storageRef.putFile(File(messageImage.value));

      // Get the download url of the uploaded image
      uploadTask.then((snapshot) async {
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Create a ChatMessageModel object with the download url
        final ChatMessageModel message = ChatMessageModel(
          id: messageId,
          text: messageController.text,
          userId: FirebaseAuth.instance.currentUser!.uid,
          imageLink: downloadUrl,
          sentAt: DateTime.now(),
          sentByAdmin: false,
          readByAdmin: false,
          readByUser: true,
        );

        // Store the ChatMessageModel object in Firestore
        await FirebaseFirestore.instance
            .collection(AppConstants.messages)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          AppConstants.lastMessage: message.toJson(),
        });
        await FirebaseFirestore.instance
            .collection(AppConstants.messages)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppConstants.messages)
            .doc(messageId)
            .set(message.toJson());
      });
    } else {
      // Create a ChatMessageModel object with an empty image link
      final ChatMessageModel message = ChatMessageModel(
        id: messageId,
        text: messageController.text,
        userId: FirebaseAuth.instance.currentUser!.uid,
        imageLink: '',
        sentAt: DateTime.now(),
        sentByAdmin: false,
        readByAdmin: false,
        readByUser: true,
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.messages)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) async {
        if (value.exists) {
          await FirebaseFirestore.instance
              .collection(AppConstants.messages)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({AppConstants.lastMessage: message.toJson()});
          // Store the ChatMessageModel object in Firestore
          await FirebaseFirestore.instance
              .collection(AppConstants.messages)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConstants.messages)
              .doc(messageId)
              .set(message.toJson());
        } else {
          await FirebaseFirestore.instance
              .collection(AppConstants.messages)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set({AppConstants.lastMessage: message.toJson()});
          // Store the ChatMessageModel object in Firestore
          await FirebaseFirestore.instance
              .collection(AppConstants.messages)
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection(AppConstants.messages)
              .doc(messageId)
              .set(message.toJson());
        }
      });
    }

    // Clear all the fields
    messageController.text = '';
    messageImage.value = '';
  }

  void markAllMessagesAsReadByUser() {
    for (ChatMessageModel message in allMessages) {
      if (!message.readByUser) {
        message = message.copyWith(readByUser: true);

        FirebaseFirestore.instance
            .collection(AppConstants.messages)
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection(AppConstants.messages)
            .doc(message.id)
            .update(message.toJson());
      }
    }
    final ChatMessageModel lastMessage = allMessages.last;

    // Update the last message in Firestore
    FirebaseFirestore.instance
        .collection(AppConstants.messages)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({AppConstants.lastMessage: lastMessage.toJson()});
  }

  @override
  void onInit() {
    loadMessages();
    super.onInit();
  }

  @override
  void onClose() {
    messageListen.cancel();
    super.onClose();
  }
}
