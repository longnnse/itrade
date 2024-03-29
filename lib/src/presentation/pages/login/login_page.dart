import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/login/login_controller.dart';
import 'package:i_trade/src/presentation/pages/login/widget/forget_password_page.dart';
import 'package:i_trade/src/presentation/pages/login/widget/register_page.dart';

import '../../../../core/initialize/theme.dart';


class LoginPage extends GetView<LoginController> {
  static const String routeName = '/LoginPage';
  final Widget? leading;
  const LoginPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  _buildHeader(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: kBackground,
                                width: 2.0
                            )
                        )
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          margin: const EdgeInsets.only(right: 10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: kDefaultGradient
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 30.0,
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: controller.emailController,
                            decoration: InputDecoration(
                                suffixIcon: null,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                                disabledBorder: InputBorder.none,
                                hintText: 'Email...',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: kTextColorGrey)),
                            onChanged: (value) {},
                            onFieldSubmitted: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildInput(context: context, isPassword: true),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  _buildButton(context)
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.17,
              left: MediaQuery.of(context).size.width * 0.5 - 70.0,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: 140.0,
                height: 140.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70.0),
                  color: kBackgroundBottomBar,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60.0),
                    boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25), spreadRadius: 2, offset: const Offset(0, 4))],
                  ),
                  child: const CircleAvatar(
                    radius: 60.0,
                    backgroundImage:
                    NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDK4gXyt3wzCyT9ekbDsR-thEKFtWuQoFraQ&usqp=CAU'),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ),
            Obx(() => controller.isLoading.value == true ?
              Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: kBackground.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
              )) : const SizedBox())
          ],
        ));
  }

  Widget _buildHeader(BuildContext context){
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
              gradient: kDefaultGradient
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ITrade',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
              ),
              Text(
                'Buy, sell and trade',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: kTextColor, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        // Positioned(
        //   top: MediaQuery.of(context).padding.top,
        //   child: IconButton(
        //     onPressed: () => Navigator.pop(context, true),
        //     icon: const Icon(
        //       Icons.arrow_back_ios,
        //       color: Colors.white,
        //     )
        //   ),
        // )
      ],
    );
  }

  Widget _buildInput({required BuildContext context, bool isPassword = false}){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: kBackground,
            width: 2.0
          )
        )
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.only(right: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: kDefaultGradient
            ),
            child: Icon(
              isPassword == true ? Icons.lock : Icons.person,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Expanded(
            child: Obx(() => TextFormField(
              //initialValue: number.toString(),
              obscureText: !controller.isShow.value,
              controller: isPassword == false ? controller.emailController : controller.passwordController,
              decoration: InputDecoration(
                  suffixIcon: isPassword == true ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                    child: GestureDetector(
                      onTap: () => controller.showPass(controller.isShow.value),
                      child: Icon(
                          controller.isShow.value == false ? Icons.visibility_off : Icons.visibility,
                          color: kPrimaryLightColor ,
                          size: 25.0
                      ),
                    ),
                  ) : null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: isPassword == true ? 15.0 : 10.0, bottom: isPassword == false ? 10.0 : 0.0),
                  disabledBorder: InputBorder.none,
                  hintText: isPassword == false ? 'Email...' : 'Password...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: kTextColorGrey)),
              onChanged: (value) {},
              onFieldSubmitted: (value) {},
            )),
          ),
        ],
      ),
    );
  }
  
  Widget _buildButton(BuildContext context){
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.postLogin(email: controller.emailController.text, password: controller.passwordController.text, context: context),
          child: Container(
            padding: const EdgeInsets.all(13.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: kDefaultGradient
            ),
            child: Text(
              'Đăng nhập',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5.0,),
        GestureDetector(
          onTap: () => Get.toNamed(RegisterPage.routeName),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Chưa có tài khoản?',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Đăng ký',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(height: 5.0,),
        GestureDetector(
          onTap: () => Get.toNamed(ForgetPasswordPage.routeName),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quên mật khẩu?',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Lấy lại',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
        )
      ],
    );
  }

}