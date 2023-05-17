import 'package:pock_gym/samsunghealth/models/steps.dart';
import 'package:pock_gym/samsunghealth/models/weight.dart';

extension StepsTallyExtension on List<StepsDataModel> {
  void addStepsData(StepsDataModel stepsModel) {
    if (isNotEmpty) {
      try {
        var value = firstWhere((model) => model.createDate == stepsModel.createDate!);
        value.calorie = value.calorie! + stepsModel.calorie!;
        value.stepsCount = value.stepsCount! + stepsModel.stepsCount!;
        value.distance = value.distance! + stepsModel.distance!;
      } catch (e) {
        add(stepsModel);
      }
    } else {
      add(stepsModel);
    }
  }
}

extension WeightTallyExtension on List<WeightSummaryHelper> {
  void addWeightData(WeightDataModel weightModel) {
    if (isNotEmpty) {
      try {
        var value = firstWhere((model) => model.dateKey == getDateKey(weightModel.createDate!));
        value.weightDataLogs.add(weightModel);
        value.weightDataLogs.sort(((a, b) => b.createDate!.compareTo(a.createDate!)));
      } catch (e) {
        add(WeightSummaryHelper(getDateKey(weightModel.createDate!), [weightModel]));
      }
    } else {
      add(WeightSummaryHelper(getDateKey(weightModel.createDate!), [weightModel]));
    }
  }
}

String getDateKey(DateTime date) {
  return "${date.year}_${date.month}_${date.day}";
}
