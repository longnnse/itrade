import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/params/edit_password_param.dart';
import 'package:i_trade/src/domain/services/login_service.dart';

import '../../../../core/initialize/theme.dart';

class EditProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reNewPasswordController = TextEditingController();
  final LoginService _loginService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> postEditPassword({required BuildContext context}) async {
    //TODO use test

    bool isValid = true;
    if(emailController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập email', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(currentPasswordController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập mật khẩu hiện tại', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(newPasswordController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập mật khẩu mới', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(reNewPasswordController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập re-mật khẩu mới', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(reNewPasswordController.text != newPasswordController.text){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập re-mật khẩu mới trùng khớp với mật khẩu mới', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }

    if(isValid == true){
      EditPasswordParam param = EditPasswordParam(
          email: emailController.text,
          currentPassword: currentPasswordController.text,
          newPassword: newPasswordController.text,
      );
      isLoading.call(true);
      final Either<ErrorObject, String> res = await _loginService.postEditPassword(param: param);

      res.fold(
            (failure) {
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
          isLoading.call(false);
        },
            (value) async {
          Get.snackbar('Thông báo', 'Đổi mật khẩu thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
          isLoading.call(false);
          Navigator.pop(context);
        },
      );
    }

  }


}