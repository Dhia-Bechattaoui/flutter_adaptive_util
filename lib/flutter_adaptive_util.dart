/// A comprehensive Flutter package for responsive design with breakpoint management,
/// typography scaling, adaptive spacing, and more.
///
/// This package provides a complete solution for building responsive Flutter applications
/// that adapt seamlessly across different screen sizes and orientations.
///
/// ## Features
///
/// - **Breakpoint Management**: Easy-to-use breakpoints for mobile, tablet, desktop, and large screens
/// - **Responsive Typography**: Automatic text scaling based on screen size
/// - **Adaptive Spacing**: Responsive padding, margins, and spacing utilities
/// - **Device Orientation Handling**: Built-in support for portrait and landscape layouts
/// - **Responsive Grid System**: Flexible grid layout with responsive columns
/// - **Media Query Helpers**: Simplified media query utilities
/// - **Responsive Widgets**: Pre-built widgets for responsive layouts
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_adaptive_util/flutter_adaptive_util.dart';
///
/// class MyResponsiveWidget extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return ResponsiveBuilder(
///       builder: (context, breakpoint, size) {
///         return Container(
///           padding: context.paddingAll,
///           child: Text(
///             'Current breakpoint: ${breakpoint.name}',
///             style: TextStyle(fontSize: context.responsiveDouble(
///               mobile: 16.0,
///               tablet: 18.0,
///               desktop: 20.0,
///               fallback: 16.0,
///             )),
///           ),
///         );
///       },
///     );
///   }
/// }
/// ```
///
/// ## Documentation
///
/// For complete documentation, visit: https://pub.dev/packages/flutter_adaptive_util
library flutter_adaptive_util;

// Core responsive utilities
export 'src/core/responsive_breakpoints.dart';
export 'src/core/responsive_config.dart';
export 'src/core/responsive_context.dart';

// Typography utilities
export 'src/typography/responsive_text.dart';
export 'src/typography/responsive_typography.dart';

// Spacing and sizing utilities
export 'src/spacing/responsive_spacing.dart';
export 'src/spacing/responsive_sizing.dart';

// Grid system
export 'src/grid/responsive_grid.dart';
export 'src/grid/responsive_grid_item.dart';

// Media query helpers
export 'src/media/responsive_media.dart';
export 'src/media/orientation_helper.dart';

// Widgets
export 'src/widgets/responsive_widget.dart';
export 'src/widgets/responsive_builder.dart';
