import 'package:flutter/material.dart';

import 'package:get/get.dart';

class NotificationBadge extends GetView {
  final int totalNotifications;

  NotificationBadge({required this.totalNotifications});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            totalNotifications.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
