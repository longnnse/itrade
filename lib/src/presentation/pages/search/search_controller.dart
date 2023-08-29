import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/infrastructure/repositories/home_repository.dart';
import 'package:intl/intl.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/models/category_model.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/services/home_service.dart';
import '../home/home_controller.dart';
import '../home/widgets/product_detail.dart';

class SearchControllerCustom extends GetxController {
  Rx<RangeValues> currentRangeValues = const RangeValues(0, 30000000).obs;
  var formatNum = NumberFormat.simpleCurrency(locale: 'vi-VN', decimalDigits: 0);
  final RxBool isLoading = false.obs;
  final RxBool isLoadingFilter = false.obs;
  final HomeService _homeService = Get.find();
  final Rxn<ProductModel> productModel = Rxn<ProductModel>();
  final Rxn<List<CategoryModel>> categoryList = Rxn<List<CategoryModel>>();
  RxString cateName = ''.obs;
  RxString cateID = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> refreshPage() async {
    getPosts(pageIndex: 1, pageSize: 50, categoryIds: '');
    getCategories(pageIndex: 1, pageSize: 10);
  }

  void goDetail({required String id}){
    final HomeController homeController = Get.find();
    homeController.idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  Future<void> showSelectDanhMuc(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Danh sách danh mục', style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                for(var cont in categoryList.value!)...[
                  GestureDetector(
                    onTap: () {
                      cateName.call(cont.name);
                      cateID.call(cont.id);
                      Navigator.pop(context);
                      getPosts(pageIndex: 1, pageSize: 20, categoryIds: cont.id);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: cateID.value == cont.id ? kPrimaryLightColor : Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
                      ),
                      child: Text(
                        cont.name,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: cateID.value == cont.id ? Colors.white : Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> getCategories({required int pageIndex,required int pageSize}) async {
    //TODO use test
    isLoadingFilter.call(true);
    final Either<ErrorObject, List<CategoryModel>> res = await _homeService.getCategories(pageSize: pageSize, pageIndex: pageIndex);

    res.fold(
          (failure) {
            isLoadingFilter.call(false);
      },
          (value) async {
        categoryList.call(value);
        isLoadingFilter.call(false);
      },
    );
  }

  Future<void> getPosts({required int pageIndex,required int pageSize, required String categoryIds, String searchValue = ''}) async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, ProductModel> res = await _homeService.getPosts(pageSize: pageSize, pageIndex: pageIndex, categoryIds: categoryIds, searchValue: searchValue);

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