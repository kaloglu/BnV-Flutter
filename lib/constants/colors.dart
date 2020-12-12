import 'constants.dart';

// Light Colors
const lightAccentColor = Colors.white70;
const lightPrimaryColor = Colors.white;
const lightTitleTextColor = Color(0xFF303030);
const lightBodyTextColor = Color(0xFF4B4B4B);
const lightTextLightColor = Color(0xFF959595);
const lightInfectedColor = Color(0xFFFF8748);
const lightBackgroundColor = Color(0xFFFEFEFE);
const lightDeathColor = Color(0xFFFF4848);
const lightRecoverColor = Color(0xFF36C12C);
final lightShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final lightActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

// Dark Colors
const darkAccentColor = Colors.white60;
const darkPrimaryColor = Colors.white24;
const darkTitleTextColor = Color(0xFF303030);
const darkBodyTextColor = Color(0xFF4B4B4B);
const darkTextLightColor = Color(0xFF959595);
const darkInfectedColor = Color(0xFFFF8748);
const darkBackgroundColor = Color(0xFFFEFEFE);
const darkDeathColor = Color(0xFFFF4848);
const darkRecoverColor = Color(0xFF36C12C);
final darkShadowColor = Color(0xFFB7B7B7).withOpacity(.16);
final darkActiveShadowColor = Color(0xFF4056C6).withOpacity(.15);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
);
