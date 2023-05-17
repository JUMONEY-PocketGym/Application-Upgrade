import 'package:intl/intl.dart';

writeTime(String date) {
  var dateSplit;
  if (date.contains("T")) {
    dateSplit = date.split("T");
  } else {
    dateSplit = date.split(" ");
  }
  var dSplit = dateSplit[0];
  var tSplit = dateSplit[1];

  var timeSplit = tSplit.split(":");
  var h = timeSplit[0];
  var m = timeSplit[1];

  var tV = "";
  var hFixed = "";

  if (int.parse(h) < 12) {
    // 오전
    tV = "오전";
    hFixed = "$h";
  } else {
    // 오후
    tV = "오후";
    var hM = int.parse(h) - 12;
    if (hM > 9) {
      hFixed = "$hM";
    } else {
      hFixed = "0$hM";
    }
  }

  return "${dSplit.replaceAll("-", ".")} $tV $hFixed:$m";
}

String convertDataFormatYYYYMMDD(String dateTimeString) {
  DateFormat newDateFormat = DateFormat('yyyy.MM.dd');
  DateTime convertedDate = DateTime.parse(dateTimeString).toLocal();
  String outputDate = newDateFormat.format(convertedDate);

  // print('날짜변환 1 ${dateTimeString}');
  // print('날짜변환 2 ${outputDate}');
  return outputDate;
}

getDataKr(String data) {
  if (data.contains("PM")) {
    data = data.replaceAll(" PM", "");
    data = "오후 " + data;
    return data;
  } else {
    data = data.replaceAll(" AM", "");
    data = "오전 " + data;
    return data;
  }
}
