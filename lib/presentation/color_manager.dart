import 'package:flutter/material.dart';

class ColorManager {
  // static Color primary = HexColor.fromHex("#FBB701");
  // static Color backgroundDark = HexColor.fromHex("#F5F5F5");
  static Color backgroundDark = HexColor.fromHex("#ffffff");
  // static Color backgroundLight = HexColor.fromHex("#FFFFFF");
  static Color backgroundLight = HexColor.fromHex("#ecfaf8");
  // static Color primary = HexColor.fromHex("#4285f4");
  static Color primary = HexColor.fromHex("#B92D4C");
  //afc5a0c8f0eb
  // static Color primary = HexColor.fromHex("#8F5153");

  // static Color primary = HexColor.fromHex("#125421");
  static Color primaryLight = HexColor.fromHex("#ecfaf8");
  static Color darkPrimary = HexColor.fromHex("#7b1fa2");
  static Color darkgrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9e9e9e");
  // static Color primaryOpacity70 = HexColor.fromHex("#B3FB8701");
  static Color primaryOpacity70 = HexColor.fromHex("#c8f0eb");
  // static Color primaryOpacity70 = HexColor.fromHex("#c6a8a8");
  static Color primaryFont = HexColor.fromHex("#3A3B3C");
  static Color primaryFontOpacity70 = HexColor.fromHex("#999999");

  // static Color secondary = HexColor.fromHex("#0541e1");
  static Color secondary = HexColor.fromHex("#414141");
  // static Color secondary = HexColor.fromHex("#3478E9");

  static Color error = HexColor.fromHex("#E61F34");
  static Color white = HexColor.fromHex("#FFFFFF");

  static Color absentColor = HexColor.fromHex("#ef5350");
  static Color presenceColor = HexColor.fromHex("#3cb043");
  static Color regularizationColor = HexColor.fromHex('#003f1a');
  static Color leaveColor = HexColor.fromHex("#E7C27D");
  static Color HL_HA_COLOR = HexColor.fromHex("#D24E43");
  static Color HL_HP_COLOR = HexColor.fromHex("#C7A317");
  static Color HA_HP_COLOR = HexColor.fromHex("#AF69AF");
  static Color DAY_OFF_COLOR = HexColor.fromHex("#00563F");
  static Color pendingColor = HexColor.fromHex("#1E74CA");
  static Color approveColor = HexColor.fromHex("#006800");
  static Color rejectColor = HexColor.fromHex("#F70300");
}

extension HexColor on Color {
  static Color fromHex(String hexString) {
    hexString = hexString.replaceAll("#", "");
    if (hexString.length == 6) {
      hexString = "FF" + hexString;
    }
    return Color(int.parse(hexString, radix: 16));
  }
}
