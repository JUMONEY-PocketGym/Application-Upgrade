import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:pock_gym/main.dart';
import 'package:pock_gym/utils/debug_print.dart';
import 'package:pock_gym/utils/system_overlay.dart';
import 'package:pock_gym/val/color.dart';

class VideoCustomRecordPage extends StatefulWidget {
  const VideoCustomRecordPage({super.key});

  @override
  State<VideoCustomRecordPage> createState() => _VideoCustomRecordPageState();
}

class _VideoCustomRecordPageState extends State<VideoCustomRecordPage> {
  late CameraController controller;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  bool record = false;
  bool done = false;

  File videoFile = File("");

  int _seconds = 0;
  Timer? _timer;

  bool cameraFront = true;

  @override
  void initState() {
    KeepScreenOn.turnOn();
    cInit();
    super.initState();
  }

  @override
  void dispose() {
    _stopTimer();
    controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _seconds++;
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  String _formatTime(int seconds) {
    String minutesStr = (seconds ~/ 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  cInit() async {
    controller = CameraController(
      cameras[1],
      kIsWeb ? ResolutionPreset.max : ResolutionPreset.low,
      enableAudio: true,
      imageFormatGroup: GetPlatform.isAndroid ? ImageFormatGroup.jpeg : ImageFormatGroup.bgra8888,
    );

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (controller.value.hasError) {
        // showInSnackBar(
        //     'Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();

      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });

      await Future.wait(<Future<Object>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb ? <Future<Object>>[] : <Future<Object>>[],
        // controller.getMaxZoomLevel().then((double value) => _maxAvailableZoom = value),
        // controller.getMinZoomLevel().then((double value) => _minAvailableZoom = value),
        // controller.setExposureOffset(1)
      ]);
    } on CameraException catch (e) {
      // _showCameraException(e);
    }
    if (mounted) {
      setState(() {});
    }
  }

  stopVideoRecording() async {
    final CameraController cameraController = controller;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }

    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      print(e);
      return null;
    }
  }

  startVideoRecord() async {
    final CameraController cameraController = controller;

    // if (cameraController == null || !cameraController.value.isRecordingVideo) {
    //   return null;
    // }

    try {
      dPrint("camera record start!!");
      return cameraController.startVideoRecording();
    } on CameraException catch (e) {
      dPrint("ERROR :::: " + e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return systemOverlay(
        false,
        SafeArea(
            top: false,
            child: Scaffold(
              backgroundColor: black,
              body: Stack(children: [
                Container(width: double.infinity, height: double.infinity, child: CameraPreview(controller)),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 120.h,
                    width: double.infinity,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Row(
                        children: [
                          Expanded(
                              child: done
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back();
                                        },
                                        child: Container(
                                          width: 60.w,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(999),
                                              topRight: Radius.circular(999),
                                              bottomLeft: Radius.circular(999),
                                              bottomRight: Radius.circular(999),
                                            ),
                                            border: Border.all(
                                              width: 2,
                                              style: BorderStyle.solid,
                                              color: white,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          // Get.back();
                                          if (cameraFront) {
                                            setState(() {
                                              cameraFront = false;
                                            });
                                            controller.setDescription(cameras[0]);
                                          } else {
                                            setState(() {
                                              cameraFront = true;
                                            });
                                            controller.setDescription(cameras[1]);
                                          }
                                        },
                                        child: Container(
                                          width: 60.w,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(999),
                                              topRight: Radius.circular(999),
                                              bottomLeft: Radius.circular(999),
                                              bottomRight: Radius.circular(999),
                                            ),
                                            border: Border.all(
                                              width: 2,
                                              style: BorderStyle.solid,
                                              color: white,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.switch_camera,
                                            color: white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                    )),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: done
                                ? SizedBox(
                                    width: 60.w,
                                    height: 60.w,
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      if (record) {
                                        _stopTimer();
                                        stopVideoRecording().then((file) async {
                                          if (mounted) {
                                            setState(() {});
                                          }
                                          if (file != null) {
                                            setState(() {
                                              videoFile = File(file.path);
                                            });
                                          }
                                        });
                                        setState(() {
                                          _seconds = 0;
                                          // record = false;
                                          done = true;
                                        });
                                      } else {
                                        _startTimer();
                                        startVideoRecord();
                                        setState(() {
                                          record = true;
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 60.w,
                                      height: 60.w,
                                      color: record ? Colors.white38 : mainColor,
                                      child: Icon(
                                        record ? Icons.stop : Icons.videocam,
                                        color: record ? mainColor : white,
                                        size: 30.sp,
                                      ),
                                    ),
                                  ),
                          ),
                          Expanded(
                              child: done
                                  ? Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.back(result: videoFile);
                                          dPrint(videoFile.path);
                                        },
                                        child: Container(
                                          width: 60.w,
                                          height: 60.w,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(999),
                                              topRight: Radius.circular(999),
                                              bottomLeft: Radius.circular(999),
                                              bottomRight: Radius.circular(999),
                                            ),
                                            border: Border.all(
                                              width: 2,
                                              style: BorderStyle.solid,
                                              color: white,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.done,
                                            color: white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                    )
                                  : SizedBox()),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            color: (record && !done) ? mainColor : Colors.transparent,
                            child: Text(
                              (record && !done) ? _formatTime(_seconds) : "",
                              style: TextStyle(fontSize: 15.sp, color: white),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ]),
            )));
  }
}
