import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/theme.dart';
import 'package:i_trade/src/domain/models/category_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';
import 'package:i_trade/src/domain/services/home_service.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/trade_product_page.dart';

import '../../../domain/models/product_model.dart';
import '../../../infrastructure/repositories/home_repository.dart';
import 'widgets/product_detail.dart';

class HomeController extends GetxController{
  RxString title = ''.obs;
  RxString idPost = ''.obs;
  RxBool isMore = false.obs;
  RxInt countImage = 0.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingRequest = false.obs;
  final RxBool isLoadingProduct = false.obs;
  final RxBool isLoadingData = false.obs;
  final HomeService _homeService = Get.find();
  final Rxn<List<CategoryModel>> categoryList = Rxn<List<CategoryModel>>();
  final Rxn<ProductModel> productModel = Rxn<ProductModel>();
  final Rxn<SellFreeResultModel> sellFreeResultModel = Rxn<SellFreeResultModel>();
  final Rxn<Data> productByIDModel = Rxn<Data>();

  TextEditingController descControler = TextEditingController();
  void dependencies() {
    Get.put(HomeController);
  }
  @override
  void onInit() {
    super.onInit();
  }

  void nextImage(int count){
    countImage.call(count);
  }

  void goDetail({required String id}){
    idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  void funcButton(String contentFunc, String postID, BuildContext context){
    switch (contentFunc){
      case 'Trade':
        Get.put(ManageController());
        final ManageController manageController = Get.find();
        manageController.ownerPostID.call(postID);
        Get.toNamed(TradeProductPage.routeName);
        break;
      case 'Sell':
        _showMyDialog(context, postID, 'Yêu cầu mua sản phẩm');
        break;
      case 'Free':
        _showMyDialog(context, postID, 'Yêu cầu miễn phí sản phẩm');
        break;
    }
  }

  Future<void> _showMyDialog(BuildContext context, String postID, String content) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(content, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Nhập nội dung(Nếu cần)', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500)),
                Container(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
                  ),
                  child: TextFormField(
                    //initialValue: number.toString(),
                    controller: descControler,
                    maxLines: 5,
                    decoration: InputDecoration(
                        suffixIcon: null,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        disabledBorder: InputBorder.none,
                        hintText: 'Nhập nội dung...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: kTextColorGrey)),
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Đồng ý', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, color: kSecondaryGreen),),
              onPressed: () {
                Navigator.pop(context);
                postSellFree(postID: postID, desc: descControler.text);
                descControler.clear();
              },
            ),
            TextButton(
              child: Text('Hủy', style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, color: kSecondaryRed),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Future<void> postSellFree({required String postID, required String desc}) async {
    //TODO use test
    isLoadingRequest.call(true);
    final Either<ErrorObject, SellFreeResultModel> res = await _homeService.postSellFree(postID: postID, desc: desc);

    res.fold(
          (failure) {
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        isLoadingRequest.call(false);
      },
          (value) async {
        Get.snackbar('Thông báo', 'Gửi yêu cầu thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        sellFreeResultModel.call(value);
        isLoadingRequest.call(false);
      },
    );
  }

  Future<void> getCategories({required int pageIndex,required int pageSize}) async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, List<CategoryModel>> res = await _homeService.getCategories(pageSize: pageSize, pageIndex: pageIndex);

    res.fold(
          (failure) {
        isLoading.call(false);
      },
          (value) async {
        categoryList.call(value);
        isLoading.call(false);
      },
    );
  }
  Future<void> getPosts({required int pageIndex,required int pageSize}) async {
    //TODO use test
    isLoadingProduct.call(true);
    final Either<ErrorObject, ProductModel> res = await _homeService.getPosts(pageSize: pageSize, pageIndex: pageIndex);

    res.fold(
          (failure) {
          isLoadingProduct.call(false);
      },
          (value) async {
        productModel.call(value);
        isLoadingProduct.call(false);
      },
    );
  }

  Future<void> getPostByID({required String id}) async {
    //TODO use test
    isLoadingData.call(true);
    final Either<ErrorObject, Data> res = await _homeService.getPostByID(id: id);

    res.fold(
          (failure) {
        isLoadingData.call(false);
      },
          (value) async {
        productByIDModel.call(value);
        isLoadingData.call(false);
      },
    );
  }

}