class StepsDataModel {
  double? stepsCount;
  double? calorie;
  double? distance;
  String? createDate;
  String? deviceUUID;

  StepsDataModel({this.stepsCount, this.calorie, this.createDate, this.distance});

  StepsDataModel.fromJson(Map<String, dynamic> json) {
    stepsCount = json['stepsCount'] == 0 ? 0 : double.parse(json['stepsCount']);
    calorie = json['calorie'] == 0 ? 0 : double.parse(json['calorie']);
    distance = json['distance'] == 0 ? 0 : double.parse(json['distance']);
    deviceUUID = json['deviceUUID'] == 0 ? 0 : json['deviceUUID'];
    var rawDate = json['createDate'] == 0 ? 0 : json['createDate'];
    DateTime parsedDate = DateTime.fromMillisecondsSinceEpoch(int.parse(rawDate!));
    createDate = "${parsedDate.year}_${parsedDate.month}_${parsedDate.day}";
  }
}
