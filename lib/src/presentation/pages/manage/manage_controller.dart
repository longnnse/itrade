import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';

class ManageController extends GetxController {
  RxBool isBuying = true.obs;
  final ManageService _manageService = Get.find();
  final RxBool isLoading = false.obs;
  final Rxn<List<Data>> productList = Rxn<List<Data>>();
  @override
  void onInit() {
    super.onInit();
  }

  void updateStatus(bool isChange){
    isBuying.call(isChange == true ? true : false);
  }

  Future<void> getPersonalPosts() async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, List<Data>> res = await _manageService.getPersonalPosts();

    res.fold(
          (failure) {
        isLoading.call(false);
      },
          (value) async {
        productList.call(value);
        isLoading.call(false);
      },
    );
  }

}