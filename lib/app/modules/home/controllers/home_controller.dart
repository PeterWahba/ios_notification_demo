import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ios_notification/app/data/models/push_notification.dart';

class HomeController extends GetxController {
  late int totalNotifications;
  late final FirebaseMessaging messaging;
  PushNotification? notificationInfo;

  @override
  void onInit() {
    requestAndRegisterNotification();
    onMessageOpenedApp();
    totalNotifications = 0;
    // update();
    super.onInit();
  }

  void requestAndRegisterNotification() async {
    // 1. Initialize the Firebase app.
    await Firebase.initializeApp();

    // 2. Get the Firebase Messaging instance.
    messaging = FirebaseMessaging.instance;
    FirebaseMessaging.onBackgroundMessage(_firebaseMessageingBackgroundHandler);

    // 3. Request permission to send push notifications. iOS Only.
    NotificationSettings settings = await messaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granded permission to send push notifications");
      String? token = await messaging.getToken();

      // on production this token will be sent to your server.
      print("The token is : ${token!}");
      // For handling the received notifications.
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Parse the message received.
        PushNotification notification = PushNotification(
          title: message.notification?.title,
          body: message.notification?.body,
        );

        notificationInfo = notification;
        totalNotifications++;
        update();

        if (notificationInfo != null) {
          // Display notification as an overlay

          Get.snackbar(notificationInfo!.title!, notificationInfo!.body!);
        }
      });
    } else {
      print('User declined or has not accepted permission');
    }

    //
  }

  Future _firebaseMessageingBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message : ${message.messageId}');
  }

  void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
      );
      notificationInfo = notification;
      totalNotifications++;

      update();
    });
  }
}
