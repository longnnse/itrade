import 'package:get/get.dart';

class ManageController extends GetxController {
  RxBool isBuying = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void updateStatus(bool isChange){
    isBuying.call(isChange == true ? true : false);
  }

}