import 'dart:async';
import 'package:flutter/foundation.dart';

// BNV-004D stub: Eski FirebaseMessaging API kaldırıldı. Bu sınıf, derlemeyi bozmayacak
// şekilde geçici bir yer tutucudur. Gerçek FCM entegrasyonu BNV-205 kapsamında yenilenecek.
class FirebaseNotifications {
  final StreamController<String> _onTokenChangedController = StreamController<String>.broadcast();
  StreamSubscription<String>? _onTokenRefresh;

  Stream<String> get onTokenChanged => _onTokenChangedController.stream;

  void dispose() {
    _onTokenRefresh?.cancel();
    _onTokenChangedController.close();
  }

  void fcmListeners() {
    debugPrint('FirebaseNotifications.fcmListeners() stub: No-op');
  }

  void iosPermission() {
    debugPrint('FirebaseNotifications.iosPermission() stub: No-op');
  }

  void setup() {
    debugPrint('FirebaseNotifications.setup() stub: No-op');
  }

  static Future<String?> getToken() async {
    debugPrint('FirebaseNotifications.getToken() stub: returning null');
    return null;
  }
}
