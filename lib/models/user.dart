class UserHome {
  String? userImage;
  String? userId;
  String? userName;

  UserHome({this.userImage, this.userId, this.userName});

  UserHome.fromJson(Map<dynamic, dynamic> json) {
    userImage = json['user_image'];
    userId = json['user_id'];
    userName = json['user_name'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = new Map<dynamic, dynamic>();
    data['user_image'] = this.userImage;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    return data;
  }
}