import 'package:register_customer/services/api_service.dart';

abstract class HomeScreenRepository {
  Future<dynamic> fetchClusterLists(String userId);
  Future<dynamic> createCluster(String clusterName,String password,bool isUsePas,String userId);
  Future<dynamic> validateClusterPassword(String userId,String clusterIdval,String password);
  Future<dynamic> getCategoryList(String userId,String clusterIdval);
  Future<dynamic> getUseReportList(String userId,String categoryidval,int page);
  Future<dynamic> saveUseReport(String userId,String useAmount,String description,String categoryIdval);
  Future<dynamic> getUserListInCluster(String userId,String categoryidval,int curRow,String username);
  Future<dynamic> getPossessValue(String userId,String categoryIdval);
  Future<dynamic> getCollectReportList(String userId,String categoryidval,int curRow);
}

class HomeScreenRepositoryImpl extends HomeScreenRepository {
  ApiService apiService = ApiService();
  @override
  Future fetchClusterLists(String userId) {
    Map<String, dynamic> requestBody = {'UserId': userId};
    return apiService.post('api/Cluster/GetClusterList', requestBody);
  }


  @override
  Future createCluster(String clusterName,String password,bool isUsePas,String userId){
    Map<String,dynamic> requestBody={
      'ClusterName': clusterName,
      'IsPasswordUse': isUsePas,
      'Password': password,
      'CreatorIdval': userId
    };
    return apiService.post('api/Cluster/CreateCluster', requestBody);
  }

  @override
  Future validateClusterPassword(String userId,String clusterIdval,String password) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'ClusterIdval': clusterIdval,
      'Password':password
      };
    return apiService.post('api/Cluster/ValidateClusterPassword', requestBody);
  }

  @override
  Future getCategoryList(String userId,String clusterIdval) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'ClasterIdval': clusterIdval
      };
    return apiService.post('api/Category/GetCategoryList', requestBody);
  }

  @override
  Future getUseReportList(String userId,String categoryidval,int page) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'CategoryIdval': categoryidval,
      "Cur_Row": page,
      "pageSize": 10
      };
    return apiService.post('api/UseReport/GetUseReportList', requestBody);
  }
  
  @override
  Future saveUseReport(String userId,String useAmount,String description,String categoryIdval) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'ReportDescription': description,
      "UseAmount": useAmount,
      "CategoryIdval": categoryIdval
      };
    return apiService.post('api/UseReport/SaveUseReport', requestBody);
  }

   @override
  Future getUserListInCluster(String userId,String categoryidval,int curRow,String username) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'Cur_Row': curRow,
      "limitRow": 10,
      "CategoryIdval": categoryidval,
      "UserName": username
      };
    return apiService.post('api/Member/GetUserListInCluster', requestBody);
  }

  
  @override
  Future getPossessValue(String userId,String categoryIdval) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      'CategoryIdval': categoryIdval
      };
    return apiService.post('api/Collect/GetCollectPossessValue', requestBody);
  }

  
   @override
  Future getCollectReportList(String userId,String categoryidval,int curRow) {
    Map<String, dynamic> requestBody = {
      'UserId': userId,
      "CategoryIdval": categoryidval,
      'Cur_Row': curRow,
      "pageSize": 10,
      };
    return apiService.post('api/Collect/GetCollectReportList', requestBody);
  }
}
