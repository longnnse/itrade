import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';

class RequestResultModel {
  late String id;
  late String dateCreated;
  late String dateUpdated;
  User? user;
  late Post post;
  late String description;
  late String status;

  RequestResultModel(
      {required this.id,
        required this.dateCreated,
        required this.dateUpdated,
        this.user,
        required this.post,
        required this.description,
        required this.status});

  RequestResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    post = (json['post'] != null ? Post.fromJson(json['post']) : null)!;
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['user'] = user!.toJson();
    data['post'] = post.toJson();
    data['description'] = description;
    data['status'] = status;
    return data;
  }
}