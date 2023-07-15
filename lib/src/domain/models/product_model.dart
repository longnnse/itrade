import 'package:i_trade/src/domain/models/category_model.dart';

class ProductModel {
  late int pageIndex;
  late int pageSize;
  late int totalPage;
  late int totalSize;
  late int pageSkip;
  late List<Data> data;

  ProductModel(
      {required this.pageIndex,
        required this.pageSize,
        required this.totalPage,
        required this.totalSize,
        required this.pageSkip,
        required this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'] ?? 0;
    pageSize = json['pageSize'] ?? 0;
    totalPage = json['totalPage'] ?? 0;
    totalSize = json['totalSize'] ?? 0;
    pageSkip = json['pageSkip'] ?? 0;
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
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
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class Data {
  late int requestTradeCount;
  late int requestCount;
  late List<Resources> resources;
  late List<PostCategories> postCategories;
  late String id;
  late User user;
  late String title;
  late String content;
  late String location;
  late double price;
  bool? isConfirmed;
  bool? isCompleted;
  late String type;
  late String dateCreated;
  late String dateUpdated;

  Data(
      {required this.requestTradeCount,
        required this.requestCount,
        required this.resources,
        required this.postCategories,
        required this.id,
        required this.user,
        required this.title,
        required this.content,
        required this.location,
        required this.price,
        this.isConfirmed,
        this.isCompleted,
        required this.type,
        required this.dateCreated,
        required this.dateUpdated});

  Data.fromJson(Map<String, dynamic> json) {
    requestTradeCount = json['requestTradeCount'] ?? 0;
    requestCount = json['requestCount'] ?? 0;
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources.add(Resources.fromJson(v));
      });
    }
    if (json['postCategories'] != null) {
      postCategories = <PostCategories>[];
      json['postCategories'].forEach((v) {
        postCategories.add(PostCategories.fromJson(v));
      });
    }
    id = json['id'] ?? '';
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    location = json['location'] ?? '';
    price = json['price'] ?? 0.0;
    isConfirmed = json['isConfirmed'] ?? false;
    isCompleted = json['isCompleted'] ?? false;
    type = json['type'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestTradeCount'] = requestTradeCount;
    data['requestCount'] = requestCount;
    data['resources'] = resources.map((v) => v.toJson()).toList();
    data['postCategories'] =
        postCategories.map((v) => v.toJson()).toList();
    data['id'] = id;
    data['user'] = user.toJson();
    data['title'] = title;
    data['content'] = content;
    data['location'] = location;
    data['price'] = price;
    data['isConfirmed'] = isConfirmed;
    data['isCompleted'] = isCompleted;
    data['type'] = type;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    return data;
  }
}

class Resources {
  late String id;
  late String dateCreated;
  late String dateUpdated;
  late bool isDeleted;
  late String postId;
  late String description;
  late String extension;

  Resources(
      {required this.id,
        required this.dateCreated,
        required this.dateUpdated,
        required this.isDeleted,
        required this.postId,
        required this.description,
        required this.extension});

  Resources.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
    isDeleted = json['isDeleted'];
    postId = json['postId'] ?? '';
    description = json['description'] ?? '';
    extension = json['extension'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['isDeleted'] = isDeleted;
    data['postId'] = postId;
    data['description'] = description;
    data['extension'] = extension;
    return data;
  }
}

class PostCategories {
  late String id;
  late CategoryModel category;

  PostCategories({required this.id,required this.category});

  PostCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    category = (json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category.toJson();
    return data;
  }
}


class User {
  late String id;
  late String phoneNumber;
  late String userName;
  late String firstName;
  late String lastName;
  late String email;
  late String address;

  User(
      {required this.id,
        required this.phoneNumber,
        required this.userName,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    phoneNumber = json['phoneNumber'] ?? '';
    userName = json['userName'] ?? '';
    firstName = json['firstName'] ?? '';
    lastName = json['lastName'] ?? '';
    email = json['email'] ?? '';
    address = json['address'] ?? '';
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
    return data;
  }
}