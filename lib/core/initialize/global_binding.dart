import 'package:core_http/core_http.dart';
import 'package:get/get.dart';

class ITradeGlobalBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CoreHttp>(CoreHttpImplement(appName: 'appName'), permanent: true);
  }
}