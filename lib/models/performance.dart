// To parse this JSON data, do
//
//     final performanceModel = performanceModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<PerformanceModel> performanceModelFromJson(String str) => List<PerformanceModel>.from(json.decode(str).map((x) => PerformanceModel.fromJson(x)));

String performanceModelToJson(List<PerformanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PerformanceModel {
    PerformanceModel({
        required this.id,
        required this.label,
        required this.chartPeriodCode,
        required this.changePercent,
    });

    final int id;
    final String label;
    final String chartPeriodCode;
    final double changePercent;

    factory PerformanceModel.fromJson(Map<String, dynamic> json) => PerformanceModel(
        id: json["ID"],
        label: json["Label"],
        chartPeriodCode: json["ChartPeriodCode"],
        changePercent: json["ChangePercent"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "ID": id,
        "Label": label,
        "ChartPeriodCode": chartPeriodCode,
        "ChangePercent": changePercent,
    };
}
