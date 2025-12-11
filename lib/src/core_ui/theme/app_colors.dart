import 'package:flutter/material.dart';

abstract class AppColors {
  factory AppColors.of(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    return brightness == Brightness.light
        ? const LightColors()
        : const DarkColors();
  }

  Color get primaryBg;

  Color get warning100;

  Color get warning300;

  Color get warning600;

  Color get lightBlue;

  Color get grey50;

  Color get warning50;

  Color get grey75;

  Color get white;

  Color get grey300;

  Color get grey200;

  Color get grey100;

  Color get grey400;

  Color get grey600;

  Color get secondary700;

  Color get secondary900;

  Color get secondary50;

  Color get secondary100;

  Color get secondary500;

  Color get black;

  Color get secondary;

  Color get lighterBlue;

  Color get error;

  Color get primary400base;

  Color get primary600;

  Color get grey900;

  Color get grey800;

  Color get grey700;

  Color get secondary400base;

  Color get grey500;

  Color get gridLine;

  Color get transparent;

  Color get gridCell;

  Color get lightGray;

  Color get success900;

  Color get success600;

  Color get success400base;

  Color get success200;

  Color get error400base;

  Color get unselectedEvent;

  Color get selectedEvent;

  Color get selectedBorder;

  Color get lightYellow;

  Color get darkYellow;

  Color get gold;

  Color get success50;

  Color get primary50;

  Color get error50;

  Color get primary300;

  Color get shadow1;

  Color get shadow2;
}

class DarkColors extends LightColors {
  const DarkColors();
}

class LightColors implements AppColors {
  const LightColors();

  @override
  Color get primaryBg => const Color(0xFFeceff1);

  @override
  Color get secondary100 => const Color(0xFFB6D8FF);

  @override
  Color get lightGray => const Color(0xFFF0F2F5);

  @override
  Color get secondary400base => const Color(0xFF1671D9);

  @override
  Color get secondary500 => const Color(0xFF0D5EBA);

  @override
  Color get grey900 => const Color(0xFF101928);

  @override
  Color get grey200 => const Color(0xFFE4E7EC);

  @override
  Color get grey500 => const Color(0xFF667185);

  @override
  Color get black => const Color(0xFF000000);

  @override
  Color get white => const Color.fromRGBO(255, 255, 255, 1);

  @override
  Color get grey300 => const Color(0xffD0D5DD);

  @override
  Color get grey400 => const Color(0xff98A2B3);

  @override
  Color get secondary => const Color(0xFFB6D8FF);

  @override
  Color get error => const Color(0xFFE26E6A);

  @override
  Color get gridLine => const Color(0xFFE4F1FF);

  @override
  Color get gridCell => const Color(0xffD8ECFF);

  @override
  Color get transparent => const Color(0x00000000);

  @override
  Color get secondary700 => const Color(0xFF04326B);

  @override
  Color get grey800 => const Color(0xFF1D2739);

  @override
  Color get secondary900 => const Color(0xFF001633);

  @override
  Color get secondary50 => const Color(0xFFE3EFFC);

  @override
  Color get grey50 => const Color(0xFFF9FAFB);

  @override
  Color get success900 => const Color(0xFF015B20);

  @override
  Color get success600 => const Color(0xFF099137);

  @override
  Color get success400base => const Color(0xFF0F973D);

  @override
  Color get success200 => const Color(0xFFE7F6EC);

  @override
  Color get error400base => const Color(0xFFD42620);

  @override
  Color get grey100 => const Color(0xFFF0F2F5);

  @override
  Color get primary400base => const Color(0xFFF56630);

  @override
  Color get primary600 => const Color(0xFFCC400C);

  @override
  Color get grey700 => const Color(0xFF344054);

  @override
  Color get grey600 => const Color(0xFF475367);

  @override
  Color get lightYellow => const Color(0xFFFEF6E7);

  @override
  Color get darkYellow => const Color(0xFF865503);

  @override
  Color get grey75 => const Color(0xFFF7F9FC);

  @override
  Color get unselectedEvent => const Color(0xFFE7F6EC);

  @override
  Color get selectedEvent => const Color(0xFF099137);

  @override
  Color get selectedBorder => const Color(0xFF015B20);

  @override
  Color get gold => const Color(0xFFFFD50B);

  @override
  Color get success50 => const Color(0xFFE7F6EC);

  @override
  Color get primary50 => const Color(0xFFFFECE5);

  @override
  Color get error50 => const Color(0xFFFBEAE9);

  @override
  Color get primary300 => const Color(0xFFF77A4A);

  @override
  Color get warning50 => const Color(0xFFFEF6E7);

  @override
  Color get warning100 => const Color(0xFFF7D394);

  @override
  Color get warning300 => const Color(0xFFF3A218);

  @override
  Color get warning600 => const Color(0xFFAD6F07);

  @override
  Color get shadow1 => const Color(0x1019280A);

  @override
  Color get shadow2 => const Color(0x10192824);

  @override
  Color get lightBlue => const Color(0xFFF3F9FF);

  @override
  Color get lighterBlue => const Color(0xFFF2F8FF);

}
