import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/appointment_model.dart';

class AppointmentPageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<int> text = [1, 2, 3, 4, 5, 6, 7];

  bool status = false;

  RxInt segmentedControlValue = 0.obs;

  RxInt tabIndex = 0.obs;

  RxList<AppointmentModel> allAppointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    super.onInit();
  }

  late TabController tabController;
}

class AppointmentDataSource extends CalendarDataSource {
  AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}
