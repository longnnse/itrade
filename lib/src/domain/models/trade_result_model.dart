import 'package:i_trade/src/domain/models/trade_model.dart';

class TradeResultModel {
  late String fromPostId;
  Post? fromPost;
  late String toPostId;
  Post? toPost;
  String? content;
  late String status;
  late String id;
  late String dateCreated;
  late String dateUpdated;
  late bool isDeleted;

  TradeResultModel(
      {required this.fromPostId,
        this.fromPost,
        required this.toPostId,
        this.toPost,
        this.content,
        required this.status,
        required this.id,
        required this.dateCreated,
        required this.dateUpdated,
        required this.isDeleted});

  TradeResultModel.fromJson(Map<String, dynamic> json) {
    fromPostId = json['fromPostId'] ?? '';
    fromPost = json['fromPost'] != null
        ? Post.fromJson(json['fromPost'])
        : null;
    toPostId = json['toPostId'] ?? '';
    toPost =
    json['toPost'] != null ? Post.fromJson(json['toPost']) : null;
    content = json['content'] ?? '';
    status = json['status'] ?? '';
    id = json['id'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fromPostId'] = fromPostId;
    data['fromPost'] = fromPost!.toJson();
    data['toPostId'] = toPostId;
    data['toPost'] = toPost!.toJson();
    data['content'] = content ?? '';
    data['status'] = status;
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['isDeleted'] = isDeleted;
    return data;
  }
}

class Post {
  late String createBy;
  User? user;
  late String title;
  String? content;
  late String location;
  late double price;
  late bool isConfirmed;
  late bool isCompleted;
  late bool isUsed;
  late String type;
  List<Resources>? resources;
  List<PostCategories>? postCategories;
  late String id;
  late String dateCreated;
  late String dateUpdated;
  late bool isDeleted;

  Post(
      {required this.createBy,
        this.user,
        required this.title,
        this.content,
        required this.location,
        required this.price,
        required this.isConfirmed,
        required this.isCompleted,
        required this.isUsed,
        required this.type,
        this.resources,
        this.postCategories,
        required this.id,
        required this.dateCreated,
        required this.dateUpdated,
        required this.isDeleted});

  Post.fromJson(Map<String, dynamic> json) {
    createBy = json['createBy'] ?? '';
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    location = json['location'] ?? '';
    price = json['price'] ?? 0;
    isConfirmed = json['isConfirmed'];
    isCompleted = json['isCompleted'];
    isUsed = json['isUsed'];
    type = json['type'];
    if (json['resources'] != null) {
      resources = <Resources>[];
      json['resources'].forEach((v) {
        resources!.add(Resources.fromJson(v));
      });
    }
    if (json['postCategories'] != null) {
      postCategories = <PostCategories>[];
      json['postCategories'].forEach((v) {
        postCategories!.add(PostCategories.fromJson(v));
      });
    }
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createBy'] = createBy;
    data['user'] = user;
    data['title'] = title;
    data['content'] = content;
    data['location'] = location;
    data['price'] = price;
    data['isConfirmed'] = isConfirmed;
    data['isCompleted'] = isCompleted;
    data['isUsed'] = isUsed;
    data['type'] = type;
    data['resources'] = resources;
    data['postCategories'] = postCategories;
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['isDeleted'] = isDeleted;
    return data;
  }
}