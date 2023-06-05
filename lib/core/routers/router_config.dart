import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';

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
  ];
}
