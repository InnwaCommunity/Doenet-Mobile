import 'package:register_customer/model/use_report_model.dart';

class CategoryModel{
  String? categoryIdval;
  String? categoryName;
  String? startDate;
  String? endDate;
  int? total;
  int? lastbalance;
  List<UseReport>? usereportList;

  CategoryModel({
     this.categoryIdval,
     this.categoryName,
     this.startDate,
     this.endDate,
     this.total,
     this.lastbalance,
     this.usereportList,
  });

  
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryIdval: json['CategoryIdval'],
      categoryName: json['CategoryName'],
      startDate: json['StartDate'],
      endDate: json['EndDate'],
      total: json['Total'],
      lastbalance: json['LastBalance'],
      usereportList: json['UsageReportList'] != null
        ? (json['UsageReportList'] as List).map((e) => UseReport.fromJson(e)).toList()
        : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CategoryIdval': categoryIdval,
      'CategoryName': categoryName,
      'StartDate': startDate,
      'EndDate': endDate,
      'Total': total,
      'LastBalance': lastbalance,
      'UsageReportList': usereportList
    };
  }
}