import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/val/color.dart';
import 'package:timer_builder/timer_builder.dart';

getTimeDiff(String time) {
  DateTime date = DateTime.parse(time);

  DateTime now = DateTime.now();
  Duration difference = date.difference(now);
  int hour = difference.inHours;
  int days = difference.inDays;

  if (hour < 24) {
    return TimerBuilder.periodic(
      const Duration(seconds: 1),
      builder: (context) {
        return Text(
          "신청마감까지 " + checkHowManyHTMSAgo(time),
          style: TextStyle(fontSize: 12.sp, color: white),
          textScaleFactor: 1,
        );
      },
    );
  } else {
    return Text(
      "신청마감까지 " + days.toString() + "일",
      style: TextStyle(fontSize: 12.sp, color: white),
    );
  }
}

String checkHowManyHTMSAgo(String dateTimeString) {
  // input시간까지  몇시간 몇분 몇초 남았는지 반환
  DateTime date1 = DateTime.now().toLocal();
  DateTime date2 = DateTime.parse(dateTimeString).toLocal();
  int day = date2.difference(date1).inDays;
  int hour = date2.difference(date1).inHours % 24;
  int min = date2.difference(date1).inMinutes % 60;
  int second = date2.difference(date1).inSeconds % 60;

  String h = "";
  String m = "";
  String s = "";
  if (hour > 10) {
    h = hour.toString();
  } else {
    h = "0" + hour.toString();
  }
  if (min > 10) {
    m = min.toString();
  } else {
    m = "0" + min.toString();
  }
  if (second > 10) {
    s = second.toString();
  } else {
    s = "0" + second.toString();
  }

  return '$h:$m:$s';
}

String checkRemainTime(String dateTimeString) {
  // input시간까지  몇시간 몇분 몇초 남았는지 반환
  DateTime date1 = DateTime.now().toLocal();
  DateTime date2 = DateTime.parse(dateTimeString).toLocal().subtract(Duration(hours: 9));

  // dPrint(date1);
  // dPrint(date2);
  int day = date2.difference(date1).inDays;
  int hour = date2.difference(date1).inHours % 24;
  int min = date2.difference(date1).inMinutes % 60;
  int second = date2.difference(date1).inSeconds % 60;

  String d = "";
  String h = "";
  String m = "";
  String s = "";

  if (day > 9) {
    d = day.toString();
  } else {
    d = "0" + day.toString();
  }

  if (hour > 9) {
    h = hour.toString();
  } else {
    h = "0" + hour.toString();
  }
  if (min > 9) {
    m = min.toString();
  } else {
    m = "0" + min.toString();
  }
  if (second > 10) {
    s = second.toString();
  } else {
    s = "0" + second.toString();
  }

  return '$d:$h:$m';
}

/// 오늘이 두 날짜 사이에 있는가?
bool isItPeriod(String startTime, String endTime) {
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFormat2 = DateFormat("yyyy-MM-ddTHH:mm:ssZ");

  DateTime today = dateFormat1.parse(DateTime.now().toString()).toLocal();
  DateTime startDay = dateFormat2.parse(startTime);
  DateTime endDay = dateFormat2.parse(endTime);

  // var dateFormate = DateFormat("yyyy-MM-dd hh:mm:ss");

  // print('startTime  ${startTime}');
  // print('endTime    ${endTime}');
  // print('today       ${today}');
  // print('todayisAfter       ${today.isAfter(startDay)}');
  // print('todayisBefore       ${today.isBefore(endDay)}');

  return today.isAfter(startDay) && today.isBefore(endDay) ? true : false;
}

bool isItPeriod2(String startTime, String endTime) {
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFormat2 = DateFormat("yyyy-MM-dd HH:mm:ss");

  DateTime today = dateFormat1.parse(DateTime.now().toString()).toLocal();
  DateTime startDay = dateFormat2.parse(startTime);
  DateTime endDay = dateFormat2.parse(endTime);

  // var dateFormate = DateFormat("yyyy-MM-dd hh:mm:ss");

  // print('startTime  ${startTime}');
  // print('endTime    ${endTime}');
  // print('today       ${today}');
  // print('todayisAfter       ${today.isAfter(startDay)}');
  // print('todayisBefore       ${today.isBefore(endDay)}');

  return today.isAfter(startDay) && today.isBefore(endDay) ? true : false;
}

/// 오늘이 날짜 전인가?
bool todayisBeforeDay(String inputDate) {
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFormat2 = DateFormat("yyyy-MM-ddTHH:mm:ssZ");

  DateTime today = dateFormat1.parse(DateTime.now().toString());
  DateTime date = dateFormat2.parse(inputDate);

  return today.isBefore(date) ? true : false;
}

/// /// 오늘이 날짜 후 인가?
bool todayisAfterDay(String inputDate) {
  DateFormat dateFormat1 = DateFormat("yyyy-MM-dd HH:mm:ss");
  DateFormat dateFormat2 = DateFormat("yyyy-MM-ddTHH:mm:ssZ");

  DateTime today = dateFormat1.parse(DateTime.now().toString());
  DateTime date = dateFormat2.parse(inputDate);

  return today.isAfter(date) ? true : false;
}
