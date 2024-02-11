class UserData{
  String? userIdval;
  String? userName;

  UserData({this.userIdval,this.userName});
  
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userIdval: json['UserIdval'],
      userName: json['UserName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'UserIdval': userIdval,
      'UserName': userName
    };
  }
}