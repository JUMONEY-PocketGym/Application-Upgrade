// To parse this JSON data, do
//
//     final myQeustListResponse = myQeustListResponseFromJson(jsonString);

import 'dart:convert';

List<int> myQeustListResponseFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String myQeustListResponseToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
