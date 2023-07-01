import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';

import '../../../../core/initialize/theme.dart';

class UploadPostController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

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
  RxBool isSell = false.obs;
  final RxBool isLoading = false.obs;
  final UploadProductService _uploadProductService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> postUploadProduct({required BuildContext context}) async {
    //TODO use test
    bool isValid = true;
    if(priceController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập giá tiền', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(contentController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập nội dung', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    // if(addressController.text == ''){
    //   isValid = false;
    //   Get.snackbar('Thông báo', 'Vui lòng nhập địa chỉ', backgroundColor: kSecondaryRed, colorText: kTextColor);
    // }
    if(titleController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập tiêu đề', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }

    if(isValid == true){
      UploadProductParam param = UploadProductParam(
          title: titleController.text,
          content: contentController.text,
          categoryName: selectedValue.value,
          price: double.parse(priceController.text),
          isTrade: isSell.value == false ? true : false,
          isSell: isSell.value,
          isUsed: isNew.value,
          isFree: isFree.value,
          isProfessional: isPro.value,
          files: [],
      );
      isLoading.call(true);
      final Either<ErrorObject, UploadProductParam> res = await _uploadProductService.postUploadProduct(param: param);

      res.fold(
            (failure) {
          isLoading.call(false);
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        },
            (value) async {
          Get.snackbar('Thông báo', 'Đăng bài thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
          titleController.clear();
          contentController.clear();
          priceController.clear();
          addressController.clear();
          isLoading.call(false);
          Navigator.pop(context, true);
        },
      );
    }
  }

}