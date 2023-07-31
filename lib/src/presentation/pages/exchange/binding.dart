import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/exchange/index.dart';
class ExchangeBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ExchangeController>(() => ExchangeController());
  }

}