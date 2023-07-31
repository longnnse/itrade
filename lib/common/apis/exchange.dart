import 'package:i_trade/common/utils/http.dart';
import 'package:i_trade/src/domain/entities/trading.dart';
import 'package:i_trade/src/domain/entities/tradingUserChat.dart';

class ExchangeAPI {

  static Future<List<TradingItem>> get_trading_sent() async {
    var response = await HttpUtil().get('api/Trading/TradingSent');
    var list = <TradingItem>[];
    if (response != null) {
      for (var v in response) {
        list.add(TradingItem.fromJson(v));
      }
    }
    return list;
  }

  static Future<List<TradingItem>> get_trading_received() async {
    var response = await HttpUtil().get('api/Trading/TradingReceived');
    var list = <TradingItem>[];
    if (response != null) {
      for (var v in response) {
        list.add(TradingItem.fromJson(v));
      }
    }
    return list;
  }

  static Future<TradingUserChatItem> create_trading_user_chat(
      String tradingId) async {
    var response = await HttpUtil()
        .post('api/TradingUserChat', data: {"tradingId": tradingId});
    return TradingUserChatItem.fromJson(response);
  }
}
