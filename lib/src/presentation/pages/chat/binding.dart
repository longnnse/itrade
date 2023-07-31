import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/chat/controller.dart';
class ChatBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatController>(() => ChatController());
  }

}