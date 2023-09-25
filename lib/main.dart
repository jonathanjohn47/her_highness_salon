/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Pages/AppointmentPage.dart';
import 'package:her_highness_salon/Pages/ChatPage.dart';
import 'package:her_highness_salon/Pages/DiscoverPage.dart';
import 'package:her_highness_salon/Pages/EditProfilePage.dart';
import 'package:her_highness_salon/Pages/ForgotPasswordPage.dart';
import 'package:her_highness_salon/Pages/InviteFriendPage.dart';
import 'package:her_highness_salon/Pages/LoginPage.dart';
import 'package:her_highness_salon/Pages/MessagePage.dart';
import 'package:her_highness_salon/Pages/NearByPage.dart';
import 'package:her_highness_salon/Pages/ProfilePage.dart';
import 'package:her_highness_salon/Pages/RegisterPage.dart';
import 'package:her_highness_salon/Pages/SpecialistInfoPage.dart';
import 'package:her_highness_salon/Pages/TabsBarPage.dart';
import 'package:her_highness_salon/Pages/VideoCallPage.dart';
import 'package:her_highness_salon/Pages/WelcomePage.dart';
import 'package:sizer/sizer.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.black, // status bar color
  ));
  runApp(const salon1AppCapacitor());
}

class salon1AppCapacitor extends StatelessWidget {
  const salon1AppCapacitor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Salon 1',
        theme:
            ThemeData(fontFamily: 'regular', primaryColor: Color(0xFFBF8227)),
        home: WelcomePage(),
        debugShowCheckedModeBanner: false,
        routes: {
          WelcomePage.PageId: (context) => WelcomePage(),
          LoginPage.PageId: (context) => LoginPage(),
          ForgotPasswordPage.PageId: (context) => ForgotPasswordPage(),
          RegisterPage.PageId: (context) => RegisterPage(),
          tabsBarPage.PageId: (context) => tabsBarPage(),
          DiscoverPage.PageId: (context) => DiscoverPage(),
          NearByPage.PageId: (context) => NearByPage(),
          AppointmentPage.PageId: (context) => AppointmentPage(),
          MessagePage.PageId: (context) => MessagePage(),
          ChatPage.PageId: (context) => ChatPage(),
          ProfilePage.PageId: (context) => ProfilePage(),
          VideoCallPage.PageId: (context) => VideoCallPage(),
          EditProfilePage.PageId: (context) => EditProfilePage(),
          InviteFriendPage.PageId: (context) => InviteFriendPage(),
          SpecialistInfoPage.PageId: (context) => SpecialistInfoPage(),
        },
      );
    });
  }
}
