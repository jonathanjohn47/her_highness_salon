import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../core/app_constants.dart';

class LoginGetController extends GetxController {
  RxBool loginAsAdmin = false.obs;

  RxBool showPassword = false.obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailFieldController = TextEditingController();
  final TextEditingController passwordFieldController = TextEditingController();

  void login() {
    if (formKey.currentState!.validate()) {
      // Sign in with the temporary email and password.
      FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: AppConstants.emailForTemporaryLogin,
              password: AppConstants.passwordForTemporaryLogin)
          .then((userCredential) async {
        // Check if the user's email exists in the "Users" collection.
        final userExists = await FirebaseFirestore.instance
            .collection("Users")
            .where("email", isEqualTo: emailFieldController.text)
            .get()
            .then((value) => value.docs.isNotEmpty);

        if (userExists) {
          // Sign in the user with the entered email and password.
          FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: emailFieldController.text,
                  password: passwordFieldController.text)
              .then((userCredential) {
            // The user has successfully logged in.
          }).catchError((error) {
            // Handle the error.
          });
        } else {
          // The user's email does not exist in the "Users" collection.
        }
      }).catchError((error) {
        // Handle the error.
      });
    }
  }
}
