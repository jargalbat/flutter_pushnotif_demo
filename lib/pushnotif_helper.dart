import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotifHelper {
  static String pushNotifToken = '';
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  static getToken() async {
    if (Platform.isIOS) {
      _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
      _firebaseMessaging.onIosSettingsRegistered.first.then((settings) {
        if (settings.alert) {
          _firebaseMessaging.getToken().then((token) {
            pushNotifToken = token;
          });
        }
      });
    } else if (Platform.isAndroid) {
      _firebaseMessaging.getToken().then((token) {
        pushNotifToken = token;
      });
    }
  }
}
