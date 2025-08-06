import 'package:flutter/material.dart';
import '../core/responsive_context.dart';
import '../core/responsive_config.dart';

/// A base responsive widget that provides responsive capabilities
class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.builder,
    this.config = const ResponsiveConfig(),
  });

  /// Builder function that receives responsive context
  final Widget Function(BuildContext context, ResponsiveContext responsiveContext) builder;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final orientation = mediaQuery.orientation;
    final breakpoint = config.getBreakpoint(size.width);
    
    final responsiveContext = ResponsiveContext(
      size: size,
      breakpoint: breakpoint,
      config: config,
      orientation: orientation,
    );

    return ResponsiveContextProvider(
      context: responsiveContext,
      child: builder(context, responsiveContext),
    );
  }
}



/// A responsive widget that shows different content based on breakpoint
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
    this.extraLarge,
    this.fallback,
    this.config = const ResponsiveConfig(),
  });

  /// Widget to show on mobile
  final Widget? mobile;

  /// Widget to show on tablet
  final Widget? tablet;

  /// Widget to show on desktop
  final Widget? desktop;

  /// Widget to show on large desktop
  final Widget? largeDesktop;

  /// Widget to show on extra large screens
  final Widget? extraLarge;

  /// Fallback widget if no specific widget is provided for the breakpoint
  final Widget? fallback;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      config: config,
      builder: (context, responsiveContext) {
        final widget = responsiveContext.responsiveValue<Widget?>(
          mobile: mobile,
          tablet: tablet,
          desktop: desktop,
          largeDesktop: largeDesktop,
          extraLarge: extraLarge,
          fallback: fallback,
        );
        
        return widget ?? const SizedBox.shrink();
      },
    );
  }
}

/// A responsive widget that shows different content based on orientation
class ResponsiveOrientationLayout extends StatelessWidget {
  const ResponsiveOrientationLayout({
    super.key,
    this.portrait,
    this.landscape,
    this.fallback,
    this.config = const ResponsiveConfig(),
  });

  /// Widget to show in portrait orientation
  final Widget? portrait;

  /// Widget to show in landscape orientation
  final Widget? landscape;

  /// Fallback widget if no specific widget is provided for the orientation
  final Widget? fallback;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      config: config,
      builder: (context, responsiveContext) {
        Widget? widget;
        
        if (responsiveContext.isPortrait) {
          widget = portrait;
        } else if (responsiveContext.isLandscape) {
          widget = landscape;
        }
        
        return widget ?? fallback ?? const SizedBox.shrink();
      },
    );
  }
}

/// A responsive widget that shows different content based on screen size
class ResponsiveSizeLayout extends StatelessWidget {
  const ResponsiveSizeLayout({
    super.key,
    this.small,
    this.medium,
    this.large,
    this.fallback,
    this.smallBreakpoint = 600,
    this.mediumBreakpoint = 1200,
    this.config = const ResponsiveConfig(),
  });

  /// Widget to show on small screens
  final Widget? small;

  /// Widget to show on medium screens
  final Widget? medium;

  /// Widget to show on large screens
  final Widget? large;

  /// Fallback widget if no specific widget is provided for the size
  final Widget? fallback;

  /// Breakpoint for small screens
  final double smallBreakpoint;

  /// Breakpoint for medium screens
  final double mediumBreakpoint;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      config: config,
      builder: (context, responsiveContext) {
        Widget? widget;
        
        if (responsiveContext.width < smallBreakpoint) {
          widget = small;
        } else if (responsiveContext.width < mediumBreakpoint) {
          widget = medium;
        } else {
          widget = large;
        }
        
        return widget ?? fallback ?? const SizedBox.shrink();
      },
    );
  }
} 