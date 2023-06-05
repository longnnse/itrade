import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/floating_action_button.dart';

class DashboardController extends GetxController {
  final RxBool isLoading = false.obs;
  RxString lastSelected = 'TAB: 0'.obs;
  RxDouble itemCount = 20.0.obs;
  Rx<Icon> icon = const Icon(Icons.home, size: 30.0,).obs;
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
    index == 2 ? const Icon(Icons.history, size: 30.0) :
    index == 3 ? const Icon(Icons.chat, size: 30.0) : const Icon(Icons.person, size: 30.0));
  }


}