import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/category_model.dart';
import 'package:i_trade/src/domain/services/home_service.dart';

import '../../../domain/models/product_model.dart';
import '../../../infrastructure/repositories/home_repository.dart';
import 'widgets/product_detail.dart';

class HomeController extends GetxController{
  RxString title = ''.obs;
  RxString idPost = ''.obs;
  RxBool isMore = false.obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingProduct = false.obs;
  final RxBool isLoadingData = false.obs;
  final HomeService _homeService = Get.find();
  final Rxn<List<CategoryModel>> categoryList = Rxn<List<CategoryModel>>();
  final Rxn<ProductModel> productModel = Rxn<ProductModel>();
  final Rxn<Data> productByIDModel = Rxn<Data>();
  void dependencies() {
    Get.put(HomeController);
  }
  @override
  void onInit() {
    super.onInit();
  }

  void goDetail({required String id}){
    idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
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