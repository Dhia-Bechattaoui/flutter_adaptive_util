/// Defines breakpoints for different screen sizes
class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  /// Mobile breakpoint (default: 600px)
  static const double mobile = 600;

  /// Tablet breakpoint (default: 900px)
  static const double tablet = 900;

  /// Desktop breakpoint (default: 1200px)
  static const double desktop = 1200;

  /// Large desktop breakpoint (default: 1600px)
  static const double largeDesktop = 1600;

  /// Get the current breakpoint based on screen width
  static Breakpoint getBreakpoint(double width) {
    if (width < mobile) return Breakpoint.mobile;
    if (width < tablet) return Breakpoint.tablet;
    if (width < desktop) return Breakpoint.desktop;
    if (width < largeDesktop) return Breakpoint.largeDesktop;
    return Breakpoint.extraLarge;
  }

  /// Check if the current width is mobile
  static bool isMobile(double width) => width < mobile;

  /// Check if the current width is tablet
  static bool isTablet(double width) => width >= mobile && width < tablet;

  /// Check if the current width is desktop
  static bool isDesktop(double width) => width >= tablet && width < desktop;

  /// Check if the current width is large desktop
  static bool isLargeDesktop(double width) =>
      width >= desktop && width < largeDesktop;

  /// Check if the current width is extra large
  static bool isExtraLarge(double width) => width >= largeDesktop;
}

/// Enum representing different breakpoints
enum Breakpoint {
  mobile,
  tablet,
  desktop,
  largeDesktop,
  extraLarge,
}

/// Extension to get readable names for breakpoints
extension BreakpointExtension on Breakpoint {
  /// Returns a human-readable name for the breakpoint.
  ///
  /// Examples: 'Mobile', 'Tablet', 'Desktop', 'Large Desktop', 'Extra Large'
  String get name {
    switch (this) {
      case Breakpoint.mobile:
        return 'Mobile';
      case Breakpoint.tablet:
        return 'Tablet';
      case Breakpoint.desktop:
        return 'Desktop';
      case Breakpoint.largeDesktop:
        return 'Large Desktop';
      case Breakpoint.extraLarge:
        return 'Extra Large';
    }
  }

  /// Get the minimum width for this breakpoint
  double get minWidth {
    switch (this) {
      case Breakpoint.mobile:
        return 0;
      case Breakpoint.tablet:
        return ResponsiveBreakpoints.mobile;
      case Breakpoint.desktop:
        return ResponsiveBreakpoints.tablet;
      case Breakpoint.largeDesktop:
        return ResponsiveBreakpoints.desktop;
      case Breakpoint.extraLarge:
        return ResponsiveBreakpoints.largeDesktop;
    }
  }
}
