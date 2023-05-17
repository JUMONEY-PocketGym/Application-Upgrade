import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pock_gym/ui/dialog/splash/quest_exist_dialog.dart';
import 'package:pock_gym/ui/mainPage/subPage/subPage01/buyQuest/model/qeust_period_check_response.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/hex_color.dart';
import 'package:pock_gym/utils/routers/target_path.dart';
import 'package:pock_gym/utils/toast/bottom_toast.dart';
import 'package:pock_gym/val/color.dart';
import 'package:table_calendar/table_calendar.dart';

import '../ui/dialog/splash/quest_pay_failed_dialog.dart';

// Conflicting Versions Must match
// table_calendar: ^3.0.8
// intl: ^0.17.0

Color rangePink = HexColor.fromHex("#ffe5df");
Color rangeRed = HexColor.fromHex("#ee4a5b");

class CustomRangerSelectorCalendar extends StatefulWidget {
  final int duration;
  final Function(DateTime?) selectedFirstDate;
  final Function(DateTime?) selectedLastDate;
  final List<QuestPeriodCheckResponse>? questCheck;
  const CustomRangerSelectorCalendar({super.key, required this.duration, required this.selectedFirstDate, required this.selectedLastDate, this.questCheck});

  @override
  State<CustomRangerSelectorCalendar> createState() => _CustomRangerSelectorCalendarState();
}

class _CustomRangerSelectorCalendarState extends State<CustomRangerSelectorCalendar> {
  late PageController calendarController;

  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? rangeStart;
  DateTime? rangeEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 12.h),
          child: Row(
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
                    DateFormat("yyyy. MM").format(focusedDay),
                    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
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
        ),
        TableCalendar(
          headerVisible: false,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          availableGestures: AvailableGestures.none,
          rangeStartDay: rangeStart,
          rangeEndDay: rangeEnd,
          sixWeekMonthsEnforced: false,
          rowHeight: 50.h, // 달력 날짜 박스 높이 수정 할뗴
          calendarFormat: CalendarFormat.month,
          onCalendarCreated: ((pageController) => calendarController = pageController),
          focusedDay: focusedDay,
          firstDay: DateTime.now(), //달력 최소 선택할수 잇는 날
          // firstDay: DateTime(2022, 1), //달력 최소 선택할수 잇는 날
          lastDay: DateTime(2050, 1), //다력 최대 선택할수 있는 날
          rangeSelectionMode: RangeSelectionMode.enforced,
          onDaySelected: daySelected,

          onRangeSelected: rangeSelected,
          daysOfWeekHeight: 24, // 주 이름 바 높이
          startingDayOfWeek: StartingDayOfWeek.sunday, //주 시작날
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
                alignment: Alignment.center,
                child: Text(
                  day,
                  style: TextStyle(fontSize: 12.sp),
                ),
              );
            }),
            rangeStartBuilder: (context, day, focusedDay) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                width: double.infinity,
                color: rangeRed,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "${DateFormat("d").format(day)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "시작",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  )
                ]),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              var formattedDate = DateFormat("d").format(day);
              return defaultDateWidget(formattedDate, day);
            },
            outsideBuilder: ((context, day, focusedDay) {
              var formattedDate = DateFormat("d").format(day);
              return outsideDateWidget(formattedDate, day);
              // return Container(
              //   alignment: Alignment.center,
              //   child: Text(
              //     formattedDate,
              //     style: TextStyle(fontSize: 15.sp, color: HexColor.fromHex("#D1D6DB")),
              //   ),
              // );
              // return Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     // SizedBox(
              //     //   height: 16.h,
              //     // ),
              //     Text(
              //       formattedDate,
              //       style: TextStyle(fontSize: 15.sp, color: HexColor.fromHex("#D1D6DB")),
              //     ),
              //     SizedBox(
              //       height: 2.h,
              //     ),
              //     Text(
              //       "",
              //       style: TextStyle(color: black, fontSize: 12.sp),
              //     )
              //   ],
              // );
            }),
            todayBuilder: ((context, day, focusedDay) {
              var formattedDate = DateFormat("d").format(day);
              return todayDateWidget(formattedDate, day);
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
              return defaultDateWidget(formattedDate, day);
            }),
            rangeEndBuilder: (context, day, focusedDay) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 2.h),
                width: double.infinity,
                color: rangeRed,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "${DateFormat("d").format(day)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Text(
                    "종료",
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  )
                ]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget defaultDateWidget(String formattedDate, DateTime day) {
    if (widget.questCheck != null) {
      bool existQuestDay = false;

      DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      DateTime dayV = dateFormat.parse(day.toString());
      for (var i = 0; i < widget.questCheck!.length; i++) {
        DateTime startDay = dateFormat.parse(widget.questCheck!.elementAt(i).activeDate!);
        DateTime endDay = dateFormat.parse(widget.questCheck!.elementAt(i).endDate!);

        if (dayV.isAfter(startDay.subtract(Duration(days: 1))) && dayV.isBefore(endDay.add(Duration(days: 0)))) {
          existQuestDay = true;
        }
      }
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        existQuestDay
            ? Icon(
                Icons.close,
                size: 14.sp,
                color: HexColor.fromHex("#D1D6DB"),
              )
            : Text(
                formattedDate,
                style: TextStyle(fontSize: 15.sp, color: existQuestDay ? HexColor.fromHex("#D1D6DB") : black),
              ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    }

    // return Container(
    //   alignment: Alignment.center,
    //   child: Text(
    //     formattedDate,
    //     style: TextStyle(
    //       fontSize: 15.sp,
    //     ),
    //   ),
    // );
  }

  Widget outsideDateWidget(String formattedDate, DateTime day) {
    if (widget.questCheck != null) {
      bool existQuestDay = false;

      DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      DateTime dayV = dateFormat.parse(day.toString());
      for (var i = 0; i < widget.questCheck!.length; i++) {
        DateTime startDay = dateFormat.parse(widget.questCheck!.elementAt(i).activeDate!);
        DateTime endDay = dateFormat.parse(widget.questCheck!.elementAt(i).endDate!);

        if (dayV.isAfter(startDay.subtract(Duration(days: 1))) && dayV.isBefore(endDay.add(Duration(days: 0)))) {
          existQuestDay = true;
        }
      }
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        existQuestDay
            ? Icon(
                Icons.close,
                size: 14.sp,
                color: HexColor.fromHex("#D1D6DB"),
              )
            : Text(
                formattedDate,
                style: TextStyle(fontSize: 15.sp, color: HexColor.fromHex("#D1D6DB")),
              ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          formattedDate,
          style: TextStyle(fontSize: 15.sp, color: HexColor.fromHex("#D1D6DB")),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    }

    // return Container(
    //   alignment: Alignment.center,
    //   child: Text(
    //     formattedDate,
    //     style: TextStyle(
    //       fontSize: 15.sp,
    //     ),
    //   ),
    // );
  }

  Widget todayDateWidget(String formattedDate, DateTime day) {
    if (widget.questCheck != null) {
      bool existQuestDay = false;

      DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      DateTime dayV = dateFormat.parse(day.toString());
      for (var i = 0; i < widget.questCheck!.length; i++) {
        DateTime startDay = dateFormat.parse(widget.questCheck!.elementAt(i).activeDate!);
        DateTime endDay = dateFormat.parse(widget.questCheck!.elementAt(i).endDate!);

        if (dayV.isAfter(startDay.subtract(Duration(days: 1))) && dayV.isBefore(endDay.add(Duration(days: 0)))) {
          existQuestDay = true;
        }
      }
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        existQuestDay
            ? Icon(
                Icons.close,
                size: 14.sp,
                color: HexColor.fromHex("#D1D6DB"),
              )
            : Text(
                formattedDate,
                style: TextStyle(fontSize: 15.sp, color: existQuestDay ? HexColor.fromHex("#D1D6DB") : black),
              ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "오늘",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    } else {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          formattedDate,
          style: TextStyle(
            fontSize: 15.sp,
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        Text(
          "오늘",
          style: TextStyle(color: black, fontSize: 12.sp),
        )
      ]);
    }
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

  rangeSelected(start, end, DateTime thisDay) async {
    if (widget.questCheck != null) {
      bool existQuestDay = false;

      List<DateTime> dates = [];
      var currentDate = start;
      while (currentDate.isBefore(start.add(Duration(days: widget.duration)))) {
        dates.add(currentDate);
        currentDate = currentDate.add(Duration(days: 1));
      }

      DateFormat dateFormat = DateFormat("yyyy-MM-dd");

      for (var i = 0; i < dates.length; i++) {
        DateTime dayS = dateFormat.parse(dates.elementAt(i).toString());

        for (var j = 0; j < widget.questCheck!.length; j++) {
          DateTime startDay = dateFormat.parse(widget.questCheck!.elementAt(j).activeDate!);
          DateTime endDay = dateFormat.parse(widget.questCheck!.elementAt(j).endDate!);

          if (dayS.isAfter(startDay.subtract(Duration(days: 1))) && dayS.isBefore(endDay.add(Duration(days: 0)))) {
            existQuestDay = true;
          }
        }
      }

      if (existQuestDay) {
        // showBotToast("이미 퀘스트 일정이 존재합니다.\n다른 날짜를 선택해주세요", black, Alignment.bottomCenter, 2);
        var result = await Get.dialog(QuestExistDialog());
        if (result != null) {
          if (result == 0) {
            Get.back();
            targetPath("membership", null);
          }
        }
      } else {
        setState(() {
          selectedDay = null;
          focusedDay = thisDay;
          rangeStart = start;
          rangeEnd = start.add(Duration(days: widget.duration - 1));
          // rangeEnd = end;
          widget.selectedFirstDate(rangeStart);
          widget.selectedLastDate(rangeEnd);
        });
      }
    } else {
      setState(() {
        selectedDay = null;
        focusedDay = thisDay;
        rangeStart = start;
        rangeEnd = start.add(Duration(days: widget.duration - 1));
        // rangeEnd = end;
        widget.selectedFirstDate(rangeStart);
        widget.selectedLastDate(rangeEnd);
      });
    }
    // print("dddd");
    // if (start.month != focusedDay.month) {
    //   if (start.month > thisDay.month) {
    //     navigatePreviousMonth();
    //   } else {
    //     navigateNextMonth();
    //   }
    //   return;
    // }
  }

  daySelected(thisDate, currentFocus) {
    // if (!isSameDay(selectedDay, thisDate)) {
    //   setState(() {
    //     selectedDay = thisDate;
    //     focusedDay = currentFocus;
    //     rangeStart = null;
    //     rangeEnd = null;
    //   });
    // }
  }
}
