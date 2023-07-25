import 'package:i_trade/src/domain/models/product_model.dart';

class SellFreeResultModel {
  late String id;
  late String dateCreated;
  late String dateUpdated;
  late User user;
  late Post post;
  late String description;
  late String status;

  SellFreeResultModel(
      {required this.id,
        required this.dateCreated,
        required this.dateUpdated,
        required this.user,
        required this.post,
        required this.description,
        required this.status});

  SellFreeResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    post = (json['post'] != null ? Post.fromJson(json['post']) : null)!;
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['user'] = user.toJson();
    data['post'] = post.toJson();
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}

class Post {
  late String id;
  User? user;
  late String title;
  late String? content;
  late String location;
  late double? price;
  late bool isConfirmed;
  late bool isCompleted;
  late bool isUsed;
  late String type;
  late String dateCreated;
  late String dateUpdated;

  Post(
      {required this.id,
        this.user,
        required this.title,
         this.content,
        required this.location,
         this.price,
        required this.isConfirmed,
        required this.isCompleted,
        required this.isUsed,
        required this.type,
        required this.dateCreated,
        required this.dateUpdated});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    title = json['title'];
    content = json['content'];
    location = json['location'];
    price = json['price'];
    isConfirmed = json['isConfirmed'];
    isCompleted = json['isCompleted'];
    isUsed = json['isUsed'];
    type = json['type'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user'] = user;
    data['title'] = title;
    data['content'] = content;
    data['location'] = location;
    data['price'] = price;
    data['isConfirmed'] = isConfirmed;
    data['isCompleted'] = isCompleted;
    data['isUsed'] = isUsed;
    data['type'] = type;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    return data;
  }
}