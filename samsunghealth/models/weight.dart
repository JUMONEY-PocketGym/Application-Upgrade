class WeightSummaryHelper {
   String dateKey;
   List<WeightDataModel> weightDataLogs;

  WeightSummaryHelper(this.dateKey, this.weightDataLogs);
}

class WeightDataModel {
  DateTime? createDate;
  double? weight;
  double? height;
  double? basalMetabolicRate;
  double? totalWater;
  double? skeletalMuscleMass;
  double? bodyFat;
  double? bodyFatMass;
  double? skeletalMuscle;
  double? fatFree;
  double? fatFreeRatio;

  WeightDataModel({
    this.createDate,
    this.weight,
    this.height,
    this.basalMetabolicRate,
    this.totalWater,
    this.skeletalMuscleMass,
    this.bodyFat,
    this.bodyFatMass,
    this.skeletalMuscle,
    this.fatFree,
    this.fatFreeRatio,
  });

  WeightDataModel.fromJson(Map<String, dynamic> json) {
    createDate = DateTime.fromMillisecondsSinceEpoch(int.parse(json['createDate']));
    weight = json['weight'] == null ? 0 : double.parse(json['weight']);
    height = json['height'] == null ? 0 : double.parse(json['height']);
    basalMetabolicRate = json['bmr'] == null ? 0 : double.parse(json['bmr']);
    totalWater = json['totalWater'] == null ? 0 : double.parse(json['totalWater']);
    skeletalMuscleMass = json['skeletalMuscleMass'] == null ? 0 : double.parse(json['skeletalMuscleMass']);
    bodyFat = json['bodyFat'] == null ? 0 : double.parse(json['bodyFat']);
    bodyFatMass = json['bodyFatMass'] == null ? 0 : double.parse(json['bodyFatMass']);
    skeletalMuscle = json['skeletalMuscle'] == null ? 0 : double.parse(json['skeletalMuscle']);
    fatFree = json['fatFree'] == null ? 0 : double.parse(json['fatFree']);
    fatFreeRatio = json['fatFreeRatio'] == null ? 0 : double.parse(json['fatFreeRatio']);
  }
}
