import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pock_gym/main.dart';
import 'package:pock_gym/val/color.dart';
import 'dart:math' as math;
import 'package:image/image.dart' as img;

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[1], ResolutionPreset.medium);
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
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool takenPic = false;
  File? image;
  bool cameraDirectionFront = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: black,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: takenPic
                  ? cameraDirectionFront
                      ? Transform(
                          alignment: Alignment.center,
                          child: Image.file(image!),
                          transform: Matrix4.rotationY(math.pi),
                        )
                      : Image.file(image!)
                  : CameraPreview(controller),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 120.h,
                  color: Colors.black12,
                  child: !takenPic
                      ? Row(children: [
                          Spacer(),
                          SizedBox(
                            width: 20.w,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: GestureDetector(
                              onTap: () async {
                                controller.takePicture().then((XFile? file) async {
                                  setState(() {
                                    image = File(file!.path);
                                    takenPic = true;
                                  });
                                  print(image!.path);

                                  // base64File.add(bf);
                                  // fileExtension.add(fe);
                                });
                              },
                              child: Container(
                                width: 70.w,
                                height: 70.w,
                                color: white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          if (!takenPic) ...[
                            Expanded(
                                child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: GestureDetector(
                                  onTap: () {
                                    if (cameraDirectionFront) {
                                      controller.setDescription(cameras[0]);
                                      setState(() {
                                        cameraDirectionFront = false;
                                      });
                                    } else {
                                      controller.setDescription(cameras[1]);
                                      setState(() {
                                        cameraDirectionFront = true;
                                      });
                                    }
                                  },
                                  child: Container(
                                    width: 50.w,
                                    height: 50.w,
                                    color: Colors.black26,
                                    child: Center(
                                        child: Icon(
                                      Icons.switch_camera,
                                      color: white,
                                    )),
                                  ),
                                ),
                              ),
                            ))
                          ] else ...[
                            Spacer(),
                          ]
                        ])
                      : Row(children: [
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                  child: Text(
                                "취소",
                                style: TextStyle(fontSize: 15.sp, color: white, fontWeight: FontWeight.bold),
                              )),
                            ),
                          )),
                          Expanded(
                              child: GestureDetector(
                            onTap: () {
                              Get.back(result: image);
                            },
                            child: Container(
                              color: Colors.transparent,
                              width: double.infinity,
                              height: double.infinity,
                              child: Center(
                                  child: Text(
                                "사용",
                                style: TextStyle(fontSize: 15.sp, color: white, fontWeight: FontWeight.bold),
                              )),
                            ),
                          ))
                        ]),
                ))
          ]),
        ),
      ),
    );
  }
}
