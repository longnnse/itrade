import 'dart:io';

// import 'package:chatty_app/common/entities/base.dart';
// import 'package:chatty_app/common/entities/chat.dart';
// import 'package:chatty_app/common/entities/msg_content.dart';
// import 'package:chatty_app/common/entities/tradingUserChat.dart';
// import 'package:chatty_app/common/utils/http.dart';
import 'package:dio/dio.dart';
import 'package:i_trade/common/utils/http.dart';
import 'package:i_trade/src/domain/entities/base.dart';
import 'package:i_trade/src/domain/entities/tradingUserChat.dart';

class ChatAPI {
  // static Future<Msgcontent> upload_img({
  //   File? file,
  //   String? tradingId,
  // }) async {
  //   String fileName = file!.path.split("/").last;
  //   FormData data = FormData.fromMap({
  //     "File": await MultipartFile.fromFile(file.path, filename: fileName),
  //     "TradingId": tradingId
  //   });
  //   var response = await HttpUtil().post('api/Message/SendImage', data: data);
  //   return Msgcontent.fromJson(response);
  // }

  // static Future<BaseResponseEntity> call_token({
  //   CallTokenRequestEntity? params,
  // }) async {
  //   var response = await HttpUtil()
  //       .post('api/get_rtc_token', queryParameters: params?.toJson());
  //   return BaseResponseEntity.fromJson(response);
  // }

  // static Future<BaseResponseEntity> call_notifications({
  //   CallRequestEntity? params,
  // }) async {
  //   var response = await HttpUtil()
  //       .post('api/send_notice', queryParameters: params?.toJson());
  //   return BaseResponseEntity.fromJson(response);
  // }

  static Future<UserOms> bind_fcmtoken(BindFcmTokenRequestEntity data) async {
    var response =
        await HttpUtil().post('api/User/BindFcmToken', data: data.toJson());
    return UserOms.fromJson(response);
  }
}
