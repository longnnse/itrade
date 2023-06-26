import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/user_entity.dart';
import 'package:i_trade/src/domain/services/login_service.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_page.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/models/login_model.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
          await AppSettings.saveSharePrefByUser(userEntity.value!);
          isLoading.call(false);
          Navigator.pop(context, true);
        },
    );
  }

  void toastMessage({required String message, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: kSecondaryRed,
      duration: const Duration(seconds: 2),
    ));
  }
}