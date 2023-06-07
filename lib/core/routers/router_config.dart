import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/chat/chat_controller.dart';
import 'package:i_trade/src/presentation/pages/chat/chat_page.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/history/history_controller.dart';
import 'package:i_trade/src/presentation/pages/history/history_page.dart';
import 'package:i_trade/src/presentation/pages/home/home_controller.dart';
import 'package:i_trade/src/presentation/pages/home/home_page.dart';
import 'package:i_trade/src/presentation/pages/information/information_controller.dart';
import 'package:i_trade/src/presentation/pages/information/information_page.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_page.dart';

import '../../src/presentation/pages/dashboard/dashboard_page.dart';

class ITradeRouterConfigs {
  static final List<GetPage> routes = [
    GetPage(
      name: DashboardPage.routeName,
      page: () => const DashboardPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => DashboardController());
        },
      ),
    ),
    GetPage(
      name: HomePage.routeName,
      page: () => const HomePage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => HomeController());
        },
      ),
    ),
    GetPage(
      name: ManagePage.routeName,
      page: () => const ManagePage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => ManageController());
        },
      ),
    ),
    GetPage(
      name: HistoryPage.routeName,
      page: () => const HistoryPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => HistoryController());
        },
      ),
    ),
    GetPage(
      name: ChatPage.routeName,
      page: () => const ChatPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => ChatController());
        },
      ),
    ),
    GetPage(
      name: InformationPage.routeName,
      page: () => const InformationPage(),
      binding: BindingsBuilder(
            () {
          // Get.put<ThongKeService>(ThongKeRepositories());
          Get.lazyPut(() => InformationController());
        },
      ),
    ),
  ];
}
