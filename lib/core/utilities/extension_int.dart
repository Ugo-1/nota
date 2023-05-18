import 'dart:ui';
import 'package:nota/core/utilities/app_colors.dart';

extension IntExtension on int? {
  ///Gets the appropriate color from the color index of the note
  Color getNoteColor(AppColors colors){
    switch (this){
      case 0:
        return colors.whiteSandColor!;
      case 1:
        return colors.barleyWhiteColor!;
      case 2:
        return colors.hawkesBlueColor!;
      case 3:
        return colors.peachSchnappsColor!;
      case 4:
        return colors.polarColor!;
      case 5:
        return colors.snuffColor!;
      case 6:
        return colors.linkWaterColor!;
      default:
        return colors.whiteSandColor!;
    }
  }
}