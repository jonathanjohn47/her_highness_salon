import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../core/app_constants.dart';
import '../models/appointment_model.dart';
import 'AppointmentPageGetController.dart';

class OngoingAppointmentsGetController extends GetxController {
  List<int> text = [1, 2, 3, 4, 5, 6, 7];
  Rx<AppointmentDataSource> dataSource =
      AppointmentDataSource(<Appointment>[]).obs;

  bool status = false;

  RxInt segmentedControlValue = 0.obs;

  RxList<AppointmentModel> allAppointments = <AppointmentModel>[].obs;

  @override
  void onInit() {
    List<Appointment> appointments = <Appointment>[];
    allAppointments.forEach((appointmentModel) {
      appointments.add(Appointment(
        startTime: appointmentModel.from,
        endTime: appointmentModel.to,
        subject: appointmentModel.title,
        color: Colors.blueAccent.shade700,
        startTimeZone: 'Asia/Kolkata',
        endTimeZone: 'Asia/Kolkata',
        recurrenceRule: 'FREQ=WEEKLY;INTERVAL=1;BYDAY=MO,WE,FR',
      ));
    });

    dataSource.value = AppointmentDataSource(appointments);
    super.onInit();
  }

  Future<void> loadAppointments() async {
    await FirebaseFirestore.instance
        .collection(AppConstants.users)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(AppConstants.appointments)
        .get()
        .then((value) {
      allAppointments.value =
          value.docs.map((e) => AppointmentModel.fromJson(e.data())).toList();
      allAppointments.sort((a, b) => a.from.compareTo(b.from));
    });
  }
}
