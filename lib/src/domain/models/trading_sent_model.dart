import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';

class TradingSentResultModel {
  String? id;
  FromGroup? fromGroup;
  FromGroup? toGroup;
  String? content;
  String? status;

  TradingSentResultModel(
      {this.id, this.fromGroup, this.toGroup, this.content, this.status});

  TradingSentResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fromGroup = json['fromGroup'] != null
        ? FromGroup.fromJson(json['fromGroup'])
        : null;
    toGroup = json['toGroup'] != null
        ? FromGroup.fromJson(json['toGroup'])
        : null;
    content = json['content'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (fromGroup != null) {
      data['fromGroup'] = fromGroup!.toJson();
    }
    if (toGroup != null) {
      data['toGroup'] = toGroup!.toJson();
    }
    data['content'] = content;
    data['status'] = status;
    return data;
  }
}

class FromGroup {
  List<GroupPosts>? groupPosts;
  String? id;
  User? user;
  String? description;
  String? dateCreated;
  String? dateUpdated;

  FromGroup(
      {this.groupPosts,
        this.id,
        this.user,
        this.description,
        this.dateCreated,
        this.dateUpdated});

  FromGroup.fromJson(Map<String, dynamic> json) {
    if (json['groupPosts'] != null) {
      groupPosts = <GroupPosts>[];
      json['groupPosts'].forEach((v) {
        groupPosts!.add(GroupPosts.fromJson(v));
      });
    }
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    description = json['description'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (groupPosts != null) {
      data['groupPosts'] = groupPosts!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['description'] = description;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    return data;
  }
}

class GroupPosts {
  String? id;
  Post? post;
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


  GroupPosts({this.id, this.post, required this.title,
    this.content,
    required this.location,
    this.price,
    required this.isConfirmed,
    required this.isCompleted,
    required this.isUsed,
    required this.type,
    required this.dateCreated,
    required this.dateUpdated});

  GroupPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    title = json['title'] ?? '';
    content = json['content'] ?? '';
    location = json['location'] ?? '';
    price = json['price'];
    isConfirmed = json['isConfirmed'] ?? false;
    isCompleted = json['isCompleted'] ?? false;
    isUsed = json['isUsed'] ?? false;
    type = json['type'] ?? '';
    dateCreated = json['dateCreated']?? '';
    dateUpdated = json['dateUpdated']?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (post != null) {
      data['post'] = post!.toJson();
    }
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


