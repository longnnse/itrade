import 'dart:async';

import 'package:flutter/material.dart';
import 'package:i_trade/core/config/user_config.dart';

class ITradeModuleConfig {
  late String baseUrl;
  // ChatGroupCallBack? onTapTaskChatGroup;
  // ChatGroupCallBack? onTapTaskChatGroupKNTC;
  // ChatGroupCallBack? onTapTaskChatGroupHSHC;
  // ChatGroupCallBack? onTapTaskChatGroupISO;
  // ChatGroupCallBack? onTapTaskChatGroupTDCD;
  // late Widget Function(BuildContext context, DanhSachVanBanModel item)
  // getItemVanBanDen;
  late void Function(int phongBanId, int userId) pushToDanhSachCongViec;

  void init(
      {required String baseUrl,
      // required Widget Function(BuildContext context, DanhSachVanBanModel item)
      // getItemVanBanDen,
      required UserConfig userConfig,
      required Function(int phongBanId, int userId) pushToDanhSachCongViec
      // ChatGroupCallBack? onTapTaskChatGroup,
      // ChatGroupCallBack? onTapTaskChatGroupKNTC,
      // ChatGroupCallBack? onTapTaskChatGroupHSHC,
      // ChatGroupCallBack? onTapTaskChatGroupISO,
      // ChatGroupCallBack? onTapTaskChatGroupTDCD,
      }) {
    this.baseUrl = baseUrl;
    // this.getItemVanBanDen = getItemVanBanDen;
    this.pushToDanhSachCongViec = pushToDanhSachCongViec;
    setUserConfig = userConfig;
    // this.onTapTaskChatGroup = onTapTaskChatGroup;
    // this.onTapTaskChatGroupKNTC = onTapTaskChatGroupKNTC;
    // this.onTapTaskChatGroupHSHC = onTapTaskChatGroupHSHC;
    // this.onTapTaskChatGroupISO = onTapTaskChatGroupISO;
    // this.onTapTaskChatGroupTDCD = onTapTaskChatGroupTDCD;
  }

  UserConfig? _userConfig;

  UserConfig get getUserConfig {
    if (_userConfig == null) {
      throw AssertionError(
          "Bạn chưa login vào module, vui lòng login trước khi sử dụng");
    }
    return _userConfig!;
  }

  set setUserConfig(UserConfig? userConfig) => _userConfig = userConfig;
}

typedef ChatGroupCallBack = FutureOr<void> Function(
  BuildContext context,
  int userId,
  int taskId,
  int donViId,
  List<int>? userIDs,
);
