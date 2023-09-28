/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Pages/LoginPage.dart';
import 'package:her_highness_salon/Pages/TermsOfServicesPage.dart';
import 'package:her_highness_salon/get_controllers/home_page_get_controller.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatelessWidget {
  static const String PageId = 'ProfilePage';

  late BuildContext context;

  HomePageGetController homePageGetController =
      Get.put(HomePageGetController());

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildProfile(),
          _buildList(Icons.book, 'Term of services', () {
            Get.to(() => TermsOfServicesPage());
          }),
          _buildList(Icons.logout, 'Logout', () {
            FirebaseAuth.instance.signOut().then((value) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            });
          }),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Column(
              children: [
                CircleAvatar(
                  radius: 40.sp,
                  backgroundImage: NetworkImage(
                      homePageGetController.currentUser.value.profilePicLink),
                ),
                Text(
                  '${homePageGetController.currentUser.value.fullName}',
                  style: TextStyle(fontFamily: 'bold', fontSize: 20),
                ),
                Text(
                  '${homePageGetController.currentUser.value.email}',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildList(icn, txt, route) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: route,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFBF8227),
                  child: Icon(
                    icn,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '$txt',
                  style: TextStyle(fontFamily: 'semibold', fontSize: 17),
                ),
              ],
            ),
            Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
