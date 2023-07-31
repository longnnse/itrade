import 'package:i_trade/src/domain/entities/resource.dart';
import 'package:i_trade/src/domain/entities/tradingUserChat.dart';

class PostItem {
  String? id;
  List<ResourceItem>? resources;
  UserOms? user;

  PostItem({this.id, this.resources, this.user});

  factory PostItem.fromJson(Map<String, dynamic> json) => PostItem(
        id: json["id"],
        user: json['user'] != null ? UserOms.fromJson(json['user']) : null,
        resources: json["resources"] != null
            ? List<ResourceItem>.from(
                json["resources"].map((x) => ResourceItem.fromJson(x)))
            : [],
      );
}
