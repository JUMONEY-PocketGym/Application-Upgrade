// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pock_gym/samsunghealth/models/extensions.dart';
import 'package:pock_gym/samsunghealth/models/sleep_stage.dart';
import 'package:pock_gym/samsunghealth/values.dart';

import 'dialog.dart';
import 'models/exercise.dart';
import 'models/steps.dart';
import 'models/weight.dart';

class SamsungHealth {
  static const platform = MethodChannel('com.squatt.pock_gym');
  static bool isConnected = false;

  static Future<bool> connectToSamsungHealth(context) async {
    if (isConnected) {
      isConnected = true;
      return true;
    }
    int responseCode = 8888;
    try {
      var result = await platform.invokeMethod('initSamsungHealth');
      responseCode = result;
    } catch (e) {}

    String messageError = "";

    switch (responseCode) {
      case SamsungHealthErrors.successConnect:
        isConnected = true;
        break;
      case SamsungHealthErrors.notInstalled:
        messageError = "삼성헬스 앱을 설치해주세요";
        break;
      case SamsungHealthErrors.oldVersionPlatform:
        messageError = "삼성헬스 앱을 업데이트해주세요";
        break;
      case SamsungHealthErrors.platformDisabled:
        messageError = "삼성헬스를 사용 가능하도록 설정해주세요.";
        break;
      case SamsungHealthErrors.privacyPolicyDenied:
        messageError = "삼성헬스 정책에 동의해주세요.";
        break;
      case SamsungHealthErrors.permissionDenied:
        messageError = "삼성헬스의 모든 권한이 필요합니다. 데이터 권한을 변경하려면 삼성 헬스의 [설정 > 데이터 권한]으로 이동하세요";
        break;
      default:
    }
    if (responseCode != 0) {
      showDialog(
          context: context,
          builder: (c) => SamsungHealthErrorDialog(
                message: messageError,
              ));
      isConnected = false;
      return false;
    } else {
      print("connection Success");
      isConnected = true;
      return true;
    }
  }

  static Future<int> checkPermissions(context) async {
    var responseCode;
    try {
      var result = await platform.invokeMethod('permissionHealth');
      responseCode = result;
      print("responseCode $responseCode");
      return responseCode;
    } catch (e) {
      print("ERROR $e");
      return 404;
    }
  }

  static Future<List<StepsDataModel>> getStepCount({required DateTime startDate, double? limitSteps}) async {
    try {
      var result = await platform.invokeMethod('getDailySteps', {
        'startTime': startDate.millisecondsSinceEpoch,
      });
      List<StepsDataModel> listOfModels = [];

      for (var i = 0; i < result.length; i++) {
        String jsonString = result.elementAt(i);
        var dataMap = jsonDecode(jsonString);
        var model = StepsDataModel.fromJson(dataMap);
        listOfModels.addStepsData(model);
        print("${model.createDate} = ${model.stepsCount}");
      }
      if (limitSteps != null) {
        for (var i = 0; i < listOfModels.length; i++) {
          var model = listOfModels.elementAt(i);
          var stepValue = model.stepsCount!;
          if (stepValue >= limitSteps) {
            model.stepsCount = limitSteps;
          }
        }
      }
      return listOfModels;
    } catch (e) {
      print("ERROR $e Permission ISsue");
      return [];
    }
  }

  static Future<List<SleepStageDataModel>> getSleepStage({
    required DateTime startDate,
    DateTime? endDate,
  }) async {
    try {
      var result = await platform.invokeMethod('getSleepStage', {
        'startTime': startDate.millisecondsSinceEpoch,
        'endTime': endDate == null ? 0 : endDate.add(const Duration(days: 1)).millisecondsSinceEpoch,
      });
      List<SleepStageDataModel> listOfModels = [];

      for (var i = 0; i < result.length; i++) {
        String jsonString = result.elementAt(i);
        var dataMap = jsonDecode(jsonString);
        var model = SleepStageDataModel.fromJson(dataMap);
        listOfModels.add(model);
      }
      return listOfModels;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ExerciseDataModel>> getExercise({
    required DateTime startDate,
    required String type,
    DateTime? endDate,
  }) async {
    try {
      var result = await platform.invokeMethod('getExercise', {
        'startTime': startDate.millisecondsSinceEpoch,
        'exerciseType': type,
        'endTime': endDate == null ? 0 : endDate.add(const Duration(days: 1)).millisecondsSinceEpoch,
      });
      List<ExerciseDataModel> listOfModels = [];

      for (var i = 0; i < result.length; i++) {
        String jsonString = result.elementAt(i);
        var dataMap = jsonDecode(jsonString);
        var model = ExerciseDataModel.fromJson(dataMap);
        listOfModels.add(model);
      }
      return listOfModels;
    } catch (e) {
      return [];
    }
  }

  static Future<List<WeightSummaryHelper>> getWeight({
    required DateTime startDate,
    DateTime? endDate,
  }) async {
    try {
      var result = await platform.invokeMethod('getWeight', {
        'startTime': startDate.millisecondsSinceEpoch,
        'endTime': endDate == null ? 0 : endDate.add(const Duration(days: 1)).millisecondsSinceEpoch,
      });
      List<WeightSummaryHelper> listOfModels = [];
      for (var i = 0; i < result.length; i++) {
        String jsonString = result.elementAt(i);
        var dataMap = jsonDecode(jsonString);
        var model = WeightDataModel.fromJson(dataMap);
        listOfModels.addWeightData(model);
        print("${model.createDate}");
      }
      return listOfModels;
    } catch (e) {
      print("$e");
      return [];
    }
  }
}
