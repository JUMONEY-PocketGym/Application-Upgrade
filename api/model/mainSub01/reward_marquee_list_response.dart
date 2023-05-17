// To parse this JSON data, do
//
//     final rewardMarqueeListResponse = rewardMarqueeListResponseFromJson(jsonString);

import 'dart:convert';

List<RewardMarqueeListResponse> rewardMarqueeListResponseFromJson(String str) => List<RewardMarqueeListResponse>.from(json.decode(str).map((x) => RewardMarqueeListResponse.fromJson(x)));

String rewardMarqueeListResponseToJson(List<RewardMarqueeListResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RewardMarqueeListResponse {
  RewardMarqueeListResponse({
    this.createData,
    this.name,
    this.rewardPrice,
  });

  String? createData;
  String? name;
  int? rewardPrice;

  factory RewardMarqueeListResponse.fromJson(Map<String, dynamic> json) => RewardMarqueeListResponse(
        createData: json["createData"] == null ? null : json["createData"],
        name: json["name"] == null ? null : json["name"],
        rewardPrice: json["rewardPrice"] == null ? null : json["rewardPrice"],
      );

  Map<String, dynamic> toJson() => {
        "createData": createData == null ? null : createData,
        "name": name == null ? null : name,
        "rewardPrice": rewardPrice == null ? null : rewardPrice,
      };
}
