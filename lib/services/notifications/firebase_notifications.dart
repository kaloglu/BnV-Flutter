import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  static FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
//  static final DBServiceAdapter _firestoreDB = DBServiceAdapter();

  final StreamController<String> _onTokenChangedController = StreamController<String>();
  StreamSubscription<String> _onTokenRefresh;

  void setup() {
    fcmListeners();
    // Observable<String>.merge was considered here, but we need more fine grained control to ensure
    // that only events from the currently active service are processed
    _onTokenRefresh = _firebaseMessaging.onTokenRefresh.listen((token) {
      _onTokenChangedController.add(token);
    });
  }

  Stream<String> get onTokenChanged => _onTokenChangedController.stream;

  void dispose() {
    _onTokenRefresh?.cancel();
    _onTokenChangedController?.close();
  }

  void fcmListeners() {
    if (Platform.isIOS) iosPermission();

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iosPermission() {
    _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  static Future<String> getToken() => _firebaseMessaging.getToken();

//  static void sendToken({String uid}) async {
//    String token = await getToken();
//    if (token != null) {
//      _firestoreDB.saveToken(uid, token);
//    }
//  }
}
