import 'package:flutter/material.dart';

class MyColors {
  static const Color mbDarkBlue = Color(0xFF1A3C55);
  static const Color primary = Color(0xFF1A3C55);

  static const Color mbGreyBlue = Color(0xFF526671);
  static const Color secondary = Color(0xFF526671);

  static const Color mbLightBlue = Color(0xFFD6E0E8);
  static const Color mbYellow = Color(0xFFF9D201);
  static const Color mbSettingsHeaderBackground = Color(0xFFF2F2F7);
  static const Color mbLightGrey = Color(0xE6E5EBFF);
  static const Color nbChatBubbleSent = Color(0xFFC0C1C6);
  static const Color nbChatBubbleReceived = Color(0xFFD5D6D9);
  static const Color backGroundBlueLight = Color(0xFF2D4169);
  static const Color backGroundBlueDark = Color(0xFF002552);

  static const Color appleCyan = Color(0xFF32ADE6);
  static const Color appleDarkGey = Color(0xFF545454);
  static const Color appleYellow = Color(0xFFFFCC00);
  static const Color appleRed = Color(0xFFFF3B30);
  static const Color appleGreen = Color(0xFF34C759);
}


class MyCircularWhiteProgressIndicator extends StatelessWidget {
  const MyCircularWhiteProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white));
  }
}

class MyCircularProgressIndicator extends StatelessWidget {
  const MyCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary));
  }
}