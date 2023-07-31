import 'package:i_trade/src/domain/entities/tradingUserChat.dart';

class Msgcontent {
  final String? id;
  final String? dateCreated;
  final String? content;
  final String? type;
  final TradingUserChatItem? tradingUserChat;

  Msgcontent(
      {this.content,
      this.dateCreated,
      this.id,
      this.type,
      this.tradingUserChat});

  factory Msgcontent.fromJson(Map<String, dynamic> data) {
    var typeResult = "Text";
    switch (data['status'].toString()) {
      case "0":
        typeResult = "Text";
        break;
      case "1":
        typeResult = "Image";
        break;
      default:
        typeResult = data['status'].toString();
    }
    return Msgcontent(
        id: data['id'],
        content: data['content'],
        dateCreated: data['dateCreated'],
        type: typeResult,
        tradingUserChat: data['tradingUserChat'] != null
            ? TradingUserChatItem.fromJson(data['tradingUserChat'])
            : null);
  }

}

class MessageSwagger {
  List<Msgcontent>? data;
  int? pageIndex;
  int? pageSize;
  int? pageSkip;
  int? totalPage;
  int? totalSize;

  MessageSwagger({
    this.data,
    this.pageIndex,
    this.pageSize,
    this.pageSkip,
    this.totalPage,
    this.totalSize,
  });

  MessageSwagger.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    pageSkip = json['pageSkip'];
    totalPage = json['totalPage'];
    totalSize = json['totalSize'];
    if (json['data'] != null) {
      data = <Msgcontent>[];
      json['data'].forEach((v) {
        data?.add(Msgcontent.fromJson(v));
      });
    }
  }
}

class MessageRequestEntity {
  String tradingId;
  String content;

  MessageRequestEntity({
    required this.tradingId,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        "tradingId": tradingId,
        "content": content,
      };
}

class MessageQuery {
  String TradingId;
  int PageIndex;
  int PageSize;

  MessageQuery({
    required this.TradingId,
    required this.PageIndex,
    required this.PageSize,
  });

  Map<String, dynamic> toJson() => {
        "TradingId": TradingId,
        "PageIndex": PageIndex,
        "PageSize": PageSize,
      };
}
