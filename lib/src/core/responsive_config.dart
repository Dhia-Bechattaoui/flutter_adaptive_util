import 'responsive_breakpoints.dart';

/// Configuration class for responsive design settings
class ResponsiveConfig {
  const ResponsiveConfig({
    this.mobileBreakpoint = ResponsiveBreakpoints.mobile,
    this.tabletBreakpoint = ResponsiveBreakpoints.tablet,
    this.desktopBreakpoint = ResponsiveBreakpoints.desktop,
    this.largeDesktopBreakpoint = ResponsiveBreakpoints.largeDesktop,
    this.typographyScale = 1.0,
    this.spacingScale = 1.0,
    this.enableOrientationHandling = true,
    this.defaultGridColumns = 12,
  });

  /// Mobile breakpoint width
  final double mobileBreakpoint;

  /// Tablet breakpoint width
  final double tabletBreakpoint;

  /// Desktop breakpoint width
  final double desktopBreakpoint;

  /// Large desktop breakpoint width
  final double largeDesktopBreakpoint;

  /// Global typography scale factor
  final double typographyScale;

  /// Global spacing scale factor
  final double spacingScale;

  /// Whether to enable orientation handling
  final bool enableOrientationHandling;

  /// Default number of columns for grid system
  final int defaultGridColumns;

  /// Create a copy of this config with updated values
  ResponsiveConfig copyWith({
    double? mobileBreakpoint,
    double? tabletBreakpoint,
    double? desktopBreakpoint,
    double? largeDesktopBreakpoint,
    double? typographyScale,
    double? spacingScale,
    bool? enableOrientationHandling,
    int? defaultGridColumns,
  }) {
    return ResponsiveConfig(
      mobileBreakpoint: mobileBreakpoint ?? this.mobileBreakpoint,
      tabletBreakpoint: tabletBreakpoint ?? this.tabletBreakpoint,
      desktopBreakpoint: desktopBreakpoint ?? this.desktopBreakpoint,
      largeDesktopBreakpoint: largeDesktopBreakpoint ?? this.largeDesktopBreakpoint,
      typographyScale: typographyScale ?? this.typographyScale,
      spacingScale: spacingScale ?? this.spacingScale,
      enableOrientationHandling: enableOrientationHandling ?? this.enableOrientationHandling,
      defaultGridColumns: defaultGridColumns ?? this.defaultGridColumns,
    );
  }

  /// Get breakpoint based on width using custom breakpoints
  Breakpoint getBreakpoint(double width) {
    if (width < mobileBreakpoint) return Breakpoint.mobile;
    if (width < tabletBreakpoint) return Breakpoint.tablet;
    if (width < desktopBreakpoint) return Breakpoint.desktop;
    if (width < largeDesktopBreakpoint) return Breakpoint.largeDesktop;
    return Breakpoint.extraLarge;
  }

  /// Check if width is mobile using custom breakpoint
  bool isMobile(double width) => width < mobileBreakpoint;

  /// Check if width is tablet using custom breakpoint
  bool isTablet(double width) => width >= mobileBreakpoint && width < tabletBreakpoint;

  /// Check if width is desktop using custom breakpoint
  bool isDesktop(double width) => width >= tabletBreakpoint && width < desktopBreakpoint;

  /// Check if width is large desktop using custom breakpoint
  bool isLargeDesktop(double width) => width >= desktopBreakpoint && width < largeDesktopBreakpoint;

  /// Check if width is extra large using custom breakpoint
  bool isExtraLarge(double width) => width >= largeDesktopBreakpoint;
} 