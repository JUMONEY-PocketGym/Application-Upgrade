class SleepStageDataModel {
  DateTime? sleepRecordStart;
  DateTime? sleepRecordEnd;
  String? sleepStage;
  String? sleepID;
  String? customData;

  SleepStageDataModel.fromJson(Map<String, dynamic> json) {
    String stage = json['sleepStage'];

    switch (stage) {
      case "40001":
        sleepStage = SleepStages.awake;
        break;
      case "40002":
        sleepStage = SleepStages.light;

        break;
      case "40003":
        sleepStage = SleepStages.deep;
        break;
      case "40004":
        sleepStage = SleepStages.rem;
        break;
      default:
    }

    sleepID = json['sleepID'];
    customData = json['customData'];

    sleepRecordStart =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['sleepStart']));
    sleepRecordEnd =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['sleepEnd']));
  }
}

class SleepStages {
  static const String awake = "STAGE_AWAKE";
  static const String light = "STAGE_LIGHT";
  static const String deep = "STAGE_DEEP";
  static const String rem = "STAGE_REM";
}
