import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';

/// A responsive grid item that can span multiple columns
class ResponsiveGridItem extends StatelessWidget {
  const ResponsiveGridItem({
    super.key,
    required this.child,
    this.span = 1,
    this.mobileSpan,
    this.tabletSpan,
    this.desktopSpan,
    this.largeDesktopSpan,
    this.extraLargeSpan,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment = Alignment.center,
    this.breakpoint,
  });

  /// The widget to display in the grid item
  final Widget child;

  /// Default number of columns this item should span
  final int span;

  /// Number of columns to span on mobile
  final int? mobileSpan;

  /// Number of columns to span on tablet
  final int? tabletSpan;

  /// Number of columns to span on desktop
  final int? desktopSpan;

  /// Number of columns to span on large desktop
  final int? largeDesktopSpan;

  /// Number of columns to span on extra large screens
  final int? extraLargeSpan;

  /// Padding inside the grid item
  final EdgeInsetsGeometry? padding;

  /// Margin around the grid item
  final EdgeInsetsGeometry? margin;

  /// Decoration for the grid item
  final BoxDecoration? decoration;

  /// Alignment of the child within the grid item
  final AlignmentGeometry alignment;

  /// Override breakpoint (if null, will be determined from context)
  final Breakpoint? breakpoint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: child,
    );
  }
}

/// A responsive grid item with automatic responsive behavior
class AutoResponsiveGridItem extends StatelessWidget {
  /// Creates an auto-responsive grid item.
  ///
  /// The [child] widget is required. The [minSpan] and [maxSpan] parameters
  /// control the column span range. The [padding], [margin], [decoration], and
  /// [alignment] parameters are optional.
  const AutoResponsiveGridItem({
    super.key,
    required this.child,
    this.minSpan = 1,
    this.maxSpan = 12,
    this.padding,
    this.margin,
    this.decoration,
    this.alignment = Alignment.center,
  });

  /// The widget to display in the grid item
  final Widget child;

  /// Minimum number of columns to span
  final int minSpan;

  /// Maximum number of columns to span
  final int maxSpan;

  /// Padding inside the grid item
  final EdgeInsetsGeometry? padding;

  /// Margin around the grid item
  final EdgeInsetsGeometry? margin;

  /// Decoration for the grid item
  final BoxDecoration? decoration;

  /// Alignment of the child within the grid item
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(context.screenWidth);
    final autoSpan = _getAutoSpan(breakpoint);

    return ResponsiveGridItem(
      span: autoSpan,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: child,
    );
  }

  /// Get automatic span based on breakpoint
  int _getAutoSpan(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return maxSpan.clamp(minSpan, maxSpan);
      case Breakpoint.tablet:
        return (maxSpan * 0.75).round().clamp(minSpan, maxSpan);
      case Breakpoint.desktop:
        return (maxSpan * 0.5).round().clamp(minSpan, maxSpan);
      case Breakpoint.largeDesktop:
        return (maxSpan * 0.33).round().clamp(minSpan, maxSpan);
      case Breakpoint.extraLarge:
        return (maxSpan * 0.25).round().clamp(minSpan, maxSpan);
    }
  }
}

/// Extension for responsive grid item utilities
extension ResponsiveGridItemExtension on Widget {
  /// Wrap widget in a responsive grid item
  Widget asGridItem({
    Key? key,
    int span = 1,
    int? mobileSpan,
    int? tabletSpan,
    int? desktopSpan,
    int? largeDesktopSpan,
    int? extraLargeSpan,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    AlignmentGeometry alignment = Alignment.center,
    Breakpoint? breakpoint,
  }) {
    return ResponsiveGridItem(
      key: key,
      span: span,
      mobileSpan: mobileSpan,
      tabletSpan: tabletSpan,
      desktopSpan: desktopSpan,
      largeDesktopSpan: largeDesktopSpan,
      extraLargeSpan: extraLargeSpan,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      breakpoint: breakpoint,
      child: this,
    );
  }

  /// Wrap widget in an auto-responsive grid item
  Widget asAutoGridItem({
    Key? key,
    int minSpan = 1,
    int maxSpan = 12,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    BoxDecoration? decoration,
    AlignmentGeometry alignment = Alignment.center,
  }) {
    return AutoResponsiveGridItem(
      key: key,
      minSpan: minSpan,
      maxSpan: maxSpan,
      padding: padding,
      margin: margin,
      decoration: decoration,
      alignment: alignment,
      child: this,
    );
  }
}
