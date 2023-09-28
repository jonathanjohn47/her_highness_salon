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
import 'package:her_highness_salon/Pages/NotificationsPage.dart';
import 'package:her_highness_salon/Pages/ServicesInfoPage.dart';
import 'package:her_highness_salon/Pages/SpecialistInfoPage.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:her_highness_salon/get_controllers/home_page_get_controller.dart';

class DiscoverPage extends StatelessWidget {
  static const String PageId = 'DiscoverPage';

  late BuildContext context;

  HomePageGetController homePageGetController =
      Get.put(HomePageGetController());

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

  Widget _buildBody() {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          /*Row(
            children: [
              searchbar('Find a salon, specialist..'),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.filter_list,
                  size: 30,
                ),
              )
            ],
          ),*/
          _buildTitle('Our Hair Stylists'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Obx(() {
                return Row(
                  children: [
                    ...homePageGetController.hairStylists.map((e) {
                      return _buildSpecialist(
                          e.fullName, e.profilePicLink, 'Hair Stylist');
                    }).toList(),
                  ],
                );
              }),
            ),
          ),
          _buildTitle('Special Offer'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Obx(() {
                return Row(
                  children: [
                    ...homePageGetController.offers.map((e) {
                      return _buildCategories(
                          e.name, e.imageLink, e.description);
                    }).toList(),
                  ],
                );
              }),
            ),
          ),
          _buildTitle('Our Makeup Artists'),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Obx(() {
                return Row(
                  children: [
                    ...homePageGetController.makeUpArtists.map((e) {
                      return _buildSpecialist(
                          e.fullName, e.profilePicLink, 'Make Up Artist');
                    }).toList(),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(txt) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$txt',
            style: TextStyle(fontSize: 20, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100.0),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text(
                            'Hi',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Obx(() {
                            return Text(
                              homePageGetController.currentUser.value.fullName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'bold',
                                  color: style.appColor),
                            );
                          }),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                        ),
                        Obx(() {
                          return Text(
                            homePageGetController.currentUser.value.address,
                            style: TextStyle(color: Colors.grey),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications,
                          color: Colors.black,
                          size: 25,
                        ),
                        onPressed: () {
                          Get.to(() => NotificationsPage());
                        },
                      ),
                    ),
                    Positioned(
                      top: 1,
                      right: -2,
                      child: Obx(() {
                        if (homePageGetController
                                .unreadNotificationsCount.value >
                            0) {
                          return Container(
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              color: Colors.orangeAccent,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 20,
                              minHeight: 15,
                            ),
                            child: Text(
                              homePageGetController
                                  .unreadNotificationsCount.value
                                  .toString(),
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'bold',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
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

  Widget searchbar(hintText) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Container(
          height: 40,
          child: TextField(
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(color: Colors.grey.shade600),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Colors.grey.shade300,
                ),
              ),
              filled: true,
              fillColor: Colors.grey.shade300,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpecialist(txt, img, txt2) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SpecialistInfoPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('$img'),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    '$txt',
                    style: TextStyle(fontFamily: 'bold'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    '$txt2',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(txt, img, txt2) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ServicesInfoPage()));
        },
        child: Column(
          children: [
            Container(
              height: 130,
              width: 300,
              decoration: BoxDecoration(
                color: const Color(0xff7c94b6),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new AssetImage('$img'),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 17,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '4',
                            style: TextStyle(fontSize: 15),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 300,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            '$txt',
                            style: TextStyle(fontFamily: 'bold', fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            '$txt2',
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 40,
                      width: 70,
                      decoration: BoxDecoration(
                          color: style.appColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Book',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
