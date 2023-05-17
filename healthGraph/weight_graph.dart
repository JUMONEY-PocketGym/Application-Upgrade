// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pock_gym/samsunghealth/models/weight.dart';
import 'package:pock_gym/ui/global/button.dart';
import 'package:pock_gym/utils/system_overlay.dart';
import 'package:pock_gym/val/color.dart';

import '../samsunghealth/method_channel.dart';
import '../utils/hex_color.dart';

class WeightGraphPage extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;
  final DateTime todayDate;
  final bool showButton;
  const WeightGraphPage({super.key, required this.startDate, required this.endDate, required this.todayDate, required this.showButton});

  @override
  State<WeightGraphPage> createState() => _WeightGraphPageState();
}

class _WeightGraphPageState extends State<WeightGraphPage> {
  bool isConnected = false;
  bool isAvailable = false;
  List<WeightSummaryHelper> weightList = [];

  double highestData = 0;
  double lowestData = 0;
  WeightDataModel? currentWeightData;
  String? currentDateKey;
  String? todayDateKey;

  bool error = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (SamsungHealth.isConnected) {
        int response = await SamsungHealth.checkPermissions(context);
        if (response == 0) {
          getWeight();
          setState(() {
            isAvailable = true;
          });
        }
      } else {
        isConnected = await SamsungHealth.connectToSamsungHealth(context);
        if (isConnected) {
          int response = await SamsungHealth.checkPermissions(context);
          if (response == 0) {
            getWeight();
            setState(() {
              isAvailable = true;
            });
          }
        }
      }
    });

    super.initState();
  }

  getWeight() async {
    weightList = await SamsungHealth.getWeight(
      startDate: widget.startDate,
      endDate: widget.endDate,
    );
    setState(() {
      weightList = weightList;
    });

    // var todayDate = DateTime.now();
    var todayDate = widget.todayDate;
    // var todayDate = DateTime(2023, 1, 20);

    todayDateKey = "${todayDate.year}_${todayDate.month}_${todayDate.day}";
    print("${weightList.length}");
    var queryList = weightList.where(
      (element) {
        var date = element.weightDataLogs.first.createDate!;
        var dateKey = "${date.year}_${date.month}_${date.day}";
        print("$dateKey == $todayDateKey");
        return todayDateKey == dateKey;
      },
    ).toList();

    if (queryList.isNotEmpty) {
      currentWeightData = queryList.first.weightDataLogs.first;
      var date = currentWeightData!.createDate!;
      currentDateKey = "${date.year}_${date.month}_${date.day}";
    } else {
      print("no current");
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (!isAvailable) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: .5,
        ),
      );
    }

    return Container(
      color: white,
      child: systemOverlay(
        false,
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 60.h,
                  color: white,
                  child: Stack(children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 60.h,
                        height: 60.h,
                        color: Colors.transparent,
                        child: Center(
                            child: Image.asset(
                          "assets/img/back.png",
                          height: 24.h,
                        )),
                      ),
                    ),
                    Center(
                      child: Text(
                        "체중/체성분",
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                    )
                  ]),
                ),
                Divider(
                  height: 1.h,
                  thickness: 1.h,
                  color: HexColor.fromHex("#E5E8EB"),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(children: [
                      Expanded(
                        child: currentWeightData == null
                            ? Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                                Image.asset(
                                  "assets/img/alert_icn.png",
                                  width: 46.w,
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Text(
                                  "체중/체성분 데이터가 없습니다.",
                                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: HexColor.fromHex("#6B7684")),
                                ),
                              ])
                            : SingleChildScrollView(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 32),
                                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  Text(
                                    "체중",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  AspectRatio(
                                    aspectRatio: 1.5,
                                    child: Container(
                                      padding: EdgeInsets.fromLTRB(24, 32, 24, 0),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: Colors.grey.shade200),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: LineChart(
                                        LineChartData(
                                            lineBarsData: [
                                              LineChartBarData(
                                                  isCurved: true,
                                                  barWidth: 3.5,
                                                  dotData: FlDotData(getDotPainter: (spot, percent, barData, index) {
                                                    return FlDotCirclePainter(
                                                      radius: 4,
                                                      color: Colors.white,
                                                      strokeWidth: 3,
                                                      strokeColor: HexColor.fromHex("#02d798"),
                                                    );
                                                  }),
                                                  color: HexColor.fromHex("#02d798"),
                                                  spots: List<FlSpot>.generate(weightList.length, (index) {
                                                    var weightData = weightList.elementAt(index);
                                                    return FlSpot(index.toDouble(), weightData.weightDataLogs.first.weight!);
                                                  })),
                                            ],
                                            gridData: FlGridData(show: false),
                                            borderData: FlBorderData(
                                              show: true,
                                              border: Border(
                                                top: BorderSide(width: 1, color: Colors.grey.shade200),
                                                bottom: BorderSide(width: 1, color: Colors.grey.shade200),
                                              ),
                                            ),
                                            titlesData: FlTitlesData(
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(showTitles: false),
                                                ),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(showTitles: false),
                                                ),
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    reservedSize: 56,
                                                    showTitles: true,
                                                    getTitlesWidget: (value, meta) {
                                                      return Container(
                                                        alignment: Alignment.centerRight,
                                                        // color: Colors.red,
                                                        child: Text(
                                                          "${value.toStringAsFixed(0)} kg",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                      interval: 1,
                                                      showTitles: true,
                                                      reservedSize: 48,
                                                      getTitlesWidget: ((value, meta) {
                                                        var weightData = weightList.elementAt(value.toInt());
                                                        return InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              currentWeightData = weightData.weightDataLogs.first;
                                                              var date = currentWeightData!.createDate!;
                                                              currentDateKey = "${date.year}_${date.month}_${date.day}";
                                                            });
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets.all(12),
                                                            alignment: Alignment.bottomCenter,
                                                            child: Text(
                                                              "${DateFormat("M/d").format(weightData.weightDataLogs.first.createDate!)}",
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.black,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })),
                                                ))),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    todayDateKey == currentDateKey
                                        ? "오늘 ${DateFormat("aa h:mm", "ko").format(currentWeightData!.createDate!)}"
                                        : "${DateFormat("MMM d일 aa h:mm", "ko").format(currentWeightData!.createDate!)}",
                                    style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontSize: 13,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        color: HexColor.fromHex("#02d798"),
                                        size: 14,
                                      ),
                                      Text(
                                        " 낮음",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: HexColor.fromHex("#1cb1f8"),
                                        size: 14,
                                      ),
                                      Text(
                                        " 보통",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 13,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        Icons.circle,
                                        color: HexColor.fromHex("#ee4b5a"),
                                        size: 14,
                                      ),
                                      Text(
                                        " 높음",
                                        style: TextStyle(
                                          color: Colors.grey.shade400,
                                          fontSize: 13,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.weight!,
                                    high: 205,
                                    low: 86,
                                    normal: 115,
                                    label: "체중",
                                    unit: "kg",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.bodyFatMass!,
                                    high: 100,
                                    low: 58.6,
                                    normal: 79.2,
                                    label: "체지방량",
                                    unit: "kg",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: (currentWeightData!.weight! / (currentWeightData!.height! / 100 * currentWeightData!.height! / 100)),
                                    high: 40,
                                    low: 18.5,
                                    normal: 23.3,
                                    label: "BMI",
                                    unit: "",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.skeletalMuscleMass!,
                                    high: 170,
                                    low: 90,
                                    normal: 119,
                                    label: "골격근량",
                                    unit: "kg",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.bodyFat!,
                                    high: 50,
                                    low: 10,
                                    normal: 20,
                                    label: "체지방률",
                                    unit: "%",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.totalWater!,
                                    high: 100,
                                    low: 58.6,
                                    normal: 79.2,
                                    label: "체수분",
                                    unit: "kg",
                                  ),
                                  SizedBox(height: 16),
                                  LineBarStatGraph(
                                    value: currentWeightData!.basalMetabolicRate!,
                                    high: 100,
                                    low: 58.6,
                                    normal: 79.2,
                                    label: "기초대사량",
                                    unit: "cal",
                                  ),
                                ]),
                              ),
                      ),
                      if (widget.showButton) ...[
                        InkWell(
                          onTap: () async {
                            // getWeight();
                            if (currentWeightData == null) {
                              Get.back();
                            } else {
                              Get.back(result: true);
                            }
                          },
                          child: DefaultButton(text: "퀘스트 인증하기", textColor: white, backgroundColor: HexColor.fromHex("#02D798"), height: 50, fontSize: 16, radius: 10),
                        )
                      ],
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LineBarStatGraph extends StatelessWidget {
  final String label;
  final double low;
  final double normal;
  final double high;
  final double value;
  final String unit;
  const LineBarStatGraph({
    Key? key,
    required this.value,
    required this.label,
    required this.low,
    required this.normal,
    required this.high,
    required this.unit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lowStep = low / high;
    var middleStep = normal / high;
    var highStep = high / high;
    var totalValue = value / high;

    var lowStepMultiplier = lowStep <= totalValue ? lowStep : totalValue;
    var middleStepMultiplier = middleStep <= totalValue ? middleStep : totalValue;
    var highStepMultiplier = highStep <= totalValue ? highStep : totalValue;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                width: 1,
                color: Colors.grey.shade200,
              )),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${value.toStringAsFixed(1)} $unit",
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 6),
                  Container(
                    child: LayoutBuilder(builder: (context, box) {
                      var totalWidth = (box.maxWidth * lowStepMultiplier) +
                          (box.maxWidth * middleStepMultiplier - box.maxWidth * lowStepMultiplier) +
                          (box.maxWidth * highStepMultiplier - box.maxWidth * middleStepMultiplier);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 14,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: Colors.grey.shade200,
                                ),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Container(
                                  width: totalWidth,
                                  child: Row(
                                    children: [
                                      Container(
                                        height: 14,
                                        width: box.maxWidth * lowStepMultiplier,
                                        color: HexColor.fromHex("#02d798"),
                                      ),
                                      Container(
                                        color: HexColor.fromHex("#1cb1f8"),
                                        height: 14,
                                        width: box.maxWidth * middleStepMultiplier - box.maxWidth * lowStepMultiplier,
                                      ),
                                      Container(
                                        color: HexColor.fromHex("#ee4b5a"),
                                        height: 14,
                                        width: box.maxWidth * highStepMultiplier - box.maxWidth * middleStepMultiplier,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 14,
                                  width: box.maxWidth * lowStep,
                                  child: labelText(low),
                                ),
                                Container(
                                  height: 14,
                                  width: box.maxWidth * middleStep - box.maxWidth * lowStep,
                                  child: labelText(normal),
                                ),
                                Container(
                                  height: 14,
                                  width: box.maxWidth * highStep - box.maxWidth * middleStep,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget labelText(value) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        transform: Matrix4.translationValues(12, 0, 0),
        alignment: Alignment.center,
        width: 32,
        child: Column(
          children: [
            Text(
              "$value",
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
