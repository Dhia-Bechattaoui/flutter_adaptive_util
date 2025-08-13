import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';

/// Responsive typography configuration and utilities
class ResponsiveTypography {
  const ResponsiveTypography._();

  /// Default font sizes for different breakpoints
  static const Map<Breakpoint, double> _defaultFontSizes = {
    Breakpoint.mobile: 14.0,
    Breakpoint.tablet: 16.0,
    Breakpoint.desktop: 18.0,
    Breakpoint.largeDesktop: 20.0,
    Breakpoint.extraLarge: 22.0,
  };

  /// Default heading font sizes for different breakpoints
  static const Map<Breakpoint, Map<int, double>> _defaultHeadingSizes = {
    Breakpoint.mobile: {
      1: 24.0,
      2: 20.0,
      3: 18.0,
      4: 16.0,
      5: 14.0,
      6: 12.0,
    },
    Breakpoint.tablet: {
      1: 32.0,
      2: 28.0,
      3: 24.0,
      4: 20.0,
      5: 18.0,
      6: 16.0,
    },
    Breakpoint.desktop: {
      1: 40.0,
      2: 36.0,
      3: 32.0,
      4: 28.0,
      5: 24.0,
      6: 20.0,
    },
    Breakpoint.largeDesktop: {
      1: 48.0,
      2: 44.0,
      3: 40.0,
      4: 36.0,
      5: 32.0,
      6: 28.0,
    },
    Breakpoint.extraLarge: {
      1: 56.0,
      2: 52.0,
      3: 48.0,
      4: 44.0,
      5: 40.0,
      6: 36.0,
    },
  };

  /// Get responsive font size based on breakpoint
  static double getFontSize(Breakpoint breakpoint, {double scale = 1.0}) {
    final baseSize = _defaultFontSizes[breakpoint] ?? 16.0;
    return baseSize * scale;
  }

  /// Get responsive heading font size
  static double getHeadingSize(Breakpoint breakpoint, int level,
      {double scale = 1.0}) {
    final headingSizes = _defaultHeadingSizes[breakpoint];
    final baseSize = headingSizes?[level] ?? 16.0;
    return baseSize * scale;
  }

  /// Create responsive text style
  static TextStyle getTextStyle(
    Breakpoint breakpoint, {
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double scale = 1.0,
  }) {
    final size = fontSize ?? getFontSize(breakpoint, scale: scale);

    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight,
      color: color,
      height: height,
    );
  }

  /// Create responsive heading text style
  static TextStyle getHeadingStyle(
    Breakpoint breakpoint,
    int level, {
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double scale = 1.0,
  }) {
    final size = getHeadingSize(breakpoint, level, scale: scale);

    return TextStyle(
      fontSize: size,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color,
      height: height,
    );
  }

  /// Scale font size based on screen width
  static double scaleFontSize(double baseSize, double screenWidth,
      {double minScale = 0.8, double maxScale = 1.5}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    final scale = _getScaleFactor(breakpoint);
    final scaledSize = baseSize * scale;

    return scaledSize.clamp(baseSize * minScale, baseSize * maxScale);
  }

  /// Get scale factor for breakpoint
  static double _getScaleFactor(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return 0.9;
      case Breakpoint.tablet:
        return 1.0;
      case Breakpoint.desktop:
        return 1.1;
      case Breakpoint.largeDesktop:
        return 1.2;
      case Breakpoint.extraLarge:
        return 1.3;
    }
  }

  /// Create responsive text theme
  static TextTheme getTextTheme(Breakpoint breakpoint, {double scale = 1.0}) {
    return TextTheme(
      displayLarge: getHeadingStyle(breakpoint, 1, scale: scale),
      displayMedium: getHeadingStyle(breakpoint, 2, scale: scale),
      displaySmall: getHeadingStyle(breakpoint, 3, scale: scale),
      headlineLarge: getHeadingStyle(breakpoint, 4, scale: scale),
      headlineMedium: getHeadingStyle(breakpoint, 5, scale: scale),
      headlineSmall: getHeadingStyle(breakpoint, 6, scale: scale),
      bodyLarge: getTextStyle(breakpoint, scale: scale),
      bodyMedium: getTextStyle(breakpoint, scale: scale * 0.9),
      bodySmall: getTextStyle(breakpoint, scale: scale * 0.8),
      labelLarge: getTextStyle(breakpoint, scale: scale * 0.9),
      labelMedium: getTextStyle(breakpoint, scale: scale * 0.8),
      labelSmall: getTextStyle(breakpoint, scale: scale * 0.7),
    );
  }
}
