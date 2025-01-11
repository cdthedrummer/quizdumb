// App-wide constants
class AppConstants {
  // Animation durations
  static const kTransitionDuration = Duration(milliseconds: 300);
  static const kFadeDuration = Duration(milliseconds: 200);
  static const kSliderAnimationDuration = Duration(milliseconds: 16);

  // Layout constants
  static const kScreenPadding = 24.0;
  static const kSpacingSmall = 8.0;
  static const kSpacingMedium = 16.0;
  static const kSpacingLarge = 24.0;
  static const kSpacingXLarge = 32.0;

  // Quiz constants
  static const kMinScaleValue = 1;
  static const kMaxScaleValue = 7;
  static const kDefaultScaleValue = 4;
  
  // Design constants
  static const kBorderRadius = 12.0;
  static const kButtonBorderRadius = 30.0;
  static const kCardElevation = 4.0;

  // Opacity values
  static const kActiveTrackOpacity = 230;  // 0.9 * 255
  static const kInactiveTrackOpacity = 51;  // 0.2 * 255
  static const kOverlayOpacity = 31;  // 0.12 * 255
  static const kCardBackgroundOpacity = 51;  // 0.2 * 255

  // Font family
  static const kFontFamily = 'Quicksand';
}