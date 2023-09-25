import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentPageGetController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<int> text = [1, 2, 3, 4, 5, 6, 7];
  late _AppointmentDataSource? dataSource;

  bool status = false;

  RxInt segmentedControlValue = 0.obs;

  RxInt tabIndex = 0.obs;

  @override
  void onInit() {
    List<Appointment> appointments = <Appointment>[];
    appointments.add(Appointment(
      startTime: DateTime.now().add(const Duration(days: 1)),
      endTime: DateTime.now().add(const Duration(days: 3)),
      subject: 'Meeting',
      color: Colors.orangeAccent,
      startTimeZone: '',
      endTimeZone: '',
      recurrenceRule: 'FREQ=DAILY;INTERVAL=2;COUNT=5',
    ));
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      tabIndex.value = tabController.index;
    });
    dataSource = _AppointmentDataSource(appointments);
    super.onInit();
  }

  late TabController tabController;
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}