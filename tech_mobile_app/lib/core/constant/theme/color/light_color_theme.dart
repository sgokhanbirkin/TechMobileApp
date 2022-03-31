import 'package:flutter/material.dart';
import 'package:tech_mobile_app/core/constant/theme/color/color_theme.dart';

class LightColors implements IColors {
  @override
  Color? appBarColor;

  @override
  Brightness? brightness;

  @override
  ColorScheme? colorScheme;

  @override
  Color? scaffoldBackgroundColor;

  @override
  Color? tabBarColor;

  @override
  Color? tabbarNormalColor;

  @override
  Color? tabbarSelectedColor;

  @override
  final AppColors colors = AppColors();

  LightColors() {
    appBarColor = colors.white;
    scaffoldBackgroundColor = colors.white;
    tabBarColor = colors.red;
    tabbarNormalColor = colors.darkerGrey;
    tabbarSelectedColor = Colors.pink.shade200;

    buttonNormalColor = Colors.pink.shade200;
    buttonGoogleColor = colors.nightblue;
    colorScheme = const ColorScheme.light().copyWith(
      onPrimary: Colors.pink.shade200, //xx Her ikisinde ortaktır
      onSecondary: colors.white,
      onSurface: colors.mediumGreyBold,
    );
  }

  @override
  Color? buttonGoogleColor;

  @override
  Color? buttonNormalColor;
}
