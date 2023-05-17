import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/hex_color.dart';
import 'package:table_calendar/table_calendar.dart';

// Conflicting Versions Must match
// table_calendar: ^3.0.8
// intl: ^0.17.0

Color rangePink = HexColor.fromHex("#ffe5df");
Color rangeRed = HexColor.fromHex("#ee4a5b");

class SuccessCalendarDataModel {
  int? month;
  int? year;
  String? challengeStart;
  String? challengeEnd;
  List<String>? successDates;

  SuccessCalendarDataModel({this.month, this.year, this.challengeStart, this.challengeEnd, this.successDates});

  SuccessCalendarDataModel.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    year = json['year'];
    challengeStart = json['challenge_start'];
    challengeEnd = json['challenge_end'];
    successDates = json['success_dates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['year'] = this.year;
    data['challenge_start'] = this.challengeStart;
    data['challenge_end'] = this.challengeEnd;
    data['success_dates'] = this.successDates;
    return data;
  }
}

class SuccessCalendarDisplay extends StatefulWidget {
  final List<SuccessCalendarDataModel> successDataList;
  final bool? end;
  const SuccessCalendarDisplay({super.key, required this.successDataList, this.end});

  @override
  State<SuccessCalendarDisplay> createState() => _SuccessCalendarDisplayState();
}

class _SuccessCalendarDisplayState extends State<SuccessCalendarDisplay> {
  late PageController calendarController;
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  SuccessCalendarDataModel? currentSuccessDataSet;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      parseData();
      initDate();
    });
    super.initState();
  }

  initDate() async {
    if (widget.end != null) {
      // dPrint(widget.end);
      // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   setState(() {
      //     focusedDay = DateTime.parse(currentSuccessDataSet!.challengeStart!);
      //     // rangeStart = null;
      //     // rangeEnd = null;
      //   });
      // });
      // parseData();
    } else {
      navigatePreviousMonth();
      await 0.5.delay();
      navigateNextMonth();
    }
  }

  parseData() async {
    List<SuccessCalendarDataModel> successData = widget.successDataList;
    List<SuccessCalendarDataModel> validList = successData.where((element) => element.year == focusedDay.year && element.month == focusedDay.month).toList();
    if (widget.end != null) {
      dPrint(widget.successDataList.first.challengeStart!);
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        setState(() {
          focusedDay = DateTime.parse(widget.successDataList.first.challengeStart!).toLocal();
          // rangeStart = null;
          // rangeEnd = null;
          dPrint(focusedDay);
        });
      });
    }
    if (validList.isNotEmpty) {
      //Valid
      // "2023-01-01 00:00:00"

      setState(() {
        currentSuccessDataSet = validList.first;
        // print("${currentSuccessDataSet!.toJson()}");
        rangeStart = DateTime.parse(currentSuccessDataSet!.challengeStart!);
        rangeEnd = DateTime.parse(currentSuccessDataSet!.challengeEnd!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
          child: Row(
            children: [
              IconButton(onPressed: navigatePreviousMonth, icon: Icon(Icons.chevron_left)),
              Expanded(
                child: Center(
                  child: Text(
                    DateFormat("yyyy. M").format(focusedDay),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              IconButton(onPressed: navigateNextMonth, icon: Icon(Icons.chevron_right)),
            ],
          ),
        ),
        IgnorePointer(
          ignoring: true,
          child: TableCalendar(
            headerVisible: false,
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            availableGestures: AvailableGestures.none,
            rangeStartDay: rangeStart,
            rangeEndDay: rangeEnd,
            sixWeekMonthsEnforced: false,
            rowHeight: 50, // 달력 날짜 박스 높이 수정 할뗴
            calendarFormat: CalendarFormat.month,
            onCalendarCreated: ((pageController) => calendarController = pageController),
            // focusedDay: DateTime.parse("2022-05-01"),
            // focusedDay: rangeStart!,
            // focusedDay: DateTime.now(),
            focusedDay: focusedDay,
            firstDay: DateTime(2020, 1), //달력 최소 선택할수 잇는 날
            lastDay: DateTime(2050, 1), //다력 최대 선택할수 있는 날
            rangeSelectionMode: RangeSelectionMode.enforced,
            onDaySelected: daySelected,
            onRangeSelected: rangeSelected,
            daysOfWeekHeight: 24, // 주 이름 바 높이
            startingDayOfWeek: StartingDayOfWeek.monday, //주 시작날
            onPageChanged: pageChanged,
            calendarBuilders: CalendarBuilders(
              dowBuilder: ((context, selected) {
                String date = DateFormat("E").format(selected);
                String day = "";
                switch (selected.weekday) {
                  case DateTime.monday:
                    day = "월";
                    break;
                  case DateTime.tuesday:
                    day = "화";

                    break;
                  case DateTime.wednesday:
                    day = "수";

                    break;
                  case DateTime.thursday:
                    day = "목";

                    break;
                  case DateTime.friday:
                    day = "금";

                    break;
                  case DateTime.saturday:
                    day = "토";

                    break;
                  case DateTime.sunday:
                    day = "일";

                    break;
                  default:
                }
                return Container(
                  // margin: EdgeInsets.only(bottom: 10.h),
                  alignment: Alignment.center,
                  child: Text(
                    day,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                );
              }),
              rangeStartBuilder: (context, day, focusedDay) {
                bool isValid = checkValidity(day);
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  color: rangePink,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "${DateFormat("d").format(day)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                    checkWidget(isValid),
                  ]),
                );
              },
              defaultBuilder: (context, day, focusedDay) {
                var formattedDate = DateFormat("d").format(day);
                return defaultDateWidget(formattedDate, day);
              },
              outsideBuilder: ((context, day, focusedDay) {
                var formattedDate = DateFormat("d").format(day);
                // return Container(
                //   alignment: Alignment.center,
                //   child: Text(
                //     formattedDate,
                //     style: TextStyle(fontSize: 16, color: Colors.grey),
                //   ),
                // );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      formattedDate,
                      style: TextStyle(fontSize: 15.sp, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 18.h,
                    )
                  ],
                );
              }),
              todayBuilder: ((context, day, focusedDay) {
                var formattedDate = DateFormat("d").format(day);
                return defaultDateWidget(formattedDate, day);
              }),
              rangeHighlightBuilder: (context, day, withInHighlight) {
                if (withInHighlight) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    width: double.infinity,
                    color: rangePink,
                  );
                }
                return SizedBox();
              },
              withinRangeBuilder: ((context, day, focusedDay) {
                var formattedDate = DateFormat("d").format(day);
                bool isValid = checkValidity(day);
                return Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                      checkWidget(isValid),
                    ],
                  ),
                );
              }),
              rangeEndBuilder: (context, day, focusedDay) {
                bool isValid = checkValidity(day);
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  width: double.infinity,
                  color: rangePink,
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      "${DateFormat("d").format(day)}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.sp,
                      ),
                    ),
                    checkWidget(isValid),
                  ]),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget checkWidget(bool isValid) {
    if (isValid) {
      return Icon(
        CupertinoIcons.checkmark_alt_circle_fill,
        size: 18,
        color: rangeRed,
      );
    }
    return Icon(
      CupertinoIcons.checkmark_alt_circle_fill,
      size: 18,
      color: Colors.transparent,
    );
  }

  Widget defaultDateWidget(String formattedDate, DateTime day) {
    bool isValid;
    try {
      isValid = checkValidity(day);
    } catch (e) {
      isValid = false;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        checkWidget(isValid),
      ],
    );
  }

  String datekeyValue(DateTime dateTime) {
    return "${dateTime.year}_${dateTime.month}_${dateTime.day}";
  }

  bool checkValidity(DateTime day) {
    return currentSuccessDataSet!.successDates!
        .where((element) {
          var thisDateKey = datekeyValue(day);
          bool isValid = datekeyValue(DateTime.parse(element).toLocal()) == thisDateKey;
          // print("$isValid : $thisDateKey");
          return isValid;
        })
        .toList()
        .isNotEmpty;
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
    });
    parseData();
  }

  rangeSelected(start, end, DateTime thisDay) {
    // print("range selected");
    if (start.month != focusedDay.month) {
      if (start.month > thisDay.month) {
        navigatePreviousMonth();
      } else {
        navigateNextMonth();
      }
      return;
    }
    setState(() {
      selectedDay = null;
      focusedDay = thisDay;
      rangeStart = start;
      rangeEnd = end;
    });
  }

  daySelected(thisDate, currentFocus) {
    if (!isSameDay(selectedDay, thisDate)) {
      setState(() {
        selectedDay = thisDate;
        focusedDay = currentFocus;
        rangeStart = null;
        rangeEnd = null;
      });
    }
  }
}
