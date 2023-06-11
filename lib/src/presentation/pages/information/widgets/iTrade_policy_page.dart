import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../information_controller.dart';


class ITradePolicyPage extends GetView<InformationController> {
  static const String routeName = '/ITradePolicyPage';
  final Widget? leading;
  const ITradePolicyPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: controller.title.value,
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Column(
          children: [
          ],
        ));
  }
}
