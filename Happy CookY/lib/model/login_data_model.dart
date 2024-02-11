class LoginDataModel {
  LoginDataModel({
    required this.accessToken,
    required this.expiresIn,
    required this.userId,
    required this.loginType,
    required this.userLevelId,
    required this.displayName,
  });

  final String? accessToken;
  final int? expiresIn;
  final String? userId;
  final String? loginType;
  final int? userLevelId;
  final String? displayName;

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        accessToken: json["AccessToken"],
        expiresIn: json["ExpiresIn"],
        userId: json["UserID"],
        loginType: json["LoginType"],
        userLevelId: json["UserLevelID"],
        displayName: json["DisplayName"],
      );

  Map<String, dynamic> toJson() => {
        "AccessToken": accessToken,
        "ExpiresIn": expiresIn,
        "UserID": userId,
        "LoginType": loginType,
        "UserLevelID": userLevelId,
        "DisplayName": displayName,
      };
}
