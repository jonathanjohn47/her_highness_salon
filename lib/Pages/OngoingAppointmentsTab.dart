import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/Utilities/ConstancePage.dart' as style;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../get_controllers/OngoingAppointmentsGetController.dart';

class OngoingAppointmentsTab extends StatelessWidget {
  OngoingAppointmentsTab({Key? key}) : super(key: key);
  OngoingAppointmentsGetController getController =
      Get.put(OngoingAppointmentsGetController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 20.0,
                  ),
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return SfCalendar(
                  viewHeaderStyle: ViewHeaderStyle(
                      backgroundColor: Colors.white,
                      dayTextStyle: TextStyle(color: Colors.grey, fontSize: 20),
                      dateTextStyle:
                          TextStyle(color: Colors.grey, fontSize: 25)),
                  view: CalendarView.month,
                  firstDayOfWeek: 3,
                  headerStyle: CalendarHeaderStyle(textAlign: TextAlign.center),
                  initialSelectedDate: DateTime(2019, 12, 20, 12),
                  todayHighlightColor: style.appColor,
                  cellBorderColor: Colors.transparent,
                  showNavigationArrow: true,
                  showWeekNumber: true,
                  backgroundColor: Colors.orangeAccent.withOpacity(0.1),
                  selectionDecoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: style.appColor, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    shape: BoxShape.rectangle,
                  ),
                  dataSource: getController.dataSource.value,
                  monthViewSettings: MonthViewSettings(
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment),
                );
              }),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    blurRadius: 20.0,
                  ),
                ]),
            child: Column(
              children: [
                /*Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 70,
                          width: 100,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xff7c94b6),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/p6.jpg'),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                'Mint Salon Drive-in Unisex Famous',
                                overflow: TextOverflow.ellipsis,
                                style:
                                    TextStyle(fontFamily: 'bold', fontSize: 17),
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 180,
                                    child: Text(
                                      'Akshaynagar 1 Block, 1 Cross, Ramurrthy',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
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
                ),*/
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5))),
                  child: Obx(() {
                    return getController.allAppointments.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildColumnFirst()),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMMM yyyy').format(
                                          getController
                                              .allAppointments[0].from),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'bold',
                                          color: style.appColor),
                                    ),
                                    Text(
                                      DateFormat('hh:mm a').format(getController
                                              .allAppointments[0].from) +
                                          ' - ' +
                                          DateFormat('hh:mm a').format(
                                              getController
                                                  .allAppointments[0].to),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'bold',
                                          color: style.appColor),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container();
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColumnFirst() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getController.allAppointments[0].title,
            style: TextStyle(fontSize: 17, fontFamily: 'bold'),
          ),
        ],
      ),
    );
  }
}
