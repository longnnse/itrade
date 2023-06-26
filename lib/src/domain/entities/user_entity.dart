class UserEntity {
  late String userId;
  late String email;
  late String fullName;
  late String userName;
  late String phoneNumber;
  late int exp;
  late String iss;
  late String aud;

  UserEntity(
      {required this.userId,
        required this.email,
        required this.fullName,
        required this.userName,
        required this.phoneNumber,
        required this.exp,
        required this.iss,
        required this.aud,});

  UserEntity.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    email = json['Email'];
    fullName = json['FullName'];
    userName = json['UserName'];
    phoneNumber = json['PhoneNumber'];
    exp = json['exp'];
    iss = json['iss'];
    aud = json['aud'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['Email'] = email;
    data['FullName'] = fullName;
    data['UserName'] = userName;
    data['PhoneNumber'] = phoneNumber;
    data['exp'] = exp;
    data['iss'] = iss;
    data['aud'] = aud;
    return data;
  }
}