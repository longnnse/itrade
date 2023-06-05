import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/dashboard/widgets/dashboard_shimmer_widget.dart';
import 'package:i_trade/src/presentation/widgets/FABBottomAppBar.dart';
import 'package:i_trade/src/presentation/widgets/appbar_customize.dart';
import 'package:i_trade/src/presentation/widgets/floating_action_button.dart';

import '../../../../core/initialize/theme.dart';

class DashboardPage extends GetView<DashboardController> {
  static const String routeName = '/DashboardPage';
  final Widget? leading;
  const DashboardPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: AppbarCustomize.buildAppbar(
        context: context,
        title: 'Trang chủ',
        isUseOnlyBack: false
      ),
      floatingActionButtonLocation: CenterDockedFloatingActionButtonLocation(controller.itemCount.value),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: kDefaultGradient,
          ),
          child: controller.icon.value,
        ),
      ),
      backgroundColor: kBackground,
      bottomNavigationBar: FABBottomAppBar(
          items: [
            FABBottomAppBarItem(iconData: Icons.home, text: 'Trang chủ'),
            FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Quản lý'),
            FABBottomAppBarItem(iconData: Icons.history, text: 'Lịch sử'),
            FABBottomAppBarItem(iconData: Icons.chat, text: 'Trao đổi'),
            FABBottomAppBarItem(iconData: Icons.person, text: 'Cá nhân'),
          ],
          backgroundColor: kBackgroundBottomBar,
          color: Colors.red,
          selectedColor: kPrimaryLightColor,
          notchedShape: const CircularNotchedRectangle(),
          onTabSelected: controller.selectedTab
      ),
      body: Obx(
            () {
          if (controller.isLoading.value) {
            return const DashboarShimmerWidget(
              columnCount: 3,
            );
          }
          return Container();
        },
      ),
    ));
  }
}
