import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/user_entity.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';
import 'package:i_trade/src/domain/services/login_service.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_page.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/models/login_model.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController idenficationNumberController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  final Rxn<LoginModel> loginModel =
       Rxn<LoginModel>();
  final Rxn<UserEntity> userEntity =
  Rxn<UserEntity>();
  final RxBool isLoading = false.obs;
  final LoginService _loginService = Get.find();
  final RxBool isShow = false.obs;
  void onInit() {
    super.onInit();
  }

  void showPass(bool isShowPass){
    isShow.call(isShowPass == false ? true : false);
  }
  Future<void> postLogin({required String email, required String password, required BuildContext context}) async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, LoginModel> res = await _loginService.postLogin(email: email, password: password);

    res.fold(
        (failure) {
          isLoading.call(false);
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        },
        (value) async {
          loginModel.call(value);
          Get.snackbar('Thông báo', 'Đăng nhập thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
          emailController.clear();
          passwordController.clear();
          userEntity.call(UserEntity.fromJson(Jwt.parseJwt(loginModel.value!.accessToken)));
          print(Jwt.parseJwt(loginModel.value!.accessToken));
          print('zxvzxv');
          await AppSettings.saveSharePrefByUser(userEntity.value!, loginModel.value!.accessToken);
          isLoading.call(false);
          Get.toNamed(DashboardPage.routeName);
        },
    );
  }



  Future<void> postRegister({required BuildContext context}) async {
    //TODO use test
    bool isValid = true;
    if(usernameController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập username', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(passwordController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập password', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(usernameController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập username', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(emailController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập email', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(firstNameController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập họ', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(lastNameController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập tên', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(addressController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập địa chỉ', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(phoneController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập số điện thoại', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(ageController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập tuổi', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }

    if(isValid == true){
      RegisterAccountParam param = RegisterAccountParam(
          userName: usernameController.text,
          password: passwordController.text,
          email: emailController.text,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          address: addressController.text,
          phoneNumber: phoneController.text,
          age: ageController.text,
          idenficationNumber: idenficationNumberController.text
      );
      isLoading.call(true);
      final Either<ErrorObject, RegisterAccountParam> res = await _loginService.postRegister(param: param);

      res.fold(
            (failure) {
          isLoading.call(false);
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        },
            (value) async {
          Get.snackbar('Thông báo', 'Đăng ký thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
          usernameController.clear();
          passwordController.clear();
          emailController.clear();
          phoneController.clear();
          addressController.clear();
          idenficationNumberController.clear();
          firstNameController.clear();
          lastNameController.clear();
          ageController.clear();
          isLoading.call(false);
          Navigator.pop(context, true);
        },
      );
    }
  }

  void toastMessage({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: kSecondaryRed,
      duration: const Duration(seconds: 2),
    ));
  }
}