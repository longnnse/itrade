import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/initialize/theme.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const String routeName = '/HomePage';
  final Widget? leading;
  const HomePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackground,
        body: Text('Trang chủ')
    );
  }
}