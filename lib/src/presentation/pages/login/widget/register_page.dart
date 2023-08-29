import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/login/login_controller.dart';

import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';


class RegisterPage extends GetView<LoginController> {
  static const String routeName = '/RegisterPage';
  final Widget? leading;
  const RegisterPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Đăng ký',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Container(
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
                  const SizedBox(height: 10.0),
                  _buildInput(context: context, title: 'Username', iconData: Icons.person, textController: controller.usernameController),
                  _buildInput(context: context, title: 'Họ', iconData: Icons.person, textController: controller.firstNameController),
                  _buildInput(context: context, title: 'Tên', iconData: Icons.person, textController: controller.lastNameController),
                  _buildInput(context: context, title: 'Tuổi', iconData: Icons.calendar_month, textController: controller.ageController),
                  _buildInput(context: context, title: 'Email', iconData: Icons.mail, textController: controller.emailController),
                  _buildInput(context: context, title: 'Số điện thoại', iconData: Icons.phone, textController: controller.phoneController),
                  _buildInput(context: context, title: 'Địa chỉ', iconData: Icons.location_on, textController: controller.addressController),
                  _buildInput(context: context, title: 'CMND/CCCD', iconData: Icons.contact_mail, textController: controller.idenficationNumberController),
                  _buildInput(context: context, isPassword: true, title: 'Password', iconData: Icons.lock, textController: controller.passwordController),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  _buildButton(context)
                ],
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

  Widget _buildInput({
    required BuildContext context,
    bool isPassword = false,
    required String title,
    required IconData iconData,
    required TextEditingController textController
  }){
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
              iconData,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          Expanded(
            child: TextFormField(
              //initialValue: number.toString(),
              controller: textController,
              decoration: InputDecoration(
                  suffixIcon: isPassword == true ? ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                    child: const Icon(
                        Icons.visibility,
                        color: kPrimaryLightColor ,
                        size: 25.0
                    ),
                  ) : null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: isPassword == true ? 15.0 : 10.0, bottom: isPassword == false ? 10.0 : 0.0),
                  disabledBorder: InputBorder.none,
                  hintText: '$title...',
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
    );
  }
  
  Widget _buildButton(BuildContext context){
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.postRegister(context: context),
          child: Container(
            padding: const EdgeInsets.all(13.0),
            margin: const EdgeInsets.only(left: 10.0, right: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: kDefaultGradient
            ),
            child: Text(
              'Đăng ký',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 5.0,),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Đã có tài khoản?',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Đăng nhập',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
        const SizedBox(height: 20.0,),
      ],
    );
  }

}