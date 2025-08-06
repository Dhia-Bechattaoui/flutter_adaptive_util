import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';

/// Responsive media query utilities
class ResponsiveMedia {
  const ResponsiveMedia._();

  /// Get responsive value based on screen width
  static T responsiveValue<T>({
    required double screenWidth,
    T? mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
    T? extraLarge,
    required T fallback,
  }) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        return mobile ?? fallback;
      case Breakpoint.tablet:
        return tablet ?? mobile ?? fallback;
      case Breakpoint.desktop:
        return desktop ?? tablet ?? mobile ?? fallback;
      case Breakpoint.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile ?? fallback;
      case Breakpoint.extraLarge:
        return extraLarge ?? largeDesktop ?? desktop ?? tablet ?? mobile ?? fallback;
    }
  }

  /// Get responsive double value based on screen width
  static double responsiveDouble({
    required double screenWidth,
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
    double? extraLarge,
    required double fallback,
  }) {
    return responsiveValue<double>(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Get responsive int value based on screen width
  static int responsiveInt({
    required double screenWidth,
    int? mobile,
    int? tablet,
    int? desktop,
    int? largeDesktop,
    int? extraLarge,
    required int fallback,
  }) {
    return responsiveValue<int>(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Get responsive bool value based on screen width
  static bool responsiveBool({
    required double screenWidth,
    bool? mobile,
    bool? tablet,
    bool? desktop,
    bool? largeDesktop,
    bool? extraLarge,
    required bool fallback,
  }) {
    return responsiveValue<bool>(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Check if screen width is within a range
  static bool isWidthInRange(double screenWidth, double minWidth, double maxWidth) {
    return screenWidth >= minWidth && screenWidth <= maxWidth;
  }

  /// Check if screen height is within a range
  static bool isHeightInRange(double screenHeight, double minHeight, double maxHeight) {
    return screenHeight >= minHeight && screenHeight <= maxHeight;
  }

  /// Get responsive width percentage
  static double getWidthPercentage(double screenWidth, double percentage) {
    return screenWidth * (percentage / 100);
  }

  /// Get responsive height percentage
  static double getHeightPercentage(double screenHeight, double percentage) {
    return screenHeight * (percentage / 100);
  }

  /// Get responsive aspect ratio
  static double getAspectRatio(double width, double height) {
    return width / height;
  }

  /// Check if device is in landscape mode
  static bool isLandscape(double width, double height) {
    return width > height;
  }

  /// Check if device is in portrait mode
  static bool isPortrait(double width, double height) {
    return height > width;
  }

  /// Get responsive padding based on screen width
  static EdgeInsets getResponsivePadding({
    required double screenWidth,
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    final basePadding = _getBasePadding(breakpoint);
    
    return EdgeInsets.only(
      left: left ?? horizontal ?? all ?? basePadding,
      top: top ?? vertical ?? all ?? basePadding,
      right: right ?? horizontal ?? all ?? basePadding,
      bottom: bottom ?? vertical ?? all ?? basePadding,
    );
  }

  /// Get base padding for breakpoint
  static double _getBasePadding(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return 16.0;
      case Breakpoint.tablet:
        return 24.0;
      case Breakpoint.desktop:
        return 32.0;
      case Breakpoint.largeDesktop:
        return 40.0;
      case Breakpoint.extraLarge:
        return 48.0;
    }
  }
}

/// Extension for responsive media utilities on BuildContext
extension ResponsiveMediaExtension on BuildContext {
  /// Get responsive value based on current screen width
  T responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
    T? extraLarge,
    required T fallback,
  }) {
    return ResponsiveMedia.responsiveValue<T>(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Get responsive double value based on current screen width
  double responsiveDouble({
    double? mobile,
    double? tablet,
    double? desktop,
    double? largeDesktop,
    double? extraLarge,
    required double fallback,
  }) {
    return ResponsiveMedia.responsiveDouble(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Get responsive int value based on current screen width
  int responsiveInt({
    int? mobile,
    int? tablet,
    int? desktop,
    int? largeDesktop,
    int? extraLarge,
    required int fallback,
  }) {
    return ResponsiveMedia.responsiveInt(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Get responsive bool value based on current screen width
  bool responsiveBool({
    bool? mobile,
    bool? tablet,
    bool? desktop,
    bool? largeDesktop,
    bool? extraLarge,
    required bool fallback,
  }) {
    return ResponsiveMedia.responsiveBool(
      screenWidth: screenWidth,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
      largeDesktop: largeDesktop,
      extraLarge: extraLarge,
      fallback: fallback,
    );
  }

  /// Check if current screen width is within a range
  bool isWidthInRange(double minWidth, double maxWidth) {
    return ResponsiveMedia.isWidthInRange(screenWidth, minWidth, maxWidth);
  }

  /// Check if current screen height is within a range
  bool isHeightInRange(double minHeight, double maxHeight) {
    return ResponsiveMedia.isHeightInRange(screenHeight, minHeight, maxHeight);
  }

  /// Get responsive width percentage
  double widthPercentage(double percentage) {
    return ResponsiveMedia.getWidthPercentage(screenWidth, percentage);
  }

  /// Get responsive height percentage
  double heightPercentage(double percentage) {
    return ResponsiveMedia.getHeightPercentage(screenHeight, percentage);
  }

  /// Get responsive aspect ratio
  double get aspectRatio {
    return ResponsiveMedia.getAspectRatio(screenWidth, screenHeight);
  }

  /// Check if device is in landscape mode
  bool get isLandscape {
    return ResponsiveMedia.isLandscape(screenWidth, screenHeight);
  }

  /// Check if device is in portrait mode
  bool get isPortrait {
    return ResponsiveMedia.isPortrait(screenWidth, screenHeight);
  }

  /// Get responsive padding based on current screen width
  EdgeInsets responsivePadding({
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return ResponsiveMedia.getResponsivePadding(
      screenWidth: screenWidth,
      all: all,
      horizontal: horizontal,
      vertical: vertical,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }
} 