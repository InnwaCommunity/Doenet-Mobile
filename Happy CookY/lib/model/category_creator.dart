class CategoryCreator{
  String? creatoridval;
  String? creatorName;
  CategoryCreator({required this.creatoridval,required this.creatorName});

  
  factory CategoryCreator.fromJson(Map<String, dynamic> json) {
    return CategoryCreator(
      creatoridval: json['CreatorIdval'],
      creatorName: json['creatorName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CreatorIdval': creatoridval,
      'creatorName': creatorName,
    };
  }
}