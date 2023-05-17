class ExerciseTypes {
  static const String etc = "0";
  static const String walking = "1001";
  static const String running = "1002";
  static const String baseball = "2001";
  static const String softball = "2002";
  static const String cricket = "2003";
  static const String golf = "3001";
  static const String billiards = "3002";
  static const String bowling = "3003";
  static const String hockey = "4001";
  static const String rugby = "4002";
  static const String basketball = "4003";
  static const String soccer = "4004";
  static const String handball = "4005";
  static const String americanFootBall = "4006";
  static const String volleyBall = "5001";
  static const String beachVolleyBall = "5002";
  static const String squash = "6001";
  static const String tennis = "6002";
  static const String badminton = "6003";
  static const String tableTennis = "6004";
  static const String racquetball = "6005";
  static const String boxing = "7002";
  static const String martialArts = "7003";
  static const String ballet = "8001";
  static const String dancing = "8002";
  static const String ballRoomDancing = "8003";
  static const String pilates = "9001";
  static const String yoga = "9002";
  static const String stretching = "10001";
  static const String jumpRope = "10002";
  static const String hulaHoop = "10003";
  static const String pushUps = "10004";
  static const String pullUps = "10005";
  static const String sitUps = "10006";
  static const String circuitTraining = "10007";
  static const String mountainClimbing = "10008";
  static const String jumpingJack = "10009";
  static const String burpee = "10010";
  static const String benchPress = "10011";
  static const String squats = "10012";
  static const String lunges = "10013";
  static const String legPress = "10014";
  static const String legExtension = "10015";
  static const String legCurl = "10016";
  static const String backExtension = "10017";
  static const String latPullDown = "10018";
  static const String deadLift = "10019";
  static const String shoulderPress = "10020";
  static const String frontRaise = "10021";
  static const String lateralRaise = "10022";
  static const String crunches = "10023";
  static const String legRaise = "10024";
  static const String plank = "10025";
  static const String armCurls = "10026";
  static const String armExtension = "10027";
  static const String inlineSkating = "11001";
  static const String hangGliding = "11002";
  static const String pistolShooting = "11003";
  static const String archery = "11004";
  static const String horsebackRiding = "11005";
  static const String cycling = "11007";
  static const String flyingDisc = "11008";
  static const String rollerSkating = "11009";
  static const String aerobics = "12001";
  static const String hiking = "13001";
  static const String rockClimbing = "13002";
  static const String backPacking = "13003";
  static const String mountainBike = "13004";
  static const String swimming = "14001";
  static const String aquarobics = "14002";
  static const String canoeing = "14003";
  static const String sailing = "14004";
  static const String scubaDiving = "14005";
  static const String snorkeling = "14006";
  static const String stepMachine = "15001";
  static const String weightMachine = "15002";
  static const String exerciseBike = "15003";
  static const String rowingMachine = "15004";
  static const String treadMill = "15005";
}

class ExerciseDataModel {
  DateTime? startTime;
  DateTime? endTime;
  double? minHeartRate;
  double? maxHeartRate;
  double? meanHeartRate;

  double? calorieBurn;
  double? maxCalorieBurn;
  double? meanCalorieBurn;

  ExerciseDataModel.fromJson(Map<String, dynamic> json) {
    startTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['startTime']));
    endTime = DateTime.fromMillisecondsSinceEpoch(int.parse(json['endTime']));

    minHeartRate = double.parse(json['minHeartRate']);
    maxHeartRate = double.parse(json['maxHeartRate']);
    meanHeartRate = double.parse(json['meanHeartRate']);

    calorieBurn = double.parse(json['calorieBurn']);
    maxCalorieBurn = double.parse(json['maxCalorieBurn']);
    meanCalorieBurn = double.parse(json['meanCalorieBurn']);


  }
}
