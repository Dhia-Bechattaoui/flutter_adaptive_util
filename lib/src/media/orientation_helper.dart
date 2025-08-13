import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';

/// Orientation helper utilities for responsive design
class OrientationHelper {
  const OrientationHelper._();

  /// Get responsive value based on orientation
  static T orientationValue<T>({
    required Orientation orientation,
    T? portrait,
    T? landscape,
    required T fallback,
  }) {
    switch (orientation) {
      case Orientation.portrait:
        return portrait ?? fallback;
      case Orientation.landscape:
        return landscape ?? portrait ?? fallback;
    }
  }

  /// Get responsive double value based on orientation
  static double orientationDouble({
    required Orientation orientation,
    double? portrait,
    double? landscape,
    required double fallback,
  }) {
    return orientationValue<double>(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive int value based on orientation
  static int orientationInt({
    required Orientation orientation,
    int? portrait,
    int? landscape,
    required int fallback,
  }) {
    return orientationValue<int>(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive bool value based on orientation
  static bool orientationBool({
    required Orientation orientation,
    bool? portrait,
    bool? landscape,
    required bool fallback,
  }) {
    return orientationValue<bool>(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive EdgeInsets based on orientation
  static EdgeInsets orientationPadding({
    required Orientation orientation,
    EdgeInsets? portrait,
    EdgeInsets? landscape,
    required EdgeInsets fallback,
  }) {
    return orientationValue<EdgeInsets>(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive size based on orientation and screen dimensions
  static Size orientationSize({
    required Orientation orientation,
    required Size screenSize,
    double? portraitWidth,
    double? portraitHeight,
    double? landscapeWidth,
    double? landscapeHeight,
  }) {
    switch (orientation) {
      case Orientation.portrait:
        return Size(
          portraitWidth ?? screenSize.width,
          portraitHeight ?? screenSize.height,
        );
      case Orientation.landscape:
        return Size(
          landscapeWidth ?? screenSize.width,
          landscapeHeight ?? screenSize.height,
        );
    }
  }

  /// Get responsive aspect ratio based on orientation
  static double orientationAspectRatio({
    required Orientation orientation,
    double? portrait,
    double? landscape,
    double fallback = 1.0,
  }) {
    return orientationDouble(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Check if orientation should trigger layout changes
  static bool shouldChangeLayout({
    required Orientation currentOrientation,
    required Orientation previousOrientation,
    bool enableOrientationHandling = true,
  }) {
    if (!enableOrientationHandling) return false;
    return currentOrientation != previousOrientation;
  }

  /// Get responsive breakpoint considering orientation
  static Breakpoint getOrientationBreakpoint({
    required double screenWidth,
    required double screenHeight,
    required Orientation orientation,
  }) {
    // For landscape orientation, use height as the primary dimension
    final primaryDimension =
        orientation == Orientation.landscape ? screenHeight : screenWidth;

    return ResponsiveBreakpoints.getBreakpoint(primaryDimension);
  }

  /// Get responsive columns based on orientation
  static int getOrientationColumns({
    required Orientation orientation,
    required int baseColumns,
    double? portraitMultiplier,
    double? landscapeMultiplier,
  }) {
    final multiplier = orientationDouble(
      orientation: orientation,
      portrait: portraitMultiplier ?? 1.0,
      landscape: landscapeMultiplier ?? 0.75,
      fallback: 1.0,
    );

    return (baseColumns * multiplier).round().clamp(1, baseColumns);
  }
}

/// Extension for orientation utilities on BuildContext
extension OrientationHelperExtension on BuildContext {
  /// Get responsive value based on current orientation
  T orientationValue<T>({
    T? portrait,
    T? landscape,
    required T fallback,
  }) {
    return OrientationHelper.orientationValue<T>(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive double value based on current orientation
  double orientationDouble({
    double? portrait,
    double? landscape,
    required double fallback,
  }) {
    return OrientationHelper.orientationDouble(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive int value based on current orientation
  int orientationInt({
    int? portrait,
    int? landscape,
    required int fallback,
  }) {
    return OrientationHelper.orientationInt(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive bool value based on current orientation
  bool orientationBool({
    bool? portrait,
    bool? landscape,
    required bool fallback,
  }) {
    return OrientationHelper.orientationBool(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive EdgeInsets based on current orientation
  EdgeInsets orientationPadding({
    EdgeInsets? portrait,
    EdgeInsets? landscape,
    required EdgeInsets fallback,
  }) {
    return OrientationHelper.orientationPadding(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive size based on current orientation
  Size orientationSize({
    double? portraitWidth,
    double? portraitHeight,
    double? landscapeWidth,
    double? landscapeHeight,
  }) {
    return OrientationHelper.orientationSize(
      orientation: orientation,
      screenSize: screenSize,
      portraitWidth: portraitWidth,
      portraitHeight: portraitHeight,
      landscapeWidth: landscapeWidth,
      landscapeHeight: landscapeHeight,
    );
  }

  /// Get responsive aspect ratio based on current orientation
  double orientationAspectRatio({
    double? portrait,
    double? landscape,
    double fallback = 1.0,
  }) {
    return OrientationHelper.orientationAspectRatio(
      orientation: orientation,
      portrait: portrait,
      landscape: landscape,
      fallback: fallback,
    );
  }

  /// Get responsive breakpoint considering current orientation
  Breakpoint get orientationBreakpoint {
    return OrientationHelper.getOrientationBreakpoint(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      orientation: orientation,
    );
  }

  /// Get responsive columns based on current orientation
  int orientationColumns({
    required int baseColumns,
    double? portraitMultiplier,
    double? landscapeMultiplier,
  }) {
    return OrientationHelper.getOrientationColumns(
      orientation: orientation,
      baseColumns: baseColumns,
      portraitMultiplier: portraitMultiplier,
      landscapeMultiplier: landscapeMultiplier,
    );
  }
}
