import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/chat/chat_page.dart';
import 'package:i_trade/src/presentation/pages/home/home_page.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_page.dart';
import 'package:i_trade/src/presentation/pages/search/search_page.dart';
import 'package:intl/intl.dart';

import '../information/information_page.dart';

class DashboardController extends GetxController {
  final RxBool isLoading = false.obs;
  RxString appBarTitle = 'Trang chủ'.obs;
  RxString lastSelected = 'TAB: 0'.obs;
  RxDouble itemCount = 20.0.obs;
  Rx<Icon> icon = const Icon(Icons.home, size: 30.0,).obs;
  Rx<RangeValues> currentRangeValues = const RangeValues(0, 30000000).obs;
  var formatNum = NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0);
  @override
  void onInit() {
    super.onInit();
  }
  void selectedTab(int index) {
    lastSelected.call('TAB: $index');
    itemCount.call(index == 0 ? 20.0 :
    index == 1 ? 3.5 :
    index == 2 ? 2.0 :
    index == 3 ? 1.35 : 1.05);
    icon.call(index == 0 ? const Icon(Icons.home, size: 30.0) :
    index == 1 ? const Icon(Icons.dashboard, size: 30.0) :
    index == 2 ? const Icon(Icons.search, size: 30.0) :
    index == 3 ? const Icon(Icons.chat, size: 30.0) : const Icon(Icons.person, size: 30.0));
    appBarTitle.call(index == 0 ? 'Trang chủ' :
    index == 1 ? 'Quản lý' :
    index == 2 ? 'Tìm kiếm' :
    index == 3 ? 'Trao đổi' : 'Cá nhân');
  }

  Widget changePage() {
    Widget content = Container();
    switch(lastSelected.value){
      case 'TAB: 0':
        content = const HomePage();
        break;
      case 'TAB: 1':
        content = const ManagePage();
        break;
      case 'TAB: 2':
        content = const SearchPage();
        break;
      case 'TAB: 3':
        content = const ChatPage();
        break;
      case 'TAB: 4':
        content = const InformationPage();
        break;

    }
    return content;
  }
}