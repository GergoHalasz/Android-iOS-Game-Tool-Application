import 'package:flutter/widgets.dart';
import 'package:wowtalentcalculator/utils/constants.dart';

//https://medium.com/flutter-community/flutter-effectively-scale-ui-according-to-different-screen-sizes-2cb7c115ea0a

class SizeConfig {
  static late MediaQueryData _mediaQueryData;

  /// the width of screen size
  static late double screenWidth;

  /// the height of screen size
  static late double screenHeight;

  /// the size of screen size
  static late Size screenSize;

  /// the actual width size after safeArea
  static late double safeAreaScreenWidth;

  /// the actual height size after safeArea
  static late double safeAreaScreenHeight;

  ///width divide by 100
  static late double blockSizeHorizontal;

  ///height divide by 100
  static late double blockSizeVertical;

  ///width of safeArea
  static late double _safeAreaHorizontal;

  ///height of safeArea
  static late double _safeAreaVertical;

  ///width after safeAre divide by 100
  static late double safeBlockHorizontal;

  ///height after safeAre divide by 100
  static late double safeBlockVertical;

  ///the width of icon cell of the [DetailScreen]
  static late double cellSize;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    /// the width of screen size
    screenWidth = _mediaQueryData.size.width;

    /// the height of screen size
    screenHeight = _mediaQueryData.size.height;

    /// the size of screen size
    screenSize = _mediaQueryData.size;

    /// divide screens into 100 equal blocks, used for calculation
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    /// the width and height of safeArea
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    /// divide safeArea screens into 100 equal blocks, used for calculation
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;

    /// the actual screen size after safeArea
    safeAreaScreenWidth = screenWidth - _safeAreaHorizontal;
    safeAreaScreenHeight = screenHeight - _safeAreaVertical;

    /// the width of cell of the [DetailScreen], calculate upon init.
    cellSize = screenWidth < 600
        ? ((screenWidth - kTalentScreenTwoPadding) / NUM_COLS / 1.05)
        : 140;
  }
}
