import 'package:core_http/core_http.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/services/login_service.dart';
import 'package:i_trade/src/infrastructure/repositories/login_repository.dart';
import 'package:i_trade/src/infrastructure/repositories/manage_repository.dart';

import '../../src/domain/services/home_service.dart';
import '../../src/domain/services/manage_service.dart';
import '../../src/infrastructure/repositories/home_repository.dart';

class ITradeGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
    Get.put<HomeService>(HomeRepositories());
    Get.put<ManageService>(ManageRepositories());
    Get.put<LoginService>(LoginRepositories());
  }
}