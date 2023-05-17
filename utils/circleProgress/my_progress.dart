library circular_step_progress_indicator;

import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyProgress extends StatelessWidget {
  final CircularDirection circularDirection;

  final int currentStep;

  final int totalSteps;

  final double padding;

  final double? height;

  final double? width;
  final Color Function(int)? customColor;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double stepSize;
  final double? selectedStepSize;
  final double? unselectedStepSize;
  final double Function(int, bool)? customStepSize;
  final Widget? child;
  final double fallbackHeight;
  final double fallbackWidth;
  final double startingAngle;
  final double arcSize;
  final bool Function(int, bool)? roundedCap;
  final Gradient? gradientColor;
  final bool removeRoundedCapExtraAngle;

  const MyProgress({
    required this.totalSteps,
    this.child,
    this.height,
    this.width,
    this.customColor,
    this.customStepSize,
    this.selectedStepSize,
    this.unselectedStepSize,
    this.roundedCap,
    this.gradientColor,
    this.circularDirection = CircularDirection.clockwise,
    this.fallbackHeight = 100.0,
    this.fallbackWidth = 100.0,
    this.currentStep = 0,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.padding = math.pi / 20,
    this.stepSize = 6.0,
    this.startingAngle = 0,
    this.arcSize = math.pi * 2,
    this.removeRoundedCapExtraAngle = false,
    Key? key,
  })  : assert(totalSteps > 0, "Number of total steps (totalSteps) of the CircularStepProgressIndicator must be greater than 0"),
        assert(currentStep >= 0, "Current step (currentStep) of the CircularStepProgressIndicator must be greater than or equal to 0"),
        assert(padding >= 0.0, "Padding (padding) of the CircularStepProgressIndicator must be greater or equal to 0"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // Print warning when arcSize greater than math.pi * 2 which causes steps to overlap
    if (arcSize > math.pi * 2) print("WARNING (step_progress_indicator): arcSize of CircularStepProgressIndicator is greater than 360° (math.pi * 2), this will cause some steps to overlap!");
    final TextDirection textDirection = Directionality.of(context);

    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        // Apply fallback for both height and width
        // if their value is null and no parent size limit
        height: height != null
            ? height
            : constraints.maxHeight != double.infinity
                ? constraints.maxHeight
                : fallbackHeight,
        width: width != null
            ? width
            : constraints.maxWidth != double.infinity
                ? constraints.maxWidth
                : fallbackWidth,
        child: CustomPaint(
          painter: _CircularIndicatorPainter(
            totalSteps: totalSteps,
            currentStep: currentStep,
            customColor: customColor,
            padding: padding,
            circularDirection: circularDirection,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
            arcSize: arcSize,
            stepSize: stepSize,
            customStepSize: customStepSize,
            maxDefinedSize: maxDefinedSize,
            selectedStepSize: selectedStepSize,
            unselectedStepSize: unselectedStepSize,
            startingAngle: startingAngleTopOfIndicator,
            roundedCap: roundedCap,
            gradientColor: gradientColor,
            textDirection: textDirection,
            removeRoundedCapExtraAngle: removeRoundedCapExtraAngle,
          ),
          // Padding needed to show the indicator when child is placed on top of it
          child: Padding(
            padding: EdgeInsets.all(maxDefinedSize),
            child: child,
          ),
        ),
      ),
    );
  }

  double get maxDefinedSize {
    if (customStepSize == null) {
      return math.max(stepSize, math.max(selectedStepSize ?? 0, unselectedStepSize ?? 0));
    }

    // When customSize defined, compute and return max possible size
    double currentMaxSize = 0;

    for (int step = 0; step < totalSteps; ++step) {
      // Consider max between selected and unselected case
      final customSizeValue = math.max(customStepSize!(step, false), customStepSize!(step, true));
      if (customSizeValue > currentMaxSize) {
        currentMaxSize = customSizeValue;
      }
    }

    return currentMaxSize;
  }

  double get startingAngleTopOfIndicator => startingAngle - math.pi / 2;
}

class _CircularIndicatorPainter implements CustomPainter {
  final int totalSteps;
  final int currentStep;
  final double padding;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double stepSize;
  final double? selectedStepSize;
  final double? unselectedStepSize;
  final double Function(int, bool)? customStepSize;
  final double maxDefinedSize;
  final Color Function(int)? customColor;
  final CircularDirection circularDirection;
  final double startingAngle;
  final double arcSize;
  final bool Function(int, bool)? roundedCap;
  final Gradient? gradientColor;
  final TextDirection textDirection;
  final bool removeRoundedCapExtraAngle;

  _CircularIndicatorPainter({
    required this.totalSteps,
    required this.circularDirection,
    required this.customColor,
    required this.currentStep,
    required this.selectedColor,
    required this.unselectedColor,
    required this.padding,
    required this.stepSize,
    required this.selectedStepSize,
    required this.unselectedStepSize,
    required this.customStepSize,
    required this.startingAngle,
    required this.arcSize,
    required this.maxDefinedSize,
    required this.roundedCap,
    required this.gradientColor,
    required this.textDirection,
    required this.removeRoundedCapExtraAngle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final stepLength = arcSize / totalSteps;

    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = maxDefinedSize;

    final rect = Rect.fromCenter(
      center: Offset(w / 2, h / 2),
      height: h - maxDefinedSize,
      width: w - maxDefinedSize,
    );

    if (gradientColor != null) {
      paint.shader = gradientColor!.createShader(rect, textDirection: textDirection);
    }
    final isClockwise = circularDirection == CircularDirection.clockwise;
    if (padding == 0 && customColor == null && customStepSize == null && roundedCap == null) {
      _drawContinuousArc(canvas, paint, rect, isClockwise);
    } else {
      _drawStepArc(canvas, paint, rect, isClockwise, stepLength);
    }
  }

  void _drawStepArc(Canvas canvas, Paint paint, Rect rect, bool isClockwise, double stepLength) {
    int step = isClockwise ? totalSteps - 1 : 0;
    double stepAngle = isClockwise ? startingAngle - stepLength : startingAngle;
    for (; isClockwise ? step >= 0 : step < totalSteps; isClockwise ? stepAngle -= stepLength : stepAngle += stepLength, isClockwise ? --step : ++step) {
      final isSelectedColor = _isSelectedColor(step, isClockwise);

      final indexStepSize = customStepSize != null
          ? customStepSize!(_indexOfStep(step, isClockwise), isSelectedColor)
          : isSelectedColor
              ? selectedStepSize ?? stepSize
              : unselectedStepSize ?? stepSize;

      final stepColor = customColor != null
          ? customColor!(_indexOfStep(step, isClockwise))
          : isSelectedColor
              ? selectedColor!
              : unselectedColor!;

      final hasStrokeCap = roundedCap != null ? roundedCap!(_indexOfStep(step, isClockwise), isSelectedColor) : false;
      final strokeCap = hasStrokeCap ? StrokeCap.round : StrokeCap.butt;
      final extraCapSize = indexStepSize / 2;
      final extraCapAngle = extraCapSize / (rect.width / 2);
      final extraCapRemove = hasStrokeCap && removeRoundedCapExtraAngle;

      _drawArcOnCanvas(
        canvas: canvas,
        rect: rect,
        startingAngle: stepAngle + (extraCapRemove ? extraCapAngle : 0),
        sweepAngle: stepLength - padding - (extraCapRemove ? extraCapAngle * 2 : 0),
        paint: paint,
        color: stepColor,
        strokeWidth: indexStepSize,
        strokeCap: strokeCap,
      );
    }
  }

  void _drawContinuousArc(Canvas canvas, Paint paint, Rect rect, bool isClockwise) {
    final firstStepColor = isClockwise ? selectedColor : unselectedColor;
    final secondStepColor = !isClockwise ? selectedColor : unselectedColor;

    final firstStepSize = isClockwise ? selectedStepSize ?? stepSize : unselectedStepSize ?? stepSize;
    final secondStepSize = !isClockwise ? selectedStepSize ?? stepSize : unselectedStepSize ?? stepSize;

    final firstArcLength = arcSize * (currentStep / totalSteps);
    final secondArcLength = arcSize - firstArcLength;

    final secondArcStartingAngle = startingAngle + firstArcLength;

    final firstArcStrokeCap = roundedCap != null
        ? isClockwise
            ? roundedCap!(0, true)
            : roundedCap!(1, false)
        : false;
    final secondArcStrokeCap = roundedCap != null
        ? isClockwise
            ? roundedCap!(1, false)
            : roundedCap!(0, true)
        : false;
    final firstCap = firstArcStrokeCap ? StrokeCap.round : StrokeCap.butt;
    final secondCap = secondArcStrokeCap ? StrokeCap.round : StrokeCap.butt;

    if (circularDirection == CircularDirection.clockwise) {
      _drawArcOnCanvas(
        canvas: canvas,
        rect: rect,
        paint: paint,
        startingAngle: secondArcStartingAngle,
        sweepAngle: secondArcLength,
        strokeWidth: secondStepSize,
        color: secondStepColor!,
        strokeCap: secondCap,
      );

      _drawArcOnCanvas(
        canvas: canvas,
        rect: rect,
        paint: paint,
        startingAngle: startingAngle,
        sweepAngle: firstArcLength,
        strokeWidth: firstStepSize,
        color: firstStepColor!,
        strokeCap: firstCap,
      );
    } else {
      _drawArcOnCanvas(
        canvas: canvas,
        rect: rect,
        paint: paint,
        startingAngle: startingAngle,
        sweepAngle: firstArcLength,
        strokeWidth: firstStepSize,
        color: firstStepColor!,
        strokeCap: firstCap,
      );

      _drawArcOnCanvas(
        canvas: canvas,
        rect: rect,
        paint: paint,
        startingAngle: secondArcStartingAngle,
        sweepAngle: secondArcLength,
        strokeWidth: secondStepSize,
        color: secondStepColor!,
        strokeCap: secondCap,
      );
    }
  }

  void _drawArcOnCanvas({
    required Canvas canvas,
    required Rect rect,
    required double startingAngle,
    required double sweepAngle,
    required Paint paint,
    required Color color,
    required double strokeWidth,
    required StrokeCap strokeCap,
  }) =>
      canvas.drawArc(
        rect,
        startingAngle,
        sweepAngle,
        false /*isRadial*/,
        paint
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = strokeCap,
      );

  bool _isSelectedColor(int step, bool isClockwise) => isClockwise ? step < currentStep : (step + 1) > (totalSteps - currentStep);

  int _indexOfStep(int step, bool isClockwise) => isClockwise ? step : totalSteps - step - 1;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => oldDelegate != this;

  @override
  bool hitTest(Offset position) => false;

  @override
  void addListener(listener) {}

  @override
  void removeListener(listener) {}

  @override
  get semanticsBuilder => null;

  @override
  bool shouldRebuildSemantics(CustomPainter oldDelegate) => false;
}

enum CircularDirection {
  clockwise,
  counterclockwise,
}
