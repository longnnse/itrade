import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/apis/exchange.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/trading.dart';
import 'package:i_trade/src/presentation/pages/chat/index.dart';
import 'package:i_trade/src/presentation/pages/exchange/state.dart';

class ExchangeController extends GetxController {
  ExchangeController();
  final title = "Chatty";
  final state = ExchangeState();
  final token = AppSettings.getValue(KeyAppSetting.userId);

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  Future<void> gochat(TradingItem tradingItem) async {
    var tradingUserChat =
        await ExchangeAPI.create_trading_user_chat(tradingItem.id!);
    // ignore: unnecessary_null_comparison
    if (tradingUserChat != null) {
      Get.toNamed(ChatPage.routeName, parameters: {
        "trading_id": tradingItem.id!,
        "to_avatar": AppSettings.getValue(KeyAppSetting.userId) ==
                tradingItem.fromPost!.user!.id!
            ? tradingItem.toPost!.user!.userAva!
            : tradingItem.fromPost!.user!.userAva!,
      });
    }
  }

  asyncLoadAllData() async {
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    state.tradingList.clear();
    var tradingReceived = await ExchangeAPI.get_trading_received();
    var tradingSent = await ExchangeAPI.get_trading_sent();
    if (tradingReceived != null) {
      state.tradingList.addAll(tradingReceived);
      state.tradingList.addAll(tradingSent);
    }
    EasyLoading.dismiss();
  }
}
