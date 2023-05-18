import 'package:flutter/material.dart';

const noteColorsLength = 7;

class AppColors extends ThemeExtension<AppColors> {
  final Color? whiteSandColor;
  final Color? barleyWhiteColor;
  final Color? hawkesBlueColor;
  final Color? peachSchnappsColor;
  final Color? polarColor;
  final Color? snuffColor;
  final Color? linkWaterColor;

  AppColors({
    required this.whiteSandColor,
    required this.barleyWhiteColor,
    required this.hawkesBlueColor,
    required this.peachSchnappsColor,
    required this.polarColor,
    required this.snuffColor,
    required this.linkWaterColor,
  });

  @override
  ThemeExtension<AppColors> lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) {
      return this;
    }

    //returns the app Color
    return AppColors(
      whiteSandColor: Color.lerp(whiteSandColor, other.whiteSandColor, t),
      barleyWhiteColor: Color.lerp(barleyWhiteColor, other.barleyWhiteColor, t),
      hawkesBlueColor: Color.lerp(hawkesBlueColor, other.hawkesBlueColor, t),
      peachSchnappsColor:
      Color.lerp(peachSchnappsColor, other.peachSchnappsColor, t),
      polarColor: Color.lerp(polarColor, other.polarColor, t),
      snuffColor: Color.lerp(snuffColor, other.snuffColor, t),
      linkWaterColor: Color.lerp(linkWaterColor, other.linkWaterColor, t),
    );
  }

  @override
  AppColors copyWith({
    Color? whiteSandColor,
    Color? barleyWhiteColor,
    Color? hawkesBlueColor,
    Color? peachSchnappsColor,
    Color? polarColor,
    Color? snuffColor,
    Color? linkWaterColor,
  }) =>
      AppColors(
        whiteSandColor: whiteSandColor ?? this.whiteSandColor,
        barleyWhiteColor: barleyWhiteColor ?? this.barleyWhiteColor,
        hawkesBlueColor: hawkesBlueColor ?? this.hawkesBlueColor,
        peachSchnappsColor: peachSchnappsColor ?? this.peachSchnappsColor,
        polarColor: polarColor ?? this.polarColor,
        snuffColor: snuffColor ?? this.snuffColor,
        linkWaterColor: linkWaterColor ?? this.linkWaterColor,
      );
}