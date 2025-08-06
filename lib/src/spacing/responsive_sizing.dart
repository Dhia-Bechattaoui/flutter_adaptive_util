import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';

/// Responsive sizing utilities for adaptive layouts
class ResponsiveSizing {
  const ResponsiveSizing._();

  /// Default sizing values for different breakpoints
  static const Map<Breakpoint, double> _defaultSizing = {
    Breakpoint.mobile: 40.0,
    Breakpoint.tablet: 50.0,
    Breakpoint.desktop: 60.0,
    Breakpoint.largeDesktop: 70.0,
    Breakpoint.extraLarge: 80.0,
  };

  /// Get responsive sizing value based on breakpoint
  static double getSizing(Breakpoint breakpoint, {double scale = 1.0}) {
    final baseSizing = _defaultSizing[breakpoint] ?? 50.0;
    return baseSizing * scale;
  }

  /// Get responsive sizing for different sizes
  static double getSizingSize(Breakpoint breakpoint, SizingSize size, {double scale = 1.0}) {
    final baseSizing = getSizing(breakpoint, scale: scale);
    
    switch (size) {
      case SizingSize.xs:
        return baseSizing * 0.5;
      case SizingSize.sm:
        return baseSizing * 0.75;
      case SizingSize.md:
        return baseSizing;
      case SizingSize.lg:
        return baseSizing * 1.25;
      case SizingSize.xl:
        return baseSizing * 1.5;
      case SizingSize.xxl:
        return baseSizing * 2.0;
    }
  }

  /// Scale sizing based on screen width
  static double scaleSizing(double baseSizing, double screenWidth, {double minScale = 0.5, double maxScale = 2.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    final scale = _getScaleFactor(breakpoint);
    final scaledSizing = baseSizing * scale;
    
    return scaledSizing.clamp(baseSizing * minScale, baseSizing * maxScale);
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

  /// Get responsive width based on screen width percentage
  static double getResponsiveWidth(double screenWidth, double percentage, {double minWidth = 0, double maxWidth = double.infinity}) {
    final width = screenWidth * (percentage / 100);
    return width.clamp(minWidth, maxWidth);
  }

  /// Get responsive height based on screen height percentage
  static double getResponsiveHeight(double screenHeight, double percentage, {double minHeight = 0, double maxHeight = double.infinity}) {
    final height = screenHeight * (percentage / 100);
    return height.clamp(minHeight, maxHeight);
  }

  /// Get responsive size (width and height) based on screen dimensions
  static Size getResponsiveSize(Size screenSize, double widthPercentage, double heightPercentage, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    double minHeight = 0,
    double maxHeight = double.infinity,
  }) {
    final width = getResponsiveWidth(screenSize.width, widthPercentage, minWidth: minWidth, maxWidth: maxWidth);
    final height = getResponsiveHeight(screenSize.height, heightPercentage, minHeight: minHeight, maxHeight: maxHeight);
    
    return Size(width, height);
  }

  /// Get responsive aspect ratio size
  static Size getAspectRatioSize(double screenWidth, double aspectRatio, {double maxWidth = double.infinity}) {
    final width = screenWidth.clamp(0.0, maxWidth);
    final height = width / aspectRatio;
    
    return Size(width, height);
  }

  /// Get responsive square size
  static double getSquareSize(double screenWidth, double percentage, {double minSize = 0, double maxSize = double.infinity}) {
    final size = screenWidth * (percentage / 100);
    return size.clamp(minSize, maxSize);
  }

  /// Get responsive circular size
  static double getCircularSize(double screenWidth, double percentage, {double minSize = 0, double maxSize = double.infinity}) {
    return getSquareSize(screenWidth, percentage, minSize: minSize, maxSize: maxSize);
  }
}

/// Sizing size enum
enum SizingSize {
  xs,  // Extra small
  sm,  // Small
  md,  // Medium
  lg,  // Large
  xl,  // Extra large
  xxl, // Extra extra large
}

/// Extension for responsive sizing on BuildContext
extension ResponsiveSizingExtension on BuildContext {
  /// Get responsive sizing for current breakpoint
  double get sizing {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSizing.getSizing(breakpoint);
  }

  /// Get responsive sizing with custom scale
  double sizingWithScale(double scale) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSizing.getSizing(breakpoint, scale: scale);
  }

  /// Get responsive sizing for specific size
  double sizingSize(SizingSize size, {double scale = 1.0}) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return ResponsiveSizing.getSizingSize(breakpoint, size, scale: scale);
  }

  /// Get responsive width based on percentage
  double responsiveWidth(double percentage, {double minWidth = 0, double maxWidth = double.infinity}) {
    return ResponsiveSizing.getResponsiveWidth(screenWidth, percentage, minWidth: minWidth, maxWidth: maxWidth);
  }

  /// Get responsive height based on percentage
  double responsiveHeight(double percentage, {double minHeight = 0, double maxHeight = double.infinity}) {
    return ResponsiveSizing.getResponsiveHeight(screenHeight, percentage, minHeight: minHeight, maxHeight: maxHeight);
  }

  /// Get responsive size based on percentages
  Size responsiveSize(double widthPercentage, double heightPercentage, {
    double minWidth = 0,
    double maxWidth = double.infinity,
    double minHeight = 0,
    double maxHeight = double.infinity,
  }) {
    return ResponsiveSizing.getResponsiveSize(
      screenSize,
      widthPercentage,
      heightPercentage,
      minWidth: minWidth,
      maxWidth: maxWidth,
      minHeight: minHeight,
      maxHeight: maxHeight,
    );
  }

  /// Get responsive square size
  double responsiveSquare(double percentage, {double minSize = 0, double maxSize = double.infinity}) {
    return ResponsiveSizing.getSquareSize(screenWidth, percentage, minSize: minSize, maxSize: maxSize);
  }

  /// Get responsive circular size
  double responsiveCircular(double percentage, {double minSize = 0, double maxSize = double.infinity}) {
    return ResponsiveSizing.getCircularSize(screenWidth, percentage, minSize: minSize, maxSize: maxSize);
  }
} 