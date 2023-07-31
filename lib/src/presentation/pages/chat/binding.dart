import 'package:get/get.dart';
import 'controller.dart';
class ChatBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<ChatController>(() => ChatController());
  }

}