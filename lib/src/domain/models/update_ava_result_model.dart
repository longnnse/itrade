class UpdateAvaResultModel {
  String? id;
  String? phoneNumber;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? fcmToken;
  String? userAva;

  UpdateAvaResultModel(
      {this.id,
        this.phoneNumber,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.fcmToken,
        this.userAva});

  UpdateAvaResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    userName = json['userName'] ?? '';
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    address = json['address'] ?? '';
    fcmToken = json['fcmToken'] ?? '';
    userAva = json['userAva'] ?? '';
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
    data['fcmToken'] = fcmToken;
    data['userAva'] = userAva;
    return data;
  }
}