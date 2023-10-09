class MyArriveArray {
  String? userId;
  String? userName;
  String? userImageUrl;
  String? userLoginTime;
  int? userState ;

  MyArriveArray({this.userId, this.userName, this.userImageUrl, this.userLoginTime , this.userState});

  MyArriveArray.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    userImageUrl = json['user_ImageUrl'];
    userLoginTime = json['user_Login_Time'];
    userState = json['user_State'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_ImageUrl'] = this.userImageUrl;
    data['user_Login_Time'] = this.userLoginTime;
    data['user_State'] = this.userState;
    return data;
  }
}
