import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';
import '../core/responsive_config.dart';

/// A simple responsive builder widget
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.builder,
    this.config = const ResponsiveConfig(),
  });

  /// Builder function that receives breakpoint and screen size
  final Widget Function(BuildContext context, Breakpoint breakpoint, Size size) builder;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final breakpoint = config.getBreakpoint(size.width);
    
    return builder(context, breakpoint, size);
  }
}

/// A responsive builder that provides responsive context
class ResponsiveContextBuilder extends StatelessWidget {
  const ResponsiveContextBuilder({
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

    return builder(context, responsiveContext);
  }
}

/// A responsive builder for conditional rendering based on breakpoint
class ResponsiveConditionalBuilder extends StatelessWidget {
  const ResponsiveConditionalBuilder({
    super.key,
    required this.condition,
    required this.builder,
    this.fallback,
    this.config = const ResponsiveConfig(),
  });

  /// Condition function that receives breakpoint and screen size
  final bool Function(Breakpoint breakpoint, Size size) condition;

  /// Builder function that receives breakpoint and screen size
  final Widget Function(BuildContext context, Breakpoint breakpoint, Size size) builder;

  /// Fallback widget if condition is false
  final Widget? fallback;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final breakpoint = config.getBreakpoint(size.width);
    
    if (condition(breakpoint, size)) {
      return builder(context, breakpoint, size);
    }
    
    return fallback ?? const SizedBox.shrink();
  }
}

/// A responsive builder for different content based on breakpoint
class ResponsiveContentBuilder extends StatelessWidget {
  const ResponsiveContentBuilder({
    super.key,
    this.mobile,
    this.tablet,
    this.desktop,
    this.largeDesktop,
    this.extraLarge,
    this.fallback,
    this.config = const ResponsiveConfig(),
  });

  /// Content for mobile breakpoint
  final Widget Function(BuildContext context, Size size)? mobile;

  /// Content for tablet breakpoint
  final Widget Function(BuildContext context, Size size)? tablet;

  /// Content for desktop breakpoint
  final Widget Function(BuildContext context, Size size)? desktop;

  /// Content for large desktop breakpoint
  final Widget Function(BuildContext context, Size size)? largeDesktop;

  /// Content for extra large breakpoint
  final Widget Function(BuildContext context, Size size)? extraLarge;

  /// Fallback content
  final Widget Function(BuildContext context, Size size)? fallback;

  /// Responsive configuration
  final ResponsiveConfig config;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final size = mediaQuery.size;
    final breakpoint = config.getBreakpoint(size.width);
    
    Widget Function(BuildContext context, Size size)? content;
    
    switch (breakpoint) {
      case Breakpoint.mobile:
        content = mobile;
        break;
      case Breakpoint.tablet:
        content = tablet ?? mobile;
        break;
      case Breakpoint.desktop:
        content = desktop ?? tablet ?? mobile;
        break;
      case Breakpoint.largeDesktop:
        content = largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
      case Breakpoint.extraLarge:
        content = extraLarge ?? largeDesktop ?? desktop ?? tablet ?? mobile;
        break;
    }
    
    content ??= fallback;
    
    if (content != null) {
      return content(context, size);
    }
    
    return const SizedBox.shrink();
  }
} 