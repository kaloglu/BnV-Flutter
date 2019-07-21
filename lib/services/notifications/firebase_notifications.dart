import 'dart:async';
import 'dart:io';

import 'package:bnv/services/db/firestore_service_adapter.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final DBServiceAdapter _firestoreDB = DBServiceAdapter();

  FirebaseNotifications() {
    _setup();
  }

  final StreamController<String> _onTokenChangedController = StreamController<String>();
  StreamSubscription<String> _onTokenRefresh;

  StreamSubscription iosSubscription;

  void _setup() {
    fcmListeners();
    // Observable<String>.merge was considered here, but we need more fine grained control to ensure
    // that only events from the currently active service are processed
    _onTokenRefresh = _firebaseMessaging.onTokenRefresh.listen((token) {
      _onTokenChangedController.add(token);
    });
  }

//  void _setup() {
//    _firebaseMessaging = FirebaseMessaging();
//  }
  @override
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
    iosSubscription = _firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  Future<String> getToken() => _firebaseMessaging.getToken();

  void sendToken({String uid}) async {
    String token = await getToken();
    if (token != null) {
      _firestoreDB.sendToken(uid, token);
    }
  }
}
