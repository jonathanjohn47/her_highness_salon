/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Pages/LoginPage.dart';
import 'package:her_highness_salon/Pages/TabsBarPage.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:sizer/sizer.dart';

import '../get_controllers/sign_up_get_controller.dart';

class RegisterPage extends StatelessWidget {
  static const String PageId = 'RegisterPage';

  late BuildContext context;
  SignUpGetController signUpGetController = Get.put(SignUpGetController());

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        'Create New Account',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      reverse: true,
      child: Center(
        child: Form(
          key: signUpGetController.formKey,
          child: Column(
            children: [
              _buildContentFields('Full Name', Icon(Icons.person),
                  signUpGetController.fullNameController),
              _buildContentFields('Email', Icon(Icons.email),
                  signUpGetController.emailController),
              _buildContentFields('Password', Icon(Icons.lock),
                  signUpGetController.passwordController),
              _buildDateAndTime(),
              _buildContentFields('Your Address', Icon(Icons.location_on),
                  signUpGetController.addressController),
              _buildPhotoUploadField(),
              _buildSignUpButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentFields(txt, icn, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$txt',
            style: TextStyle(fontSize: 15, fontFamily: 'bold'),
          ),
          Container(
            width: double.infinity,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                suffixIcon: icn,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.only(bottom: 8.0, top: 14.0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateAndTime() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date Of Birth',
              style: TextStyle(fontSize: 15, fontFamily: 'bold'),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.5, color: Colors.black),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: Icon(Icons.add),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          initialDate: signUpGetController.date.value,
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          helpText: 'Select Your Birth Date',
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.light(
                                  primary:
                                      style.appColor, // header background color
                                  onPrimary: Colors.black, // header text color
                                  onSurface: Colors.black, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                    primary:
                                        style.appColor, // button text color
                                  ),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (newDate == null) return;
                        signUpGetController.date.value = newDate;
                      },
                      label: Obx(() {
                        return Text(
                          '${signUpGetController.date.value.day}/${signUpGetController.date.value.month}/${signUpGetController.date.value.year}',
                        );
                      }),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 13),
                      child: Icon(
                        Icons.calendar_today,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: InkWell(
            onTap: () {
              signUpGetController.saveProfile().then((value) {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    tabsBarPage.PageId, (route) => false);
              });
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 13.0),
              decoration: style.contentButtonStyle(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white, fontSize: 17, fontFamily: 'bold'),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account ?',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                width: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 15, color: style.appColor),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhotoUploadField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
      child: ListTile(
        leading: Obx(() {
          return signUpGetController.imagePath.value.isNotEmpty
              ? CircleAvatar(
                  radius: 40.sp,
                  backgroundImage:
                      FileImage(File(signUpGetController.imagePath.value)),
                )
              : Text(
                  'No Image\nSelected',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w600),
                );
        }),
        trailing: IconButton(
          icon: Icon(Icons.camera_alt),
          onPressed: () {
            signUpGetController.getImage();
          },
        ),
      ),
    );
  }
}
