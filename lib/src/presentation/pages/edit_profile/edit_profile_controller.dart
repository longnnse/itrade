import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/models/params/edit_password_param.dart';
import 'package:i_trade/src/domain/models/update_user_result_model.dart';
import 'package:i_trade/src/domain/services/login_service.dart';

import '../../../../core/initialize/theme.dart';

class EditProfileController extends GetxController {
  final RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController reNewPasswordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController idenficationNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final RxBool isLoadingUpdate = false.obs;
  final LoginService _loginService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> putProduct({required BuildContext context}) async {
    isLoadingUpdate.call(true);
    final Either<ErrorObject, UpdateUserResultModel> res = await _loginService.putUser(
      id: AppSettings.getValue(KeyAppSetting.userId),
      firstName: '${firstNameController.text != '' ? firstNameController.text : AppSettings.getValue(KeyAppSetting.fullName).split(' ').first} ',
      lastName: '${lastNameController.text != '' ? lastNameController.text : AppSettings.getValue(KeyAppSetting.fullName).split(' ').first} ',
      address: addressController.text,
      phoneNumber: phoneController.text != '' ? phoneController.text : AppSettings.getValue(KeyAppSetting.phoneNumber),
      age: '22',
    );

    res.fold(
          (failure) {
        isLoadingUpdate.call(false);
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
          (value) async {
        Get.snackbar('Thông báo', 'Chỉnh sửa thông tin thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        if(firstNameController.text != '' || lastNameController.text != ''){
          AppSettings.setValue(KeyAppSetting.fullName, '${firstNameController.text} ${lastNameController.text}');
        }

        if(phoneController.text != ''){
          AppSettings.setValue(KeyAppSetting.phoneNumber, phoneController.text);
        }

        firstNameController.clear();
        lastNameController.clear();
        phoneController.clear();
        addressController.clear();
        isLoadingUpdate.call(false);

        Navigator.pop(context, true);
      },
    );
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