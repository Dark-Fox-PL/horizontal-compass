import 'package:flutter/material.dart';

enum HorizontalCompassType { finite, infinite }

enum HorizontalCompassRulerPosition { top, center, bottom }

/// Main widget class.
class HorizontalCompass extends StatefulWidget {
  /// Stores current value for widget.
  final double value;

  /// Determines spaces between ruler lines.
  final double spacing;

  /// Set widget width, if [width] is set to null, whole possible width will be used.
  final double? width;

  /// Set widget height.
  final double height;

  /// Set first value for widget.
  final double start;

  /// Set last value for widget.
  final double end;

  /// Required field with dataset, String might be random, as it's not used (to things other than just code organisation) and maybe labels
  /// in the future version.
  ///
  /// ```dart
  /// Map<String, double> segments = {
  ///   'a': 10.0,
  ///   'b': 30.0,
  ///   'c': 5.0
  /// }
  /// ```
  ///
  /// Given example means that 3 segments should be created. 'a' will take values 0-10. 'b' 10-40 and 'c' 40-45.
  final Map<String, double> segments;

  /// List of the colors for [segments] created before.
  final List<Color> colors;

  /// Determine the type of widget to be used.
  final HorizontalCompassType type;

  /// Determine look of the ruler.
  final HorizontalCompassRulerPosition rulerPosition;

  /// Cursor (a main line places in the central point of the widget) look, invisible by default.
  final Color cursorColor;

  /// And width for the cursor.
  final double cursorWidth;

  /// Ruler line width.
  final double lineWidth;

  /// Every 'n' line will be bigger.
  final int markPosition;

  const HorizontalCompass({
    super.key,
    this.spacing = 15.0,
    this.width,
    this.height = 30.0,
    this.start = 0.0,
    this.end = 360.0,
    this.type = HorizontalCompassType.finite,
    this.rulerPosition = HorizontalCompassRulerPosition.center,
    this.cursorColor = Colors.transparent,
    this.cursorWidth = 5,
    this.lineWidth = 2,
    this.markPosition = 5,
    required this.value,
    required this.segments,
    required this.colors,
  });

  @override
  HorizontalCompassState createState() => HorizontalCompassState();
}

class HorizontalCompassState extends State<HorizontalCompass>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: widget.value, end: widget.value)
        .animate(_animationController);
  }

  @override
  void didUpdateWidget(HorizontalCompass oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value != oldWidget.value) {
      double newValue = widget.value;

      if (widget.type == HorizontalCompassType.infinite) {
        double oldValue = _animation.value;
        double fullRange = widget.end - widget.start;
        double delta = (newValue - oldValue) % fullRange;

        if (delta > fullRange / 2) {
          delta -= fullRange;
        } else if (delta < -fullRange / 2) {
          delta += fullRange;
        }

        newValue = oldValue + delta;
      }

      _animation = Tween<double>(begin: _animation.value, end: newValue)
          .animate(_animationController);
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return CustomPaint(
              size: Size(widget.width ?? constraints.maxWidth, widget.height),
              painter: CompassPainter(
                value: _animation.value,
                spacing: widget.spacing,
                start: widget.start,
                end: widget.end,
                segments: widget.segments,
                colors: widget.colors,
                type: widget.type,
                rulerPosition: widget.rulerPosition,
                cursorColor: widget.cursorColor,
                cursorWidth: widget.cursorWidth,
                lineWidth: widget.lineWidth,
                markPosition: widget.markPosition,
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class CompassPainter extends CustomPainter {
  final double value;
  final double spacing;
  final double start;
  final double end;
  final Map<String, double> segments;
  final List<Color> colors;
  final HorizontalCompassType type;
  final HorizontalCompassRulerPosition rulerPosition;
  final Color cursorColor;
  final double cursorWidth;
  final double lineWidth;
  final int markPosition;

  CompassPainter({
    required this.value,
    required this.spacing,
    required this.start,
    required this.end,
    required this.segments,
    required this.colors,
    required this.type,
    required this.rulerPosition,
    required this.cursorColor,
    required this.cursorWidth,
    required this.lineWidth,
    required this.markPosition,
  });

  /// Get valid color for current segment.
  int getColorIndexForDegree(double degree) {
    double currentSegmentEnd = start;
    int index = 0;

    while (currentSegmentEnd < degree) {
      if (index < segments.length) {
        currentSegmentEnd += segments.values.elementAt(index);
        index++;
      } else {
        break;
      }
    }

    index--;

    if (index < 0) {
      index = 0;
    } else if (index >= colors.length) {
      index = colors.length - 1;
    }

    return index;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double segmentWidth = spacing;
    double lineHeight = size.height / 2;

    Paint markerPaint = Paint()..strokeWidth = lineWidth;

    double extendedStart = start;
    double extendedEnd = end;

    if (type == HorizontalCompassType.infinite) {
      extendedStart -= (end - start);
      extendedEnd += (end - start);
    }

    for (int i = extendedStart.toInt(); i <= extendedEnd.toInt(); i++) {
      int colorIndex;
      int wrappedI = i;

      if (type == HorizontalCompassType.infinite) {
        while (wrappedI < start) {
          wrappedI += (end - start).toInt();
        }

        while (wrappedI > end) {
          wrappedI -= (end - start).toInt();
        }
      } else {
        wrappedI = i;
      }

      colorIndex = getColorIndexForDegree(wrappedI.toDouble());

      markerPaint.color = colors[colorIndex];
      double lineTop;
      double lineBottom;

      if (i % markPosition == 0) {
        lineTop = 0;
        lineBottom = size.height;
      } else {
        switch (rulerPosition) {
          case HorizontalCompassRulerPosition.top:
            lineTop = 0;
            lineBottom = lineHeight;
            break;
          case HorizontalCompassRulerPosition.center:
            lineTop = lineHeight / 2;
            lineBottom = lineHeight + (lineHeight / 2);
            break;
          case HorizontalCompassRulerPosition.bottom:
          default:
            lineTop = lineHeight;
            lineBottom = size.height;
            break;
        }
      }

      double centerOffset = (size.width / 2) - (value * spacing);

      canvas.drawLine(
        Offset((i * spacing) + centerOffset, lineTop),
        Offset((i * spacing) + centerOffset, lineBottom),
        markerPaint,
      );
    }

    final Paint centerMarkerPaint = Paint()
      ..color = cursorColor
      ..strokeWidth = cursorWidth;

    canvas.drawLine(
      Offset(size.width / 2, 0),
      Offset(size.width / 2, size.height),
      centerMarkerPaint,
    );
  }

  @override
  bool shouldRepaint(CompassPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
