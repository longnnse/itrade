import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';

class GroupPostResultModel {
  late List<GroupPosts> groupPosts;
  late String id;
  late User user;
  late String description;
  late String dateCreated;
  late String dateUpdated;

  GroupPostResultModel(
      {required this.groupPosts,
        required this.id,
        required this.user,
        required this.description,
        required this.dateCreated,
        required this.dateUpdated});

  GroupPostResultModel.fromJson(Map<String, dynamic> json) {
    if (json['groupPosts'] != null) {
      groupPosts = <GroupPosts>[];
      json['groupPosts'].forEach((v) {
        groupPosts.add(GroupPosts.fromJson(v));
      });
    }
    id = json['id'] ?? '';
    user = (json['user'] != null ? User.fromJson(json['user']) : null)!;
    description = json['description'] ?? '';
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['groupPosts'] = groupPosts.map((v) => v.toJson()).toList();
    data['id'] = id;
    data['user'] = user.toJson();
    data['description'] = description;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    return data;
  }
}

class GroupPosts {
  late String id;
  late Post post;
  late String dateCreated;
  late String dateUpdated;

  GroupPosts({required this.id, required this.post, required this.dateCreated, required this.dateUpdated});

  GroupPosts.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    post = (json['post'] != null ? Post.fromJson(json['post']) : null)!;
    dateCreated = json['dateCreated'] ?? '';
    dateUpdated = json['dateUpdated'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['post'] = post.toJson();
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    return data;
  }
}


