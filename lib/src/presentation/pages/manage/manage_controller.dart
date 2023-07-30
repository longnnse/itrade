import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/request_post_result_model.dart';
import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/trade_model.dart';
import 'package:i_trade/src/domain/models/trade_result_model.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_trade_page.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_controller.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/services/upload_product_service.dart';
import '../../../infrastructure/repositories/upload_product_repository.dart';
import '../home/home_controller.dart';
import '../home/widgets/product_detail.dart';
import '../upload_post/upload_post_page.dart';

class ManageController extends GetxController {
  RxBool isisTradePost = true.obs;
  final ManageService _manageService = Get.find();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingTrade = false.obs;
  final RxBool isLoadingConfirmTrade = false.obs;
  final RxBool isLoadingRequestTrade = false.obs;
  final RxBool isLoadingTradingReceived = false.obs;
  final RxBool isLoadingRequestReceived = false.obs;
  final Rxn<List<Data>> productList = Rxn<List<Data>>();
  final Rxn<TradeModel> tradeList = Rxn<TradeModel>();
  final Rxn<TradeResultModel> tradeResult = Rxn<TradeResultModel>();
  final Rxn<List<RequestResultModel>> requestLst = Rxn<List<RequestResultModel>>();
  final Rxn<List<DataTrade>> tradingReceivedLst = Rxn<List<DataTrade>>();
  final Rxn<RequestPostResultModel> requestReceivedLst = Rxn<RequestPostResultModel>();
  final RxString idFromPost = ''.obs;
  final RxString productID = ''.obs;
  final RxString ownerPostID = ''.obs;
  final RxBool isTrade = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void goGoCreatePost() async {
    Get.put<UploadProductService>(UploadProdcutRepositories());
    Get.put(UploadPostController());
    final UploadPostController uploadPostController = Get.find();
    uploadPostController.isPostToTrade.call(true);
    uploadPostController.toPostID.call(ownerPostID.value);
    var result = await Get.toNamed(UploadPostPage.routeName);
    if(result == true){
      getPersonalPosts();
    }
  }

  void goDetail({required String id}){
    final HomeController homeController = Get.find();
    homeController.idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  void updateStatus(bool isChange){
    isisTradePost.call(isChange == true ? true : false);
    if(isisTradePost.value == true){
      getTradingReceived();
    }else{
      getRequestReceived();
    }
  }

  void goTradePage(String id, bool isTradeVal){
    productID.call(id);
    isTrade.call(isTradeVal);
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

  Future<void> getTradingReceived() async {
    //TODO use test
    isLoadingTradingReceived.call(true);
    final Either<ErrorObject, List<DataTrade>> res = await _manageService.getTradingReceived();

    res.fold(
          (failure) {
        isLoadingTradingReceived.call(false);
      },
          (value) async {
        tradingReceivedLst.call(value);
        isLoadingTradingReceived.call(false);
      },
    );
  }

  Future<void> getRequestReceived() async {
    //TODO use test
    isLoadingRequestReceived.call(true);
    final Either<ErrorObject, RequestPostResultModel> res = await _manageService.getRequestReceived();

    res.fold(
          (failure) {
            isLoadingRequestReceived.call(false);
      },
          (value) async {
        requestReceivedLst.call(value);
        isLoadingRequestReceived.call(false);
      },
    );
  }

  Future<void> postTrading({required String fromPostId, required String toPostId}) async {
    //TODO use test
    isLoadingRequestTrade.call(true);
    final Either<ErrorObject, TradeResultModel> res = await _manageService.postTrading(fromPostId: fromPostId, toPostId: toPostId);

    res.fold(
          (failure) {
            Get.snackbar('Thông báo', 'Không thể trao đổi', backgroundColor: kSecondaryRed, colorText: kTextColor);
            isLoadingRequestTrade.call(false);
      },
          (value) async {
        Get.snackbar('Thông báo', 'Trao đổi thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        tradeResult.call(value);
        idFromPost.call(value.fromPostId);
        isLoadingRequestTrade.call(false);
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

  Future<void> getRequestByID({required String postID}) async {
    //TODO use test
    isLoadingTrade.call(true);
    final Either<ErrorObject, List<RequestResultModel>> res = await _manageService.getRequestByID(postID: postID);

    res.fold(
          (failure) {
        isLoadingTrade.call(false);
      },
          (value) async {
        requestLst.call(value);
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

  Future<void> postAcceptRequest({required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, RequestResultModel> res = await _manageService.postAcceptRequest(tradeID: tradeID);

    res.fold(
          (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
          (value) async {

        Get.snackbar('Thông báo', 'Yêu cầu mua/miễn phí thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }

  Future<void> postDenyRequest({required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, RequestResultModel> res = await _manageService.postDenyReques(tradeID: tradeID);

    res.fold(
          (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
          (value) async {

        Get.snackbar('Thông báo', 'Từ chối mua/miễn phí thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }

}