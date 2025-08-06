import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';
import '../spacing/responsive_spacing.dart';

/// A responsive grid widget that adapts to different screen sizes
class ResponsiveGrid extends StatelessWidget {
  const ResponsiveGrid({
    super.key,
    required this.children,
    this.columns = 12,
    this.spacing = 16.0,
    this.runSpacing = 16.0,
    this.padding,
    this.crossAxisSpacing,
    this.mainAxisSpacing,
    this.childAspectRatio,
    this.maxCrossAxisExtent,
    this.breakpoint,
  });

  /// The widgets to display in the grid
  final List<Widget> children;

  /// Number of columns in the grid (default: 12)
  final int columns;

  /// Spacing between grid items
  final double spacing;

  /// Spacing between grid rows
  final double runSpacing;

  /// Padding around the grid
  final EdgeInsetsGeometry? padding;

  /// Cross axis spacing (horizontal spacing)
  final double? crossAxisSpacing;

  /// Main axis spacing (vertical spacing)
  final double? mainAxisSpacing;

  /// Aspect ratio for grid items
  final double? childAspectRatio;

  /// Maximum cross axis extent for grid items
  final double? maxCrossAxisExtent;

  /// Override breakpoint (if null, will be determined from context)
  final Breakpoint? breakpoint;

  @override
  Widget build(BuildContext context) {
    final currentBreakpoint = breakpoint ?? 
        ResponsiveBreakpoints.getBreakpoint(context.screenWidth);
    
    final responsiveColumns = _getResponsiveColumns(currentBreakpoint);
    final responsiveSpacing = _getResponsiveSpacing(context, currentBreakpoint);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: GridView.count(
        crossAxisCount: responsiveColumns,
        crossAxisSpacing: crossAxisSpacing ?? responsiveSpacing,
        mainAxisSpacing: mainAxisSpacing ?? runSpacing,
        childAspectRatio: childAspectRatio ?? _getDefaultAspectRatio(currentBreakpoint),
        children: children,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    );
  }

  /// Get responsive number of columns based on breakpoint
  int _getResponsiveColumns(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return (columns * 0.5).round().clamp(1, columns);
      case Breakpoint.tablet:
        return (columns * 0.75).round().clamp(1, columns);
      case Breakpoint.desktop:
        return (columns * 0.9).round().clamp(1, columns);
      case Breakpoint.largeDesktop:
        return columns;
      case Breakpoint.extraLarge:
        return columns;
    }
  }

  /// Get responsive spacing based on breakpoint
  double _getResponsiveSpacing(BuildContext context, Breakpoint breakpoint) {
    return ResponsiveSpacing.getSpacing(breakpoint, scale: spacing / 16.0);
  }

  /// Get default aspect ratio based on breakpoint
  double _getDefaultAspectRatio(Breakpoint breakpoint) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return 1.0; // Square on mobile
      case Breakpoint.tablet:
        return 1.2; // Slightly wider on tablet
      case Breakpoint.desktop:
        return 1.5; // Wider on desktop
      case Breakpoint.largeDesktop:
        return 1.8; // Even wider on large desktop
      case Breakpoint.extraLarge:
        return 2.0; // Very wide on extra large screens
    }
  }
}



/// Extension for responsive grid utilities
extension ResponsiveGridExtension on BuildContext {
  /// Get responsive number of columns based on current breakpoint
  int get responsiveColumns {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return _getResponsiveColumns(breakpoint, 12);
  }

  /// Get responsive number of columns with custom total
  int responsiveColumnsWithTotal(int totalColumns) {
    final breakpoint = ResponsiveBreakpoints.getBreakpoint(screenWidth);
    return _getResponsiveColumns(breakpoint, totalColumns);
  }

  /// Get responsive columns for specific breakpoint
  int _getResponsiveColumns(Breakpoint breakpoint, int totalColumns) {
    switch (breakpoint) {
      case Breakpoint.mobile:
        return (totalColumns * 0.5).round().clamp(1, totalColumns);
      case Breakpoint.tablet:
        return (totalColumns * 0.75).round().clamp(1, totalColumns);
      case Breakpoint.desktop:
        return (totalColumns * 0.9).round().clamp(1, totalColumns);
      case Breakpoint.largeDesktop:
        return totalColumns;
      case Breakpoint.extraLarge:
        return totalColumns;
    }
  }
} 