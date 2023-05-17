import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBotToast extends StatelessWidget {
  final fun;
  final text;
  final Color? color;

  const CustomBotToast({
    Key? key,
    this.fun,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      width: double.infinity,
      child: Card(
        shadowColor: Colors.indigo[300],
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: color,
        margin: EdgeInsets.all(16),
        child: InkWell(
          onTap: fun,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                    child: Center(
                      child: Text(text, textAlign: TextAlign.center, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "noto")),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomBotToastBooster extends StatelessWidget {
  final fun;
  final text;
  final Color? color;

  const CustomBotToastBooster({
    Key? key,
    this.fun,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.indigo[300],
      elevation: 7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: color,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 200.w,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/img/booster.png",
                width: 16.w,
              ),
              SizedBox(
                width: 5.w,
              ),
              Text("사용 가능 부스터 : ", textAlign: TextAlign.center, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "noto")),
              Text(text, textAlign: TextAlign.center, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "noto", fontWeight: FontWeight.bold)),
              Text(" 개", textAlign: TextAlign.center, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "noto")),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBotToastBoosterError extends StatelessWidget {
  final fun;
  final text;
  final Color? color;

  const CustomBotToastBoosterError({
    Key? key,
    this.fun,
    this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 100.h),
      child: Card(
        shadowColor: Colors.indigo[300],
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        color: color,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: 335.w,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("👆 부스터 값을 입력해주세요.", textAlign: TextAlign.center, textScaleFactor: 1.0, style: TextStyle(color: Colors.white, fontSize: 15, fontFamily: "noto")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
