import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/core/app_constants.dart';
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
    await picker
        .pickImage(source: ImageSource.camera, imageQuality: 33)
        .then((value) {
      if (value != null) {
        imagePath.value = value.path;
      }
    });
  }

  Future<void> saveProfile() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: AppConstants.emailForTemporaryLogin,
        password: AppConstants.passwordForTemporaryLogin);
    // Check if user exists in FirebaseFirestore
    bool userDocExists = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: emailController.text)
        .get()
        .then((value) => value.docs.isNotEmpty);

    FirebaseAuth.instance.signOut();
    // If user exists, display an error message
    if (userDocExists) {
      Get.snackbar('Error', 'User with that email already exists',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // If user does not exist, proceed with saving the profile
    if (formKey.currentState!.validate()) {
      if (imagePath.value.isNotEmpty) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        final downloadUrl = await uploadImageToFirebaseStorage(imagePath.value);

        UserModel userModel = buildUserModel(
          credential.user!.uid,
          fullNameController.text,
          emailController.text,
          date.value,
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

  UserModel buildUserModel(String id, String fullName, String email,
      DateTime dateOfBirth, String address, String profilePicLink) {
    return UserModel(
      id: id,
      fullName: fullName,
      email: email,
      dateOfBirth: dateOfBirth,
      address: address,
      profilePicLink: profilePicLink, fcmToken: '',
    );
  }

  Future<void> saveUserModelToFirebase(UserModel userModel) async {
    final databaseRef = FirebaseFirestore.instance.collection('Users');
    final userId = userModel.id;
    final userRef = databaseRef.doc('$userId');
    await userRef.set(userModel.toJson());
  }
}
