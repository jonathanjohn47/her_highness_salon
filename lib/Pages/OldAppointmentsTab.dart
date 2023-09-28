import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:her_highness_salon/models/appointment_model.dart';
import 'package:intl/intl.dart';

import '../get_controllers/oldAppointmentsGetController.dart';

class OldAppointmentsTab extends StatelessWidget {
  OldAppointmentsTab({Key? key}) : super(key: key);

  OldAppointmentsGetController getController =
      Get.put(OldAppointmentsGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(() {
      return ListView.builder(
        itemBuilder: (context, index) {
          AppointmentModel appointment = getController.allAppointments[index];
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _buildColumnFirst(appointment)),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy')
                                  .format(appointment.from),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'bold',
                                  color: style.appColor),
                            ),
                            Text(
                              DateFormat('hh:mm a').format(appointment.from) +
                                  ' - ' +
                                  DateFormat('hh:mm a').format(appointment.to),
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'bold',
                                  color: style.appColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: getController.allAppointments.length,
      );
    }));
  }

  Widget _buildColumnFirst(AppointmentModel appointment) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            appointment.title,
            style: TextStyle(fontSize: 17, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }
}
