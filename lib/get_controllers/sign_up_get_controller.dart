import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../models/user_model.dart';

class SignUpGetController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<DateTime> date = DateTime.now().obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  RxString imagePath = ''.obs;

  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();
    await picker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> saveProfile() async {
    if (formKey.currentState!.validate()) {
      if (imagePath.value.isNotEmpty) {
        final downloadUrl = await uploadImageToFirebaseStorage(imagePath.value);
        final userModel = buildUserModel(
          fullNameController.text,
          emailController.text,
          int.parse(dateOfBirthController.text),
          addressController.text,
          downloadUrl,
        );
        await saveUserModelToFirebase(userModel);
      } else {
        Get.snackbar('Error', 'Please select your profile picture',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    }
  }

  String generateUniqueId() {
    Uuid uuid = Uuid();
    return uuid.v4();
  }

  Future<String> uploadImageToFirebaseStorage(String filePath) async {
    final storageRef = FirebaseStorage.instance.ref();
    final userId = generateUniqueId();
    final imageRef = storageRef.child('Users/$userId');

    return imageRef.putFile(File(filePath)).then((uploadTask) {
      return uploadTask.ref.getDownloadURL();
    });
  }

  UserModel buildUserModel(String fullName, String email, int dateOfBirth,
      String address, String profilePicLink) {
    return UserModel(
      id: generateUniqueId(),
      fullName: fullName,
      email: email,
      dateOfBirth: dateOfBirth,
      address: address,
      profilePicLink: profilePicLink,
    );
  }

  Future<void> saveUserModelToFirebase(UserModel userModel) async {
    final databaseRef = FirebaseFirestore.instance.collection('Users');
    final userId = userModel.id;
    final userRef = databaseRef.doc('$userId');
    await userRef.set(userModel.toJson());
  }
}
