import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';

import '../../../../core/initialize/theme.dart';


class ManagePage extends GetView<ManageController> {
  static const String routeName = '/ManagePage';
  final Widget? leading;
  const ManagePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        body: Text('Quản lý'));
  }
}