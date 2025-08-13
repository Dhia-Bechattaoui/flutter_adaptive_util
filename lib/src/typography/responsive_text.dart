import 'package:flutter/material.dart';
import '../core/responsive_breakpoints.dart';
import '../core/responsive_context.dart';
import 'responsive_typography.dart';

/// A responsive text widget that automatically scales based on screen size
class ResponsiveText extends StatelessWidget {
  const ResponsiveText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.scale = 1.0,
    this.minScale = 0.8,
    this.maxScale = 1.5,
    this.breakpoint,
  });

  /// The text to display
  final String text;

  /// The text style to apply
  final TextStyle? style;

  /// How the text should be aligned horizontally
  final TextAlign? textAlign;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span
  final int? maxLines;

  /// Scale factor for the text size
  final double scale;

  /// Minimum scale factor
  final double minScale;

  /// Maximum scale factor
  final double maxScale;

  /// Override breakpoint (if null, will be determined from context)
  final Breakpoint? breakpoint;

  @override
  Widget build(BuildContext context) {
    final responsiveContext = context.responsiveContext;
    final currentBreakpoint = breakpoint ??
        (responsiveContext?.breakpoint ??
            ResponsiveBreakpoints.getBreakpoint(context.screenWidth));

    final responsiveStyle = _getResponsiveStyle(context, currentBreakpoint);

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  TextStyle _getResponsiveStyle(BuildContext context, Breakpoint breakpoint) {
    final baseStyle =
        style ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle();
    final baseFontSize = baseStyle.fontSize ?? 16.0;

    final responsiveFontSize = ResponsiveTypography.scaleFontSize(
          baseFontSize,
          context.screenWidth,
          minScale: minScale,
          maxScale: maxScale,
        ) *
        scale;

    return baseStyle.copyWith(
      fontSize: responsiveFontSize,
    );
  }
}

/// A responsive heading widget
class ResponsiveHeading extends StatelessWidget {
  const ResponsiveHeading(
    this.text, {
    super.key,
    this.level = 1,
    this.style,
    this.textAlign,
    this.overflow,
    this.maxLines,
    this.scale = 1.0,
    this.breakpoint,
  });

  /// The text to display
  final String text;

  /// Heading level (1-6)
  final int level;

  /// The text style to apply
  final TextStyle? style;

  /// How the text should be aligned horizontally
  final TextAlign? textAlign;

  /// How visual overflow should be handled
  final TextOverflow? overflow;

  /// An optional maximum number of lines for the text to span
  final int? maxLines;

  /// Scale factor for the text size
  final double scale;

  /// Override breakpoint (if null, will be determined from context)
  final Breakpoint? breakpoint;

  @override
  Widget build(BuildContext context) {
    final responsiveContext = context.responsiveContext;
    final currentBreakpoint = breakpoint ??
        (responsiveContext?.breakpoint ??
            ResponsiveBreakpoints.getBreakpoint(context.screenWidth));

    final responsiveStyle = _getResponsiveStyle(context, currentBreakpoint);

    return Text(
      text,
      style: responsiveStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }

  TextStyle _getResponsiveStyle(BuildContext context, Breakpoint breakpoint) {
    final baseStyle =
        style ?? Theme.of(context).textTheme.bodyMedium ?? const TextStyle();

    final responsiveStyle = ResponsiveTypography.getHeadingStyle(
      breakpoint,
      level,
      fontWeight: baseStyle.fontWeight,
      color: baseStyle.color,
      height: baseStyle.height,
      scale: scale,
    );

    return baseStyle.merge(responsiveStyle);
  }
}

/// Extension methods for responsive text
extension ResponsiveTextExtension on String {
  /// Create a responsive text widget
  Widget responsiveText({
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double scale = 1.0,
    double minScale = 0.8,
    double maxScale = 1.5,
    Breakpoint? breakpoint,
  }) {
    return ResponsiveText(
      this,
      key: key,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      scale: scale,
      minScale: minScale,
      maxScale: maxScale,
      breakpoint: breakpoint,
    );
  }

  /// Create a responsive heading widget
  Widget responsiveHeading({
    Key? key,
    int level = 1,
    TextStyle? style,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
    double scale = 1.0,
    Breakpoint? breakpoint,
  }) {
    return ResponsiveHeading(
      this,
      key: key,
      level: level,
      style: style,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      scale: scale,
      breakpoint: breakpoint,
    );
  }
}
