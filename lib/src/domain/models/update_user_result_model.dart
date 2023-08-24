class UpdateUserResultModel {
  String? id;
  String? phoneNumber;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? userAva;
  String? fcmToken;
  int? currenNoticeCount;


  UpdateUserResultModel(
      {this.id,
        this.phoneNumber,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.userAva,
        this.fcmToken,
        this.currenNoticeCount});

  UpdateUserResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    userName = json['userName'] ?? '';
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    address = json['address'] ?? '';
    userAva = json['userAva'] ?? '';
    fcmToken = json['fcmToken'] ?? '';
    currenNoticeCount = json['currenNoticeCount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phoneNumber'] = phoneNumber;
    data['userName'] = userName;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['address'] = address;
    data['userAva'] = userAva;
    data['fcmToken'] = fcmToken;
    data['currenNoticeCount'] = currenNoticeCount;
    return data;
  }
}