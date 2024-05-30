import 'dart:math';

import 'package:flutter/widgets.dart';

/// @author Collins Ihezie

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;

  static late double textMultiplier;
  static late double imageSizeMultiplier;
  static late double heightMultiplier;
  static late double widthMultiplier;

  void init(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    textMultiplier = blockSizeVertical;
    imageSizeMultiplier = blockSizeHorizontal;
    heightMultiplier = blockSizeVertical;
    widthMultiplier = blockSizeHorizontal;
  }

  static double pxToWidth(double widthPx) {
    //TODO define accurate calculations
    return widthPx * 1;
  }

  static double pxToHeight(double heightPx) {
    //TODO define accurate calculations
    return heightPx * 1;//blockSizeVertical;
  }

  static double radius(double radius) {
    //TODO define accurate calculations
    return radius * min(1, 1);
  }

  static double pxToTextSize(double sizePx) {
    //TODO define accurate calculations
    return sizePx * 1;
  }
}

extension PxToLineHeight on double {
  double toLineHeight(double fontSize) {
    return SizeConfig.pxToTextSize(this) / SizeConfig.pxToTextSize(fontSize);
  }
}
