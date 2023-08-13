class NotiResultModel {
  int? pageIndex;
  int? pageSize;
  int? totalPage;
  int? totalSize;
  int? pageSkip;
  List<DataNoti>? data;

  NotiResultModel(
      {this.pageIndex,
        this.pageSize,
        this.totalPage,
        this.totalSize,
        this.pageSkip,
        this.data});

  NotiResultModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    totalSize = json['totalSize'];
    pageSkip = json['pageSkip'];
    if (json['data'] != null) {
      data = <DataNoti>[];
      json['data'].forEach((v) {
        data!.add(DataNoti.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['totalSize'] = totalSize;
    data['pageSkip'] = pageSkip;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataNoti {
  String? id;
  String? dateCreated;
  String? dateUpdated;
  bool? seen;
  String? action;
  String? description;
  String? subject;
  String? content;
  String? userId;
  User? user;
  String? fromUserId;
  User? fromUser;

  DataNoti(
      {this.id,
        this.dateCreated,
        this.dateUpdated,
        this.seen,
        this.action,
        this.description,
        this.subject,
        this.content,
        this.userId,
        this.user,
        this.fromUserId,
        this.fromUser});

  DataNoti.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
    seen = json['seen'] ?? false;
    action = json['action'] ?? '';
    description = json['description'] ?? '';
    subject = json['subject'] ?? '';
    content = json['content'] ?? '';
    userId = json['userId'] ?? '';
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    fromUserId = json['fromUserId'] ?? '';
    fromUser =
    json['fromUser'] != null ? User.fromJson(json['fromUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['seen'] = seen;
    data['action'] = action;
    data['description'] = description;
    data['subject'] = subject;
    data['content'] = content;
    data['userId'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['fromUserId'] = fromUserId;
    if (fromUser != null) {
      data['fromUser'] = fromUser!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? phoneNumber;
  String? userName;
  String? firstName;
  String? lastName;
  String? email;
  String? address;
  String? fcmToken;
  String? userAva;

  User(
      {this.id,
        this.phoneNumber,
        this.userName,
        this.firstName,
        this.lastName,
        this.email,
        this.address,
        this.fcmToken,
        this.userAva});

  User.fromJson(Map<String, dynamic> json) {
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