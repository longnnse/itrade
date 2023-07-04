import 'package:core_http/core_http.dart';
import 'package:get/get.dart';

import '../../src/domain/services/home_service.dart';
import '../../src/infrastructure/repositories/home_repository.dart';

class ITradeGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
    Get.put<HomeService>(HomeRepositories());
  }
}