import 'package:get/get.dart';

class UploadPostController extends GetxController {
  RxList<String>  items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ].obs;
  RxString selectedValue = 'Item1'.obs;
  RxBool isNew = false.obs;
  RxBool isPro = false.obs;
  RxBool isFree = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

}