import 'package:flutter/material.dart';

import 'my_progress.dart';

enum ProgressType { STEPPED, FILLED, MIXED }

class StepCircleProgressBar extends StatefulWidget {
  final double fillSize, circleSize;
  final int totalSteps, currentSteps;
  final Color progressColor, stepColor;
  final Widget? center;
  final ProgressType? progressType;
  final int total;

  StepCircleProgressBar({
    Key? key,
    this.fillSize = 10,
    this.progressType = ProgressType.MIXED,
    this.center,
    required this.circleSize,
    required this.totalSteps,
    required this.total,
    required this.currentSteps,
    required this.progressColor,
    required this.stepColor,
  }) : super(key: key);

  @override
  State<StepCircleProgressBar> createState() => _StepCircleProgressBarState();
}

class _StepCircleProgressBarState extends State<StepCircleProgressBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.circleSize,
      height: widget.circleSize,
      child: Stack(
        children: [
          Transform.rotate(
            angle: (widget.progressType == ProgressType.MIXED ? 0.1 : 0),
            child: Container(
              width: widget.circleSize,
              height: widget.circleSize,
              child: Stack(
                children: [
                  widget.progressType == ProgressType.STEPPED
                      ? getFullyStepProgressBar()
                      : widget.progressType == ProgressType.FILLED
                          ? getFullyFilledProgressBar()
                          : getStepProgressBar(),
                ],
              ),
            ),
          ),
          (widget.center != null) ? Center(child: widget.center) : SizedBox.expand(),
        ],
      ),
    );
  }

  getStepProgressBar() {
    return Stack(
      children: [
        MyProgress(
          totalSteps: widget.total,
          currentStep: calculateProgress(),
          removeRoundedCapExtraAngle: false,
          width: widget.circleSize,
          startingAngle: 0.1,
          stepSize: widget.fillSize,
          unselectedColor: widget.stepColor,
          selectedColor: widget.progressColor,
          roundedCap: (_, isSelected) => isSelected,
        ),
        MyProgress(
          totalSteps: widget.total,
          currentStep: calculateProgress(),
          removeRoundedCapExtraAngle: false,
          width: widget.circleSize,
          padding: 0,
          startingAngle: -0.2,
          stepSize: widget.fillSize,
          unselectedColor: Colors.transparent,
          selectedColor: widget.progressColor,
          roundedCap: (_, isSelected) => isSelected,
        ),
      ],
    );
  }

  getFullyStepProgressBar() {
    return MyProgress(
      totalSteps: widget.total,
      currentStep: calculateProgress(),
      removeRoundedCapExtraAngle: false,
      width: widget.circleSize,
      stepSize: widget.fillSize,
      unselectedColor: widget.stepColor,
      selectedColor: widget.progressColor,
      roundedCap: (_, isSelected) => isSelected,
    );
  }

  getFullyFilledProgressBar() {
    return MyProgress(
      totalSteps: widget.total,
      currentStep: calculateProgress(),
      removeRoundedCapExtraAngle: false,
      width: widget.circleSize,
      padding: 0,
      stepSize: widget.fillSize,
      unselectedColor: widget.stepColor,
      selectedColor: widget.progressColor,
      roundedCap: (_, isSelected) => isSelected,
    );
  }

  calculateProgress() {
    if (widget.totalSteps > 0) {
      return (widget.currentSteps / (widget.totalSteps / widget.total)).toInt();
    } else {
      return 0;
    }
  }
}
