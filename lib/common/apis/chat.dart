import 'dart:io';

import 'package:dio/dio.dart';
import 'package:i_trade/common/utils/http.dart';
import 'package:i_trade/src/domain/entities/base.dart';
import 'package:i_trade/src/domain/entities/msg_content.dart';
import 'package:i_trade/src/domain/entities/tradingUserChat.dart';

class ChatAPI {
  static Future<Msgcontent> upload_img({
    File? file,
    String? tradingId,
  }) async {
    String fileName = file!.path.split("/").last;
    FormData data = FormData.fromMap({
      "File": await MultipartFile.fromFile(file.path, filename: fileName),
      "TradingId": tradingId
    });
    var response = await HttpUtil().post('api/Message/SendImage', data: data);
    return Msgcontent.fromJson(response);
  }

  static Future<UserOms> bind_fcmtoken(BindFcmTokenRequestEntity data) async {
    var response =
        await HttpUtil().post('api/User/BindFcmToken', data: data.toJson());
    return UserOms.fromJson(response);
  }
}
