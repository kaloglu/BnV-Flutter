import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setDeviceToken(String deviceToken) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("deviceToken", deviceToken);
  return prefs.commit();
}

Future<String> getDeviceToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("devceToken");
}