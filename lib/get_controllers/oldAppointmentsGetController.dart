import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../core/app_constants.dart';
import '../models/appointment_model.dart';

class OldAppointmentsGetController extends GetxController {
  RxList<AppointmentModel> allAppointments = <AppointmentModel>[].obs;
  RxBool switchState = false.obs;

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

  @override
  void onInit() {
    loadAppointments();
    super.onInit();
  }
}
