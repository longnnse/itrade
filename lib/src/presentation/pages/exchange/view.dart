import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/values/colors.dart';
import 'package:i_trade/src/presentation/pages/exchange/widgets/exchange_list.dart';

import 'controller.dart';

class ExchangePage extends GetView<ExchangeController> {
  static const String routeName = '/ExchangePage';
  const ExchangePage({super.key});

  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text("Trading list",
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(ExchangeController());
    return Scaffold(
        appBar: _buildAppbar(),
        body: Container(
          width: 360.w,
          height: 780.h,
          child: ExchangeList(),
        ));
  }
}
