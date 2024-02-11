import 'package:register_customer/model/category_model.dart';

class ClusterModel{
  String? clusterIdval;
  String? clusterName;
  bool? isPasswordUse;
  bool? isAdmin;
  bool? isCommander;
  bool? isViewer;
  bool? isEmployee;
  bool? isVertify;
  String? createDate;
  int? numberOfMember;
  List<CategoryModel>? categoryList;

  ClusterModel({
    this.clusterIdval,
    this.clusterName,
    this.isPasswordUse,
    this.isAdmin,
    this.isCommander,
    this.isViewer,
    this.isEmployee,
    this.isVertify,
    this.numberOfMember,
    this.createDate,
    this.categoryList
  });

  factory ClusterModel.fromJson(Map<String, dynamic> json) {
    return ClusterModel(
      numberOfMember: json['NumOfMembers'],
      clusterIdval: json['ClusterIdval'],
      clusterName: json['ClusterName'],
      isPasswordUse: json['IsPasswordUse'],
      isAdmin: json['Admin'],
      isCommander: json['Commander'],
      isViewer: json['Viewer'],
      isEmployee: json['Employee'],
      isVertify: json['IsPasswordUse'] ? false : true,
      createDate: json['CreateDate']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ClusterId': clusterIdval,
      'ClusterName': clusterName,
      'IsPasswordUse': isPasswordUse,
      'Admin': isAdmin,
      'Commander': isCommander,
      'Viewer': isViewer,
      'Employee': isEmployee,
      'CreateDate': createDate,
      'NumOfMembers': numberOfMember,
    };
  }
}