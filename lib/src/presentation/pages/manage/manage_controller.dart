import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/trade_model.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_trade_page.dart';

import '../../../../core/initialize/theme.dart';
import '../home/home_controller.dart';
import '../home/widgets/product_detail.dart';

class ManageController extends GetxController {
  RxBool isBuying = true.obs;
  final ManageService _manageService = Get.find();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingTrade = false.obs;
  final RxBool isLoadingConfirmTrade = false.obs;
  final Rxn<List<Data>> productList = Rxn<List<Data>>();
  final Rxn<TradeModel> tradeList = Rxn<TradeModel>();
  final RxString productID = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void goDetail({required String id}){
    final HomeController homeController = Get.find();
    homeController.idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  void updateStatus(bool isChange){
    isBuying.call(isChange == true ? true : false);
  }

  void goTradePage(String id){
    productID.call(id);
    Get.toNamed(ManageTradePage.routeName);
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

  Future<void> getTradePosts({required int pageIndex,required int pageSize, required String fromPostID, required String toPostID}) async {
    //TODO use test
    isLoadingTrade.call(true);
    final Either<ErrorObject, TradeModel> res = await _manageService.getTradePosts(pageIndex: pageIndex, pageSize: pageSize, fromPostID: fromPostID, toPostID: toPostID);

    res.fold(
          (failure) {
            isLoadingTrade.call(false);
      },
          (value) async {
            tradeList.call(value);
            isLoadingTrade.call(false);
      },
    );
  }

  Future<void> postAcceptTrade({required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, DataTrade> res = await _manageService.postAcceptTrade(tradeID: tradeID);

    res.fold(
          (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
          (value) async {

        Get.snackbar('Thông báo', 'Trao đổi thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }

  Future<void> postDenyTrade({required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, DataTrade> res = await _manageService.postDenyTrade(tradeID: tradeID);

    res.fold(
          (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
          (value) async {

        Get.snackbar('Thông báo', 'Từ chối trao đổi thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }


}