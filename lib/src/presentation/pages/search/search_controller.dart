import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/infrastructure/repositories/home_repository.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/product_model.dart';
import '../../../domain/services/home_service.dart';
import '../home/home_controller.dart';
import '../home/widgets/product_detail.dart';

class SearchController extends GetxController {
  Rx<RangeValues> currentRangeValues = const RangeValues(0, 30000000).obs;
  var formatNum = NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0);
  final RxBool isLoading = false.obs;
  final HomeService _homeService = Get.find();
  final Rxn<ProductModel> productModel = Rxn<ProductModel>();
  @override
  void onInit() {
    super.onInit();
  }

  void goDetail({required String id}){
    final HomeController homeController = Get.find();
    homeController.idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  Future<void> getPosts({required int pageIndex,required int pageSize}) async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, ProductModel> res = await _homeService.getPosts(pageSize: pageSize, pageIndex: pageIndex);

    res.fold(
          (failure) {
        isLoading.call(false);
      },
          (value) async {
        productModel.call(value);
        isLoading.call(false);
      },
    );
  }

}