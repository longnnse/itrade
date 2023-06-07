import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/initialize/theme.dart';
import 'history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  static const String routeName = '/HistoryPage';
  final Widget? leading;
  const HistoryPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        body: Text('Lịch sử'));
  }
}