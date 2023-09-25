/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Flutter UI Kit
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2021-present initappz.
*/
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Pages/ChatPage.dart';
import 'package:her_highness_salon/get_controllers/LoginGetController.dart';

class MessagePage extends StatelessWidget {
  static const String PageId = 'MessagePage';

  late BuildContext context;

  LoginGetController loginGetController = Get.put(LoginGetController());

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Obx(() {
      return loginGetController.loginAsAdmin.value
          ? SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: Container(
                        height: 40,
                        child: TextField(
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.search),
                            hintStyle: TextStyle(color: Colors.grey.shade600),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                          ),
                        ),
                      ),
                    ),
                    _buildContent1('Rahul Jograna', 'Hi there..', 'Now',
                        Image.asset('assets/images/p1.jpg')),
                    _buildContent1('Jaydeep Hirani', 'Hello..', 'Yesterday',
                        Image.asset('assets/images/p5.jpg')),
                    _buildContent1('Hardik Rajput', 'How are you buddy..',
                        'Yesterday', Image.asset('assets/images/p4.jpg')),
                    _buildContent1('Shailly Acharya', 'Nice..', 'Yesterday',
                        Image.asset('assets/images/p6.jpg')),
                    _buildContent1('Mausam Chavda', 'Fine..', 'Yesterday',
                        Image.asset('assets/images/p1.jpg')),
                    _buildContent1('Darshan Vala', 'Wow so cut..', 'Yesterday',
                        Image.asset('assets/images/p3.jpg')),
                    _buildContent1('Devang Rathod', 'Where You Now..',
                        'Yesterday', Image.asset('assets/images/p6.jpg')),
                  ],
                ),
              ),
            )
          : ChatPage();
    });
  }

  Widget _buildContent1(txt1, txt2, txt3, img) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatPage()));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey.shade600),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // First Container
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(25),
                            child: FittedBox(
                              child: img,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$txt1',
                                  style: TextStyle(
                                      fontFamily: 'semibold', fontSize: 15.0)),
                              Text('$txt2',
                                  style: TextStyle(
                                      fontFamily: 'semibold',
                                      fontSize: 10.0,
                                      color: Colors.grey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // badge column
                    Column(
                      children: [
                        Text(
                          '$txt3',
                          style: TextStyle(
                              fontFamily: 'semibold',
                              fontSize: 10.0,
                              color: Colors.grey),
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
