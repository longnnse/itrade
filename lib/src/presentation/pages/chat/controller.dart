import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:i_trade/common/apis/chat.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/base.dart';

class ChatController extends GetxController {
  ChatController();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    firebaseMessageSetup();
  }

  firebaseMessageSetup() async {
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    print("...my device token is $fcmToken");
    print("...my token ${AppSettings.getValue(KeyAppSetting.token)}");
    if (fcmToken != null) {
      BindFcmTokenRequestEntity bindFcmTokenRequestEntity =
          BindFcmTokenRequestEntity();

      bindFcmTokenRequestEntity.fcmtoken = fcmToken;
      await ChatAPI.bind_fcmtoken(bindFcmTokenRequestEntity);
      // print(result.fcmToken);
      //print(res.code);
      //print(res.msg);
    }
  }
}
