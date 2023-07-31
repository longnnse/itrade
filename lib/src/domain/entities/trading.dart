
import 'package:i_trade/src/domain/entities/post.dart';

class TradingItem {
  String? id;
  String? content;
  String? status;
  PostItem? toPost;
  PostItem? fromPost;

  TradingItem({this.id, this.content, this.status, this.toPost, this.fromPost});

  factory TradingItem.fromJson(Map<String, dynamic> json) => TradingItem(
      id: json["id"],
      content: json["content"],
      fromPost:
          json['fromPost'] != null ? PostItem.fromJson(json['fromPost']) : null,
      toPost:
          json['toPost'] != null ? PostItem.fromJson(json['toPost']) : null);
}
