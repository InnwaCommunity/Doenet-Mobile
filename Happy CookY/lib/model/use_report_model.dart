
class UseReport {
  String? reportDate;
  int? useAmount;
  UseReport({required this.reportDate, required this.useAmount});

  factory UseReport.fromJson(Map<String, dynamic> json) {
    return UseReport(
      reportDate: json['ReportDate'],
      useAmount: json['UseAmount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReportDate': reportDate,
      'UseAmount': useAmount,
    };
  }
}


class UseReportDetailModel {
  String? reportIdval;
  String? reportDescription;
  int? useAmount;
  String? reportDate;
  int? commandCount;
  String? reporterIdval;
  String? reporterName;
  UseReportDetailModel({
   required this.reportIdval,
   required this.reportDescription,
   required this.useAmount,
   required this.reportDate,
   required this.commandCount,
   required this.reporterIdval,
   required this.reporterName
});

    
  factory UseReportDetailModel.fromJson(Map<String, dynamic> json) {
    return UseReportDetailModel(
      reportIdval: json['ReportIdval'],
      reportDescription: json['ReportDescription'],
      useAmount: json['UseAmount'],
      reportDate: json['ReportDate'],
      commandCount: json['CommandCount'],
      reporterIdval: json['ReporterIdval'],
      reporterName: json['ReporterName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ReportIdval': reportIdval,
      'ReportDescription': reportDescription,
      'UseAmount': useAmount,
      'ReportDate': reportDate,
      'CommandCount': commandCount,
      'ReporterIdval': reporterIdval,
      'ReporterName': reporterName,
    };
  }
}