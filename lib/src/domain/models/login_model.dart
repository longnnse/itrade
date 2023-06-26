class LoginModel {
  late String accessToken;
  late String tokenType;
  late String userID;
  late int expiresIn;
  late String userName;
  late String phoneNumber;

  LoginModel(
      {required this.accessToken,
        required this.tokenType,
        required this.userID,
        required this.expiresIn,
        required this.userName,
        required this.phoneNumber});

  LoginModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    userID = json['userID'];
    expiresIn = json['expires_in'];
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    data['userID'] = userID;
    data['expires_in'] = expiresIn;
    data['userName'] = userName;
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}