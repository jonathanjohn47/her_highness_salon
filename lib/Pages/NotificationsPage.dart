import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:her_highness_salon/get_controllers/notifications_get_controller.dart';
import 'package:her_highness_salon/helpers/date_time_helpers.dart';
import 'package:her_highness_salon/models/notification_model.dart';

class NotificationsPage extends StatelessWidget {
  NotificationsGetController notificationsGetController =
      Get.put(NotificationsGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        return ListView.builder(
          itemBuilder: (context, index) {
            NotificationModel notification =
                notificationsGetController.notifications[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(notification.title),
                          content: Text(
                              """${notification.description} \n\n ${notification.date.getHowMuchTimeAgo()}"""),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom:
                          BorderSide(width: 1.0, color: Colors.grey.shade600),
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
                                /*ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: SizedBox.fromSize(
                                      size: Size.fromRadius(25),
                                      child: FittedBox(
                                        child: Image.asset('assets/images/p1.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),*/
                                Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${notification.title}',
                                          style: TextStyle(
                                              fontFamily: 'semibold',
                                              fontSize: 15.0)),
                                      Text('${notification.description}',
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
                                  '${notification.date.getHowMuchTimeAgo()}',
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
          },
          itemCount: notificationsGetController.notifications.length,
        );
      }),
    );
  }
}
