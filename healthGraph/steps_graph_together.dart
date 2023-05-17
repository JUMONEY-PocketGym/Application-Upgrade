// ignore_for_file: prefer_const_constructors

import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pock_gym/samsunghealth/method_channel.dart';
import 'package:pock_gym/samsunghealth/models/steps.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/details/samsungTogetherDetailPages/controller/samsung_together_detail_page_b_contoller.dart';
import 'package:pock_gym/utils/hex_color.dart';
import 'package:pock_gym/utils/number_format.dart';
import 'package:pock_gym/val/color.dart';
import 'package:table_calendar/table_calendar.dart';

import '../ui/mainPage/subPage/subPage01/details/samsungSoloDetailPages/controller/samsung_solo_detail_page_b_contoller.dart';

Color calendarHighlight = HexColor.fromHex("#ccf7ea");
Color unselectedGrey = HexColor.fromHex("#d8dce0");

class TogetherStepsGraphChartPage extends StatefulWidget {
  final DateTime startDate;
  final double maxDailySteps;
  final double maxOverallSteps;
  final DateTime endDate;
  final SamsungTogetherDetailPageBeforeController controller;
  final bool? end;
  const TogetherStepsGraphChartPage({super.key, required this.startDate, required this.endDate, required this.maxDailySteps, required this.maxOverallSteps, required this.controller, this.end});

  @override
  State<TogetherStepsGraphChartPage> createState() => _TogetherStepsGraphChartPageState();
}

class _TogetherStepsGraphChartPageState extends State<TogetherStepsGraphChartPage> {
  bool isConnected = false;
  bool isAvailable = false;
  double totalDistance = 0;
  double totalCalorie = 0;
  double totalSteps = 0;
  double todaySteps = 0;
  double todayDistance = 0;
  double todayCalorie = 0;
  List<StepsDataModel> stepsDataList = [];

  late PageController calendarController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (SamsungHealth.isConnected) {
        int response = await SamsungHealth.checkPermissions(context);
        if (response == 0) {
          getStepTrend();
          setState(() {
            isAvailable = true;
          });

          if (widget.end != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              setState(() {
                focusedDay = widget.startDate.toLocal();
                // rangeStart = null;
                // rangeEnd = null;
              });
            });
          }
        }
      } else {
        isConnected = await SamsungHealth.connectToSamsungHealth(context);
        if (isConnected) {
          int response = await SamsungHealth.checkPermissions(context);
          if (response == 0) {
            getStepTrend();
            setState(() {
              isAvailable = true;
            });

            if (widget.end != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) async {
                setState(() {
                  focusedDay = widget.startDate.toLocal();
                  // rangeStart = null;
                  // rangeEnd = null;
                });
              });
            }
          }
        }
      }
    });
    super.initState();
  }

  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var maxSteps = (totalSteps / widget.maxOverallSteps) * 100;

    if (maxSteps > 100) {
      maxSteps = 100;
    }

    navigateNextMonth() {
      calendarController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    navigatePreviousMonth() {
      calendarController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }

    pageChanged(newDate) {
      setState(() {
        focusedDay = newDate;
        // rangeStart = null;
        // rangeEnd = null;
        // widget.selectedFirstDate(rangeStart);
        // widget.selectedLastDate(rangeEnd);
      });
    }

    return isAvailable
        ? Container(
            margin: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  color: white,
                  child: Column(children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: navigatePreviousMonth,
                            icon: Icon(
                              Icons.chevron_left,
                              color: black,
                            )),
                        Expanded(
                          child: Center(
                            child: Text(
                              // DateFormat("yyyy.MM").format(widget.startDate),
                              DateFormat("yyyy. MM").format(focusedDay),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: navigateNextMonth,
                            icon: Icon(
                              Icons.chevron_right,
                              color: black,
                            )),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      color: Colors.white,
                      child: TableCalendar(
                        onCalendarCreated: ((pageController) => calendarController = pageController),
                        availableGestures: AvailableGestures.none,
                        headerVisible: false,
                        locale: "ko",
                        rowHeight: 44,
                        // focusedDay: widget.startDate,
                        focusedDay: focusedDay,
                        onPageChanged: pageChanged,
                        firstDay: DateTime(2022),
                        lastDay: DateTime(2050),
                        rangeSelectionMode: RangeSelectionMode.enforced,
                        rangeStartDay: widget.startDate,
                        rangeEndDay: widget.endDate,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle: TextStyle(fontSize: 12),
                          weekendStyle: TextStyle(fontSize: 12),
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            Color color = Colors.black;
                            if (day.isBefore(widget.startDate)) {
                              color = unselectedGrey;
                            }
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                DateFormat("d").format(day),
                                style: TextStyle(color: color),
                              ),
                            );
                          },
                          outsideBuilder: (context, day, focusedDay) {
                            return DefaultDayWidget(
                              day: day,
                            );
                          },
                          rangeStartBuilder: (context, day, focusedDay) {
                            return buildStepDay(day);
                          },
                          rangeEndBuilder: (context, day, focusedDay) {
                            return buildStepDay(day);
                          },
                          rangeHighlightBuilder: (context, day, isWithinRange) {
                            if (isWithinRange) {
                              return buildStepDay(day);
                            }
                            return Container();
                          },
                          todayBuilder: (context, day, focusedDay) {
                            return DefaultDayWidget(
                              day: day,
                            );
                          },
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 12),
                AspectRatio(
                  aspectRatio: 2.2,
                  child: Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("누적 걸음수"),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  f.format(totalSteps),
                                  // totalSteps.toStringAsFixed(0),
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        ignoring: true,
                        child: CircularSeekBar(
                          width: double.infinity,
                          height: 250,
                          progress: maxSteps,
                          barWidth: 6,
                          startAngle: 180,
                          trackColor: Colors.grey.shade200,
                          sweepAngle: 360,
                          strokeCap: StrokeCap.butt,
                          progressGradientColors: [
                            HexColor.fromHex("#1cb1f8"),
                            HexColor.fromHex("#02d798"),
                            HexColor.fromHex("#02d798"),
                            HexColor.fromHex("#1cb1f8"),
                            HexColor.fromHex("#1cb1f8"),
                          ],
                          innerThumbRadius: 4,
                          innerThumbColor: Colors.white,
                          outerThumbRadius: 6,
                          outerThumbStrokeWidth: 4.5,
                          outerThumbColor: HexColor.fromHex("#1cb1f8"),
                          animation: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "목표 " + f.format(widget.maxOverallSteps),
                  // "목표 ${widget.maxOverallSteps.toStringAsFixed(0)}",
                  style: TextStyle(
                    color: HexColor.fromHex("#02d798"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 0),
                  height: 64,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("누적거리"),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    totalDistance.toStringAsFixed(1),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  " km",
                                  style: TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 1,
                        color: Colors.grey.shade200,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("누적 소모 칼로리"),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    f.format(totalCalorie),
                                    // totalCalorie.toStringAsFixed(0),
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, 16),
                  height: 150,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 1, color: Colors.grey.shade200),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(children: [
                            Text("오늘의 걸음"),
                            Expanded(
                                child: Container(
                              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    AspectRatio(
                                      aspectRatio: 1,
                                      child: IgnorePointer(
                                        ignoring: true,
                                        child: CircularSeekBar(
                                          width: double.infinity,
                                          height: 250,
                                          progress: (todaySteps / widget.maxDailySteps) * 100,
                                          barWidth: 4,
                                          startAngle: 180,
                                          trackColor: Colors.grey.shade200,
                                          sweepAngle: 360,
                                          strokeCap: StrokeCap.butt,
                                          progressColor: HexColor.fromHex("#02d798"),
                                          innerThumbRadius: 3,
                                          innerThumbColor: Colors.white,
                                          outerThumbRadius: 3,
                                          outerThumbStrokeWidth: 4.5,
                                          outerThumbColor: HexColor.fromHex("#02d798"),
                                          animation: true,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      f.format(todaySteps),
                                      // "${todaySteps.toStringAsFixed(0)}",
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                            Text(
                              "일 최대 걸음수 : " + f.format(widget.maxDailySteps),
                              // "일 최대 걸음수 : ${widget.maxDailySteps.toStringAsFixed(0)}",
                              style: TextStyle(fontSize: 12),
                            ),
                          ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(12, 0, 0, 0),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1, color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text("오늘의 거리"),
                                SizedBox(
                                  height: 4,
                                ),
                                Center(
                                  child: Text(
                                    "${todayDistance.toStringAsFixed(1)} km",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(width: 1, color: Colors.grey.shade200),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                                Text("오늘의 소모 칼로리"),
                                SizedBox(
                                  height: 4,
                                ),
                                Center(
                                  child: Text(
                                    f.format(todayCalorie) + " kcal",
                                    // "${todayCalorie.toStringAsFixed(0)} kcal",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                )
              ],
            ),
          )
        : Container(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  "assets/img/alert_icn.png",
                  width: 46.w,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "삼성헬스 데이터 권한허용 후 이용가능합니다.",
                  style: TextStyle(fontSize: 16.sp, color: HexColor.fromHex("#6B7684")),
                )
              ],
            ),
          );
  }

  Widget buildStepDay(day) {
    String dateKey = "${day.year}_${day.month}_${day.day}";
    var stepsData = stepsDataList.where(
      (element) => element.createDate == dateKey,
    );
    double count = 0;
    if (stepsData.isNotEmpty) {
      count = stepsData.first.stepsCount!;
    }
    return Container(
      color: calendarHighlight,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    DateFormat("d").format(day),
                    style: TextStyle(color: Colors.black),
                  ),
                  CircularProgressIndicator(
                    strokeWidth: 3,
                    value: count / widget.maxDailySteps,
                    color: HexColor.fromHex("#02d798"),
                    backgroundColor: HexColor.fromHex("#d1d7db"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getStepTrend() async {
    List<DateTime> dateList = getDaysInBetween(widget.startDate, widget.endDate);
    DateTime dateToday = DateTime.now();
    String dateKey = "${dateToday.year}_${dateToday.month}_${dateToday.day}";
    for (var i = 0; i < dateList.length; i++) {
      var date = dateList.elementAt(i);
      print("Getting Steps for $date");
      var stepList = await SamsungHealth.getStepCount(
        startDate: date,
        limitSteps: widget.maxDailySteps,
      );

      stepsDataList.addAll(stepList);
    }

    for (var i = 0; i < stepsDataList.length; i++) {
      var data = stepsDataList.elementAt(i);
      totalDistance = totalDistance + data.distance!;
      totalCalorie = totalCalorie + data.calorie!;
      totalSteps = totalSteps + data.stepsCount!;
    }

    var value = stepsDataList
        .where(
          (element) => element.createDate == dateKey,
        )
        .toList();

    setState(() {
      stepsDataList = stepsDataList;
      if (value.isNotEmpty) {
        var model = value.first;
        todayCalorie = model.calorie!;
        todayDistance = model.distance! / 1000;
        todaySteps = model.stepsCount!;
        totalDistance = totalDistance / 1000;
        totalSteps = totalSteps;
        totalCalorie = totalCalorie;
      }
    });

    widget.controller.totalStepsCount(totalSteps.toInt());
  }
}

class DefaultDayWidget extends StatelessWidget {
  final DateTime day;
  const DefaultDayWidget({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        DateFormat("d").format(day),
        style: TextStyle(color: unselectedGrey, fontSize: 14),
      ),
    );
  }
}

List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
  List<DateTime> days = [];
  for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
    days.add(startDate.add(Duration(days: i)));
  }
  return days;
}
