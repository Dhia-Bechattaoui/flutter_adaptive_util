import 'package:flutter/material.dart';
import 'package:flutter_adaptive_util/flutter_adaptive_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Responsive Utils Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ResponsiveDemoPage(),
    );
  }
}

class ResponsiveDemoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 'Flutter Responsive Utils'.responsiveHeading(level: 1),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ResponsiveContextBuilder(
        builder: (context, responsiveContext) {
          return SingleChildScrollView(
            padding: context.paddingAll,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(context, responsiveContext.breakpoint),
                SizedBox(height: context.spacing * 2),
                _buildBreakpointInfo(
                    context, responsiveContext.breakpoint, responsiveContext),
                SizedBox(height: context.spacing * 2),
                _buildResponsiveGrid(context),
                SizedBox(height: context.spacing * 2),
                _buildTypographyDemo(context),
                SizedBox(height: context.spacing * 2),
                _buildSpacingDemo(context),
                SizedBox(height: context.spacing * 2),
                _buildOrientationDemo(context),
                SizedBox(height: context.spacing * 2),
                _buildSizingDemo(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Breakpoint breakpoint) {
    return Container(
      width: double.infinity,
      padding: context.paddingAll,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'Welcome to Flutter Responsive Utils!'.responsiveHeading(
            level: 1,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: context.spacing),
          'Current Breakpoint: ${breakpoint.name}'.responsiveText(
            style: TextStyle(color: Colors.white70),
          ),
          SizedBox(height: context.spacing),
          'Screen Size: ${context.screenWidth.round()} x ${context.screenHeight.round()}'
              .responsiveText(
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakpointInfo(BuildContext context, Breakpoint breakpoint,
      ResponsiveContext responsiveContext) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Breakpoint Information'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            _buildBreakpointRow(context, 'Mobile', responsiveContext.isMobile,
                breakpoint == Breakpoint.mobile),
            _buildBreakpointRow(context, 'Tablet', responsiveContext.isTablet,
                breakpoint == Breakpoint.tablet),
            _buildBreakpointRow(context, 'Desktop', responsiveContext.isDesktop,
                breakpoint == Breakpoint.desktop),
            _buildBreakpointRow(
                context,
                'Large Desktop',
                responsiveContext.isLargeDesktop,
                breakpoint == Breakpoint.largeDesktop),
            _buildBreakpointRow(
                context,
                'Extra Large',
                responsiveContext.isExtraLarge,
                breakpoint == Breakpoint.extraLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakpointRow(
      BuildContext context, String name, bool isActive, bool isCurrent) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.spacing * 0.5),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isCurrent
                  ? Colors.green
                  : (isActive ? Colors.orange : Colors.grey),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: context.spacing),
          name.responsiveText(),
          Spacer(),
          if (isCurrent)
            'Current'.responsiveText(
                style: TextStyle(
                    color: Colors.green, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Responsive Grid Demo'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            ResponsiveGrid(
              columns: 12,
              spacing: context.spacing,
              children: [
                _buildGridCard('Grid Item 1', Colors.blue).asGridItem(
                  span: 6,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildGridCard('Grid Item 2', Colors.green).asGridItem(
                  span: 6,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildGridCard('Grid Item 3', Colors.orange).asGridItem(
                  span: 4,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildGridCard('Grid Item 4', Colors.red).asGridItem(
                  span: 4,
                  mobileSpan: 12,
                  tabletSpan: 6,
                ),
                _buildGridCard('Grid Item 5', Colors.purple).asGridItem(
                  span: 4,
                  mobileSpan: 12,
                  tabletSpan: 12,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridCard(String title, Color color) {
    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            title.responsiveHeading(
                level: 3, style: TextStyle(color: Colors.white)),
            SizedBox(height: 8.0),
            'This grid item adapts to different screen sizes.'.responsiveText(
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypographyDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Responsive Typography Demo'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            'This is a responsive heading level 1'.responsiveHeading(level: 1),
            SizedBox(height: context.spacing * 0.5),
            'This is a responsive heading level 2'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing * 0.5),
            'This is a responsive heading level 3'.responsiveHeading(level: 3),
            SizedBox(height: context.spacing * 0.5),
            'This is responsive body text that scales with screen size.'
                .responsiveText(),
            SizedBox(height: context.spacing * 0.5),
            'This is smaller responsive text.'.responsiveText(scale: 0.8),
            SizedBox(height: context.spacing * 0.5),
            'This is larger responsive text.'.responsiveText(scale: 1.2),
          ],
        ),
      ),
    );
  }

  Widget _buildSpacingDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Responsive Spacing Demo'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            Container(
              padding: context.paddingAll,
              margin: context.paddingSymmetric(horizontal: context.spacing),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: .1),
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: 'This container uses responsive padding and margin'
                  .responsiveText(),
            ),
            SizedBox(height: context.spacing),
            Row(
              children: [
                Container(
                  width: context.spacingSize(SpacingSize.xs),
                  height: context.spacingSize(SpacingSize.xs),
                  color: Colors.red,
                ),
                SizedBox(width: context.spacing * 0.5),
                Container(
                  width: context.spacingSize(SpacingSize.sm),
                  height: context.spacingSize(SpacingSize.sm),
                  color: Colors.orange,
                ),
                SizedBox(width: context.spacing * 0.5),
                Container(
                  width: context.spacingSize(SpacingSize.md),
                  height: context.spacingSize(SpacingSize.md),
                  color: Colors.yellow,
                ),
                SizedBox(width: context.spacing * 0.5),
                Container(
                  width: context.spacingSize(SpacingSize.lg),
                  height: context.spacingSize(SpacingSize.lg),
                  color: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrientationDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Orientation Demo'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            ResponsiveOrientationLayout(
              portrait: Container(
                padding: context.paddingAll,
                color: Colors.blue.withValues(alpha: .1),
                child: 'Portrait Layout'.responsiveText(),
              ),
              landscape: Container(
                padding: context.paddingAll,
                color: Colors.green.withValues(alpha: .1),
                child: 'Landscape Layout'.responsiveText(),
              ),
            ),
            SizedBox(height: context.spacing),
            Container(
              padding: context.orientationPadding(
                portrait: EdgeInsets.all(16.0),
                landscape: EdgeInsets.all(24.0),
                fallback: EdgeInsets.all(16.0),
              ),
              decoration: BoxDecoration(
                color: context.isPortrait
                    ? Colors.purple.withValues(alpha: .1)
                    : Colors.orange.withValues(alpha: .1),
                border: Border.all(
                  color: context.isPortrait ? Colors.purple : Colors.orange,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child:
                  'Orientation: ${context.isPortrait ? "Portrait" : "Landscape"}'
                      .responsiveText(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizingDemo(BuildContext context) {
    return Card(
      child: Padding(
        padding: context.paddingAll,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            'Responsive Sizing Demo'.responsiveHeading(level: 2),
            SizedBox(height: context.spacing),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: context.responsiveHeight(20),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: .2),
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: '20% Height'.responsiveText(),
                    ),
                  ),
                ),
                SizedBox(width: context.spacing),
                Expanded(
                  child: Container(
                    height: context.responsiveHeight(20),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: .2),
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: '20% Height'.responsiveText(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.spacing),
            Center(
              child: Container(
                width: context.responsiveSquare(25),
                height: context.responsiveSquare(25),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: .2),
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: '25% Square'.responsiveText(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
