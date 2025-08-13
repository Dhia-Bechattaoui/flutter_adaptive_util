import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_adaptive_util/flutter_adaptive_util.dart';

void main() {
  group('ResponsiveBreakpoints', () {
    test('should return correct breakpoint for mobile', () {
      expect(ResponsiveBreakpoints.getBreakpoint(400), Breakpoint.mobile);
      expect(ResponsiveBreakpoints.getBreakpoint(599), Breakpoint.mobile);
    });

    test('should return correct breakpoint for tablet', () {
      expect(ResponsiveBreakpoints.getBreakpoint(600), Breakpoint.tablet);
      expect(ResponsiveBreakpoints.getBreakpoint(899), Breakpoint.tablet);
    });

    test('should return correct breakpoint for desktop', () {
      expect(ResponsiveBreakpoints.getBreakpoint(900), Breakpoint.desktop);
      expect(ResponsiveBreakpoints.getBreakpoint(1199), Breakpoint.desktop);
    });

    test('should return correct breakpoint for large desktop', () {
      expect(
          ResponsiveBreakpoints.getBreakpoint(1200), Breakpoint.largeDesktop);
      expect(
          ResponsiveBreakpoints.getBreakpoint(1599), Breakpoint.largeDesktop);
    });

    test('should return correct breakpoint for extra large', () {
      expect(ResponsiveBreakpoints.getBreakpoint(1600), Breakpoint.extraLarge);
      expect(ResponsiveBreakpoints.getBreakpoint(2000), Breakpoint.extraLarge);
    });

    test('should check mobile correctly', () {
      expect(ResponsiveBreakpoints.isMobile(400), true);
      expect(ResponsiveBreakpoints.isMobile(600), false);
    });

    test('should check tablet correctly', () {
      expect(ResponsiveBreakpoints.isTablet(600), true);
      expect(ResponsiveBreakpoints.isTablet(900), false);
    });

    test('should check desktop correctly', () {
      expect(ResponsiveBreakpoints.isDesktop(900), true);
      expect(ResponsiveBreakpoints.isDesktop(1200), false);
    });
  });

  group('ResponsiveConfig', () {
    test('should create with default values', () {
      final config = ResponsiveConfig();
      expect(config.mobileBreakpoint, ResponsiveBreakpoints.mobile);
      expect(config.tabletBreakpoint, ResponsiveBreakpoints.tablet);
      expect(config.desktopBreakpoint, ResponsiveBreakpoints.desktop);
      expect(config.largeDesktopBreakpoint, ResponsiveBreakpoints.largeDesktop);
      expect(config.typographyScale, 1.0);
      expect(config.spacingScale, 1.0);
      expect(config.enableOrientationHandling, true);
      expect(config.defaultGridColumns, 12);
    });

    test('should create with custom values', () {
      final config = ResponsiveConfig(
        mobileBreakpoint: 500,
        tabletBreakpoint: 800,
        desktopBreakpoint: 1100,
        largeDesktopBreakpoint: 1500,
        typographyScale: 1.2,
        spacingScale: 1.1,
        enableOrientationHandling: false,
        defaultGridColumns: 10,
      );

      expect(config.mobileBreakpoint, 500);
      expect(config.tabletBreakpoint, 800);
      expect(config.desktopBreakpoint, 1100);
      expect(config.largeDesktopBreakpoint, 1500);
      expect(config.typographyScale, 1.2);
      expect(config.spacingScale, 1.1);
      expect(config.enableOrientationHandling, false);
      expect(config.defaultGridColumns, 10);
    });

    test('should copy with new values', () {
      final original = ResponsiveConfig();
      final copy = original.copyWith(
        mobileBreakpoint: 500,
        typographyScale: 1.2,
      );

      expect(copy.mobileBreakpoint, 500);
      expect(copy.typographyScale, 1.2);
      expect(copy.tabletBreakpoint, original.tabletBreakpoint);
    });
  });

  group('ResponsiveTypography', () {
    test('should get font size for breakpoint', () {
      final mobileSize = ResponsiveTypography.getFontSize(Breakpoint.mobile);
      final tabletSize = ResponsiveTypography.getFontSize(Breakpoint.tablet);
      final desktopSize = ResponsiveTypography.getFontSize(Breakpoint.desktop);

      expect(mobileSize, 14.0);
      expect(tabletSize, 16.0);
      expect(desktopSize, 18.0);
    });

    test('should get heading size for level', () {
      final h1Size = ResponsiveTypography.getHeadingSize(Breakpoint.mobile, 1);
      final h2Size = ResponsiveTypography.getHeadingSize(Breakpoint.tablet, 2);

      expect(h1Size, 24.0);
      expect(h2Size, 28.0);
    });

    test('should scale font size', () {
      final scaledSize = ResponsiveTypography.scaleFontSize(16.0, 800);
      expect(scaledSize, greaterThan(0));
    });
  });

  group('ResponsiveSpacing', () {
    test('should get spacing for breakpoint', () {
      final mobileSpacing = ResponsiveSpacing.getSpacing(Breakpoint.mobile);
      final tabletSpacing = ResponsiveSpacing.getSpacing(Breakpoint.tablet);
      final desktopSpacing = ResponsiveSpacing.getSpacing(Breakpoint.desktop);

      expect(mobileSpacing, 8.0);
      expect(tabletSpacing, 12.0);
      expect(desktopSpacing, 16.0);
    });

    test('should get spacing size', () {
      final xsSpacing =
          ResponsiveSpacing.getSpacingSize(Breakpoint.mobile, SpacingSize.xs);
      final lgSpacing =
          ResponsiveSpacing.getSpacingSize(Breakpoint.mobile, SpacingSize.lg);

      expect(xsSpacing, 2.0); // 8.0 * 0.25
      expect(lgSpacing, 12.0); // 8.0 * 1.5
    });

    test('should create EdgeInsets', () {
      final edgeInsets = ResponsiveSpacing.getAll(Breakpoint.mobile);
      expect(edgeInsets, EdgeInsets.all(8.0));
    });
  });

  group('ResponsiveSizing', () {
    test('should get sizing for breakpoint', () {
      final mobileSizing = ResponsiveSizing.getSizing(Breakpoint.mobile);
      final tabletSizing = ResponsiveSizing.getSizing(Breakpoint.tablet);
      final desktopSizing = ResponsiveSizing.getSizing(Breakpoint.desktop);

      expect(mobileSizing, 40.0);
      expect(tabletSizing, 50.0);
      expect(desktopSizing, 60.0);
    });

    test('should get responsive width', () {
      final width = ResponsiveSizing.getResponsiveWidth(1000, 50);
      expect(width, 500.0);
    });

    test('should get responsive height', () {
      final height = ResponsiveSizing.getResponsiveHeight(800, 25);
      expect(height, 200.0);
    });

    test('should get square size', () {
      final squareSize = ResponsiveSizing.getSquareSize(1000, 25);
      expect(squareSize, 250.0);
    });
  });

  group('ResponsiveMedia', () {
    test('should get responsive value', () {
      final value = ResponsiveMedia.responsiveValue<int>(
        screenWidth: 800,
        mobile: 1,
        tablet: 2,
        desktop: 3,
        fallback: 0,
      );
      expect(value, 2); // Should return tablet value
    });

    test('should get responsive double', () {
      final value = ResponsiveMedia.responsiveDouble(
        screenWidth: 800,
        mobile: 16.0,
        tablet: 18.0,
        desktop: 20.0,
        fallback: 16.0,
      );
      expect(value, 18.0); // Should return tablet value
    });

    test('should check width in range', () {
      expect(ResponsiveMedia.isWidthInRange(500, 400, 600), true);
      expect(ResponsiveMedia.isWidthInRange(300, 400, 600), false);
    });
  });

  group('OrientationHelper', () {
    test('should get orientation value', () {
      final portraitValue = OrientationHelper.orientationValue<int>(
        orientation: Orientation.portrait,
        portrait: 1,
        landscape: 2,
        fallback: 0,
      );
      expect(portraitValue, 1);

      final landscapeValue = OrientationHelper.orientationValue<int>(
        orientation: Orientation.landscape,
        portrait: 1,
        landscape: 2,
        fallback: 0,
      );
      expect(landscapeValue, 2);
    });

    test('should get orientation double', () {
      final value = OrientationHelper.orientationDouble(
        orientation: Orientation.portrait,
        portrait: 16.0,
        landscape: 18.0,
        fallback: 16.0,
      );
      expect(value, 16.0);
    });
  });

  group('Widget Tests', () {
    testWidgets('ResponsiveText should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveText('Hello World'),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('ResponsiveHeading should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveHeading('Hello World', level: 1),
        ),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('ResponsiveBuilder should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveBuilder(
            builder: (context, breakpoint, size) {
              return Text('Breakpoint: ${breakpoint.name}');
            },
          ),
        ),
      );

      expect(find.textContaining('Breakpoint:'), findsOneWidget);
    });

    testWidgets('ResponsiveLayout should render fallback widget',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveLayout(
            fallback: Text('Fallback'),
          ),
        ),
      );

      // Should render fallback widget
      expect(find.text('Fallback'), findsOneWidget);
    });

    testWidgets('ResponsiveGrid should render', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveGrid(
            columns: 12,
            children: [
              Container(child: Text('Item 1')),
              Container(child: Text('Item 2')),
            ],
          ),
        ),
      );

      expect(find.text('Item 1'), findsOneWidget);
      expect(find.text('Item 2'), findsOneWidget);
    });
  });
}
