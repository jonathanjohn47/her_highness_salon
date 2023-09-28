import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/app_constants.dart';

class LoginGetController extends GetxController {
  RxBool showPassword = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      // Sign in with the temporary email and password.
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: AppConstants.emailForTemporaryLogin,
          password: AppConstants.passwordForTemporaryLogin);

      // Check if the user's email exists in the "Users" collection.
      final userExists = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .where("email", isEqualTo: emailFieldController.text)
          .get()
          .then((value) => value.docs.isNotEmpty);

      if (userExists) {
        // Sign in the user with the entered email and password.
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailFieldController.text,
            password: passwordFieldController.text);

        // The user has successfully logged in.
      } else {
        throw Exception("The user does not exist.");
      }
    }
  }
}
