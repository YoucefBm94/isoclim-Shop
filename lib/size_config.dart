import 'package:flutter/material.dart';

/// A utility class for managing screen size and orientation.
class SizeConfig {
  // MediaQueryData instance to fetch screen details
  static late MediaQueryData _mediaQueryData;
  // Screen width in logical pixels
  static late double screenWidth;
  // Screen height in logical pixels
  static late double screenHeight;
  // Default size, can be null
  static double? defaultSize;
  // Orientation of the screen (portrait or landscape)
  static Orientation? orientation;

  /// Initializes the SizeConfig with the given [context].
  /// Fetches the MediaQueryData and updates the screen dimensions and orientation.
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

/// Returns the proportionate height as per screen size.
/// [inputHeight] is the height to be proportioned.
/// The base height (812.0) is the layout height that designer use.
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  return (inputHeight / 812.0) * screenHeight;
}

/// Returns the proportionate width as per screen size.
/// [inputWidth] is the width to be proportioned.
/// The base width (375.0) is the layout width that designer use.
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  return (inputWidth / 375.0) * screenWidth;
}