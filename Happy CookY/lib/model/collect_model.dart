class CollectDatas {
  String? collectId;
  String? collectDescription;
  int? collectValue;
  String? collectDate;
  int? commandCount;
  String? collecterId;
  String? collectorName;
  CollectDatas(
      {this.collectId,
      this.collectDescription,
      this.collectValue,
      this.collectDate,
      this.commandCount,
      this.collecterId,
      this.collectorName});

      
  factory CollectDatas.fromJson(Map<String, dynamic> json) {
    return CollectDatas(
      collectId: json['CollectId'],
      collectDescription: json['CollectDescription'],
      collectValue: json['CollectValue'],
      collectDate: json['CollectDate'],
      commandCount: json['CommandCount'],
      collecterId: json['CollecterId'],
      collectorName: json['CollecterName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CollectId': collectId,
      'CollectDescription': collectDescription,
      'CollectValue': collectValue,
      'CollectDate': collectDate,
      'commandCount': commandCount,
      'collecterId': collecterId,
      'collectorName': collectorName
    };
  }
}
