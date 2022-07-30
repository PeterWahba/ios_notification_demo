import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ios_notification/app/modules/home/views/widgets/notification_badge_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notify'),
        brightness: Brightness.dark,
      ),
      body: GetBuilder<HomeController>(
        builder: (_) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'App for capturing Firebase Push Notifications',
              
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16.0),
            NotificationBadge(
                totalNotifications: controller.totalNotifications),
            SizedBox(height: 16.0),
            controller.notificationInfo != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TITLE: ${controller.notificationInfo!.title}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'BODY: ${controller.notificationInfo!.body}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
