import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';

/// Responsive spacing utilities for adaptive layouts
class ResponsiveSpacing {
  const ResponsiveSpacing._();

  /// Default spacing values for different breakpoints
  static const Map<Breakpoint, double> _defaultSpacing = {
    Breakpoint.mobile: 8.0,
    Breakpoint.tablet: 12.0,
    Breakpoint.desktop: 16.0,
    Breakpoint.largeDesktop: 20.0,
    Breakpoint.extraLarge: 24.0,
  };

  /// Get responsive spacing value based on breakpoint
  static double getSpacing(Breakpoint breakpoint, {double scale = 1.0}) {
    final baseSpacing = _defaultSpacing[breakpoint] ?? 16.0;
    return baseSpacing * scale;
  }

  /// Get responsive spacing for different sizes
  static double getSpacingSize(Breakpoint breakpoint, SpacingSize size, {double scale = 1.0}) {
    final baseSpacing = getSpacing(breakpoint, scale: scale);
    
    switch (size) {
      case SpacingSize.xs:
        return baseSpacing * 0.25;
      case SpacingSize.sm:
        return baseSpacing * 0.5;
      case SpacingSize.md:
        return baseSpacing;
      case SpacingSize.lg:
        return baseSpacing * 1.5;
      case SpacingSize.xl:
        return baseSpacing * 2.0;
      case SpacingSize.xxl:
        return baseSpacing * 3.0;
    }
  }

  /// Scale spacing based on screen width
  static double scaleSpacing(double baseSpacing, double screenWidth, {double minScale = 0.5, double maxScale = 2.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    final scale = _getScaleFactor(breakpoint);
    final scaledSpacing = baseSpacing * scale;
    
    return scaledSpacing.clamp(baseSpacing * minScale, baseSpacing * maxScale);
  }

  /// Get scale factor for breakpoint
  static double _getScaleFactor(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return 0.8;
      case Breakpoint.tablet:
        return 1.0;
      case Breakpoint.desktop:
        return 1.2;
      case Breakpoint.largeDesktop:
        return 1.4;
      case Breakpoint.extraLarge:
        return 1.6;
    }
  }

  /// Create responsive EdgeInsets
  static EdgeInsets getEdgeInsets(
    Breakpoint breakpoint, {
    double? all,
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double scale = 1.0,
  }) {
    final spacing = getSpacing(breakpoint, scale: scale);
    
    return EdgeInsets.only(
      left: left ?? horizontal ?? all ?? spacing,
      top: top ?? vertical ?? all ?? spacing,
      right: right ?? horizontal ?? all ?? spacing,
      bottom: bottom ?? vertical ?? all ?? spacing,
    );
  }

  /// Create responsive EdgeInsets with spacing size
  static EdgeInsets getEdgeInsetsSize(
    Breakpoint breakpoint,
    SpacingSize size, {
    double? horizontal,
    double? vertical,
    double? left,
    double? top,
    double? right,
    double? bottom,
    double scale = 1.0,
  }) {
    final spacing = getSpacingSize(breakpoint, size, scale: scale);
    
    return EdgeInsets.only(
      left: left ?? horizontal ?? spacing,
      top: top ?? vertical ?? spacing,
      right: right ?? horizontal ?? spacing,
      bottom: bottom ?? vertical ?? spacing,
    );
  }

  /// Create responsive EdgeInsets.symmetric
  static EdgeInsets getSymmetric(
    Breakpoint breakpoint, {
    double? horizontal,
    double? vertical,
    double scale = 1.0,
  }) {
    final spacing = getSpacing(breakpoint, scale: scale);
    
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? spacing,
      vertical: vertical ?? spacing,
    );
  }

  /// Create responsive EdgeInsets.all
  static EdgeInsets getAll(Breakpoint breakpoint, {double scale = 1.0}) {
    final spacing = getSpacing(breakpoint, scale: scale);
    return EdgeInsets.all(spacing);
  }

  /// Create responsive EdgeInsets.only
  static EdgeInsets getOnly(
    Breakpoint breakpoint, {
    double? left,
    double? top,
    double? right,
    double? bottom,
    double scale = 1.0,
  }) {
    final spacing = getSpacing(breakpoint, scale: scale);
    
    return EdgeInsets.only(
      left: left ?? spacing,
      top: top ?? spacing,
      right: right ?? spacing,
      bottom: bottom ?? spacing,
    );
  }
}

/// Spacing size enum
enum SpacingSize {
  xs,  // Extra small
  sm,  // Small
  md,  // Medium
  lg,  // Large
  xl,  // Extra large
  xxl, // Extra extra large
}

/// Extension for responsive spacing on BuildContext
extension ResponsiveSpacingExtension on BuildContext {
  /// Get responsive spacing for current breakpoint
  double get spacing {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getSpacing(breakpoint);
  }

  /// Get responsive spacing with custom scale
  double spacingWithScale(double scale) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getSpacing(breakpoint, scale: scale);
  }

  /// Get responsive spacing for specific size
  double spacingSize(SpacingSize size, {double scale = 1.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getSpacingSize(breakpoint, size, scale: scale);
  }

  /// Get responsive EdgeInsets.all
  EdgeInsets get paddingAll {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getAll(breakpoint);
  }

  /// Get responsive EdgeInsets.symmetric
  EdgeInsets paddingSymmetric({double? horizontal, double? vertical, double scale = 1.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getSymmetric(breakpoint, horizontal: horizontal, vertical: vertical, scale: scale);
  }

  /// Get responsive EdgeInsets.only
  EdgeInsets paddingOnly({double? left, double? top, double? right, double? bottom, double scale = 1.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSpacing.getOnly(breakpoint, left: left, top: top, right: right, bottom: bottom, scale: scale);
  }
} 