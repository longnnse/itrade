import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchController extends GetxController {
  Rx<RangeValues> currentRangeValues = const RangeValues(0, 30000000).obs;
  var formatNum = NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0);
  @override
  void onInit() {
    super.onInit();
  }

}