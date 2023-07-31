// import 'package:chatty_app/common/entities/post.dart';
// import 'package:chatty_app/common/entities/trading.dart';

import 'package:i_trade/src/domain/entities/trading.dart';

class TradingUserChatItem {
  String? id;
  String? content;
  String? status;
  TradingItem? trading;
  UserOms? user;

  TradingUserChatItem(
      {this.id, this.content, this.status, this.trading, this.user});

  factory TradingUserChatItem.fromJson(Map<String, dynamic> json) =>
      TradingUserChatItem(
          id: json["id"],
          content: json["content"],
          user: UserOms.fromJson(json['user']),
          trading: TradingItem.fromJson(json['trading']));
}

class UserOms {
  String? id;
  String? userAva;
  String? fcmToken;

  UserOms({this.id, this.userAva, this.fcmToken});

  factory UserOms.fromJson(Map<String, dynamic> json) =>
      UserOms(id: json["id"], userAva: json["userAva"], fcmToken: json['fcmToken']);
}
