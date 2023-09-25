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
import 'package:her_highness_salon/Pages/OldAppointmentsTab.dart';
import 'package:her_highness_salon/Pages/OngoingAppointmentsTab.dart';

import '../get_controllers/AppointmentPageGetController.dart';

class AppointmentPage extends StatelessWidget {
  static const String PageId = 'AppointmentPage';
  AppointmentPageGetController getController =
      Get.put(AppointmentPageGetController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: TabBar(
              tabs: [
                Tab(
                  child: Obx(() {
                    return Text(
                      'Ongoing',
                      style: TextStyle(
                        fontFamily: 'regular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: getController.tabIndex.value == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
                Tab(
                  child: Obx(() {
                    return Text(
                      'Old',
                      style: TextStyle(
                        fontFamily: 'regular',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: getController.tabIndex.value == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
              onTap: (index) {
                getController.tabIndex.value = index;
              }),
          body: TabBarView(
            children: [
              OngoingAppointmentsTab(),
              OldAppointmentsTab(),
            ],
          ),
        ),
      ),
    );
  }
}
