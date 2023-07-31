import 'package:i_trade/common/utils/http.dart';
import 'package:i_trade/src/domain/entities/msg_content.dart';

class MessageAPI {
  static Future<MessageSwagger> get_trading_sent(MessageQuery messageQuery) async {
    var response =
        await HttpUtil().get('api/Message', queryParameters: messageQuery.toJson());
    return MessageSwagger.fromJson(response);
  }

    static Future<Msgcontent> send_message(MessageRequestEntity messageRequestEntity) async {
    var response =
        await HttpUtil().post('api/Message', data: messageRequestEntity.toJson());
    return Msgcontent.fromJson(response);
  }
}
