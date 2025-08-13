import 'package:flutter/material.dart';
import 'responsive_breakpoints.dart';
import 'responsive_config.dart';

/// Provides responsive context information throughout the widget tree
class ResponsiveContext {
  const ResponsiveContext({
    required this.size,
    required this.breakpoint,
    required this.config,
    required this.orientation,
  });

  /// Screen size
  final Size size;

  /// Current breakpoint
  final Breakpoint breakpoint;

  /// Responsive configuration
  final ResponsiveConfig config;

  /// Device orientation
  final Orientation orientation;

  /// Screen width
  double get width => size.width;

  /// Screen height
  double get height => size.height;

  /// Aspect ratio
  double get aspectRatio => size.aspectRatio;

  /// Check if current breakpoint is mobile
  bool get isMobile => breakpoint == Breakpoint.mobile;

  /// Check if current breakpoint is tablet
  bool get isTablet => breakpoint == Breakpoint.tablet;

  /// Check if current breakpoint is desktop
  bool get isDesktop => breakpoint == Breakpoint.desktop;

  /// Check if current breakpoint is large desktop
  bool get isLargeDesktop => breakpoint == Breakpoint.largeDesktop;

  /// Check if current breakpoint is extra large
  bool get isExtraLarge => breakpoint == Breakpoint.extraLarge;

  /// Check if device is in portrait orientation
  bool get isPortrait => orientation == Orientation.portrait;

  /// Check if device is in landscape orientation
  bool get isLandscape => orientation == Orientation.landscape;

  /// Get responsive value based on breakpoint
  T responsiveValue<T>({
    T? mobile,
    T? tablet,
    T? desktop,
    T? largeDesktop,
    T? extraLarge,
    T? fallback,
  }) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return mobile ?? fallback!;
      case Breakpoint.tablet:
        return tablet ?? mobile ?? fallback!;
      case Breakpoint.desktop:
        return desktop ?? tablet ?? mobile ?? fallback!;
      case Breakpoint.largeDesktop:
        return largeDesktop ?? desktop ?? tablet ?? mobile ?? fallback!;
      case Breakpoint.extraLarge:
        return extraLarge ??
            largeDesktop ??
            desktop ??
            tablet ??
            mobile ??
            fallback!;
    }
  }

  /// Create a copy with updated values
  ResponsiveContext copyWith({
    Size? size,
    Breakpoint? breakpoint,
    ResponsiveConfig? config,
    Orientation? orientation,
  }) {
    return ResponsiveContext(
      size: size ?? this.size,
      breakpoint: breakpoint ?? this.breakpoint,
      config: config ?? this.config,
      orientation: orientation ?? this.orientation,
    );
  }
}

/// Extension to get ResponsiveContext from BuildContext
extension ResponsiveContextExtension on BuildContext {
  /// Get ResponsiveContext from the widget tree
  ResponsiveContext? get responsiveContext {
    return ResponsiveContextProvider.of(this);
  }

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Get device orientation
  Orientation get orientation => MediaQuery.of(this).orientation;

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;
}

/// Provider widget for ResponsiveContext
class ResponsiveContextProvider extends InheritedWidget {
  const ResponsiveContextProvider({
    super.key,
    required this.context,
    required super.child,
  });

  final ResponsiveContext context;

  static ResponsiveContext? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ResponsiveContextProvider>()
        ?.context;
  }

  @override
  bool updateShouldNotify(ResponsiveContextProvider oldWidget) {
    return context != oldWidget.context;
  }
}
