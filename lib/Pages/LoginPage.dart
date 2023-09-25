/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Pages/ForgotPasswordPage.dart';
import 'package:her_highness_salon/Pages/RegisterPage.dart';
import 'package:her_highness_salon/Pages/TabsBarPage.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:sizer/sizer.dart';

import '../get_controllers/LoginGetController.dart';

class LoginPage extends StatelessWidget {
  static const String PageId = 'LoginPage';
  LoginGetController loginGetController = Get.put(LoginGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: style.appColor,
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(bottom: 40),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: SizedBox.fromSize(
                          size: Size.fromRadius(100),
                          child: FittedBox(
                            child: Image.asset(
                                'assets/images/WhatsApp Image 2023-09-21 at 4.11.42 PM.jpeg'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -20,
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50))),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: TextButton(
                      onPressed: () {
                        loginGetController.loginAsAdmin.value =
                            !loginGetController.loginAsAdmin.value;
                      },
                      child: Obx(() {
                        return Text(
                          'Login as Admin',
                          style: TextStyle(
                              color: loginGetController.loginAsAdmin.value
                                  ? Colors.green
                                  : Colors.white,
                              fontSize: 14.sp,
                              fontFamily: 'bold'),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(fontSize: 15, fontFamily: 'bold'),
                          ),
                          Container(
                            width: double.infinity,
                            child: TextField(
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.only(
                                    bottom: 8.0, top: 14.0),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueAccent),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: TextStyle(fontSize: 15, fontFamily: 'bold'),
                          ),
                          Container(
                            width: double.infinity,
                            child: Obx(() {
                              return TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      !loginGetController.showPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: style.appColor,
                                    ),
                                    onPressed: () {
                                      loginGetController.showPassword.value =
                                          !loginGetController
                                              .showPassword.value;
                                    },
                                  ),
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.only(
                                      bottom: 8.0, top: 14.0),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
                                ),
                                obscureText:
                                    !loginGetController.showPassword.value,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordPage()));
                          },
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(color: style.appColor),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0.0, vertical: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              tabsBarPage.PageId, (route) => false);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 13.0),
                          decoration: style.contentButtonStyle(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Log In',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'bold'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.black12),
                                ),
                              ),
                            ),
                            Text(
                              'or sign in with',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey),
                            ),
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.black12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.facebook_rounded,
                                color: Color(0xFF4867AA),
                                size: 40,
                              ),
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  EvaIcons.twitter,
                                  color: Color(0xFF1DA1F2),
                                  size: 40,
                                )),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  EvaIcons.google,
                                  color: Color(0xFFdb3236),
                                  size: 40,
                                )),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have account ?',
                                style: TextStyle(fontSize: 15),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterPage()));
                                },
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 15, color: style.appColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
