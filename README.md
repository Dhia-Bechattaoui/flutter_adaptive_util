# flutter_adaptive_util

A comprehensive Flutter package for responsive design with breakpoint management, typography scaling, adaptive spacing, and more.

## Features

- **Breakpoint Management**: Easy-to-use breakpoints for mobile, tablet, desktop, and large screens
- **Responsive Typography**: Automatic text scaling based on screen size
- **Adaptive Spacing**: Responsive padding, margins, and spacing utilities
- **Device Orientation Handling**: Built-in support for portrait and landscape layouts
- **Responsive Grid System**: Flexible grid layout with responsive columns
- **Media Query Helpers**: Simplified media query utilities
- **Responsive Widgets**: Pre-built widgets for responsive layouts

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_adaptive_util: ^0.0.1
```

## Quick Start

### Basic Usage

```dart
import 'package:flutter_adaptive_util/flutter_adaptive_util.dart';

class MyResponsiveWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, breakpoint, size) {
        return Container(
          padding: context.paddingAll,
          child: Text(
            'Current breakpoint: ${breakpoint.name}',
            style: TextStyle(fontSize: context.responsiveDouble(
              mobile: 16.0,
              tablet: 18.0,
              desktop: 20.0,
              fallback: 16.0,
            )),
          ),
        );
      },
    );
  }
}
```

### Responsive Layout

```dart
ResponsiveLayout(
  mobile: MobileLayout(),
  tablet: TabletLayout(),
  desktop: DesktopLayout(),
  fallback: MobileLayout(),
)
```

### Responsive Typography

```dart
// Using ResponsiveText widget
ResponsiveText(
  'Hello World',
  scale: 1.2,
  style: TextStyle(color: Colors.blue),
)

// Using extension methods
'Hello World'.responsiveText(
  scale: 1.2,
  style: TextStyle(color: Colors.blue),
)

// Using ResponsiveHeading
ResponsiveHeading(
  'Main Title',
  level: 1,
  scale: 1.5,
)
```

### Responsive Spacing

```dart
Container(
  padding: context.paddingAll,
  margin: context.paddingSymmetric(horizontal: 16.0),
  child: Text('Content'),
)

// Or use spacing utilities
Container(
  padding: EdgeInsets.all(context.spacing),
  margin: EdgeInsets.symmetric(
    horizontal: context.spacingSize(SpacingSize.lg),
  ),
  child: Text('Content'),
)
```

### Responsive Grid

```dart
ResponsiveGrid(
  columns: 12,
  spacing: 16.0,
  children: [
    Container(
      child: Text('Grid Item 1'),
    ).asGridItem(span: 6, mobileSpan: 12),
    Container(
      child: Text('Grid Item 2'),
    ).asGridItem(span: 6, mobileSpan: 12),
  ],
)
```

### Responsive Sizing

```dart
Container(
  width: context.responsiveWidth(50), // 50% of screen width
  height: context.responsiveHeight(30), // 30% of screen height
  child: Text('Responsive Container'),
)

// Square container
Container(
  width: context.responsiveSquare(25), // 25% of screen width
  height: context.responsiveSquare(25), // Same as width
  child: Text('Square Container'),
)
```

### Orientation Handling

```dart
ResponsiveOrientationLayout(
  portrait: PortraitLayout(),
  landscape: LandscapeLayout(),
  fallback: PortraitLayout(),
)

// Or use orientation utilities
Container(
  padding: context.orientationPadding(
    portrait: EdgeInsets.all(16.0),
    landscape: EdgeInsets.all(24.0),
    fallback: EdgeInsets.all(16.0),
  ),
  child: Text('Orientation Aware'),
)
```

## API Reference

### Breakpoints

```dart
enum Breakpoint {
  mobile,      // < 600px
  tablet,      // 600px - 900px
  desktop,     // 900px - 1200px
  largeDesktop, // 1200px - 1600px
  extraLarge,  // > 1600px
}
```

### Responsive Configuration

```dart
ResponsiveConfig(
  mobileBreakpoint: 600,
  tabletBreakpoint: 900,
  desktopBreakpoint: 1200,
  largeDesktopBreakpoint: 1600,
  typographyScale: 1.0,
  spacingScale: 1.0,
  enableOrientationHandling: true,
  defaultGridColumns: 12,
)
```

### Extension Methods

The package provides convenient extension methods on `BuildContext`:

- `context.screenWidth` - Get screen width
- `context.screenHeight` - Get screen height
- `context.screenSize` - Get screen size
- `context.orientation` - Get device orientation
- `context.spacing` - Get responsive spacing
- `context.responsiveColumns` - Get responsive grid columns
- `context.isMobile` - Check if mobile breakpoint
- `context.isTablet` - Check if tablet breakpoint
- `context.isDesktop` - Check if desktop breakpoint
- `context.isPortrait` - Check if portrait orientation
- `context.isLandscape` - Check if landscape orientation

### Responsive Values

```dart
// Get responsive values based on breakpoint
context.responsiveValue<T>(
  mobile: mobileValue,
  tablet: tabletValue,
  desktop: desktopValue,
  fallback: fallbackValue,
)

// Specific type helpers
context.responsiveDouble(mobile: 16.0, tablet: 18.0, fallback: 16.0)
context.responsiveInt(mobile: 1, tablet: 2, fallback: 1)
context.responsiveBool(mobile: true, tablet: false, fallback: true)
```

## Examples

### Complete Responsive Page

```dart
class ResponsivePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Hello World'.responsiveHeading(level: 1),
      ),
      body: ResponsiveBuilder(
        builder: (context, breakpoint, size) {
          return Padding(
            padding: context.paddingAll,
            child: ResponsiveGrid(
              columns: 12,
              spacing: context.spacing,
              children: [
                _buildCard('Card 1', Colors.blue).asGridItem(
                  span: 6,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildCard('Card 2', Colors.green).asGridItem(
                  span: 6,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildCard('Card 3', Colors.orange).asGridItem(
                  span: 12,
                  mobileSpan: 12,
                  tabletSpan: 12,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            title.responsiveHeading(level: 2),
            SizedBox(height: 8.0),
            'This is a responsive card that adapts to different screen sizes.'
                .responsiveText(),
          ],
        ),
      ),
    );
  }
}
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. 