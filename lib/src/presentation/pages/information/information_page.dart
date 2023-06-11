import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/presentation/pages/change_password/change_password_page.dart';

import '../../../../core/initialize/theme.dart';
import '../login/login_page.dart';
import '../upload_post/upload_post_page.dart';
import 'information_controller.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/edit_profile_page.dart';

class InformationPage extends GetView<InformationController> {
  static const String routeName = '/InformationPage';
  final Widget? leading;
  const InformationPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundBottomBar,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.36,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: const BoxDecoration(
                                  gradient: kDefaultGradient
                              ),
                              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20.0, left: 20.0, right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nguyễn Ngọc Long',
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kTextFieldLightColor),
                                  ),
                                  const SizedBox(height: 5.0,),
                                  Text(
                                    'Trader nghiệp dư',
                                    style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kTextFieldLightColor),
                                  ),
                                  const SizedBox(height: 10.0,),
                                  Row(
                                    children: [
                                      _buildIconButton(context: context, iconData: Icons.edit, profileEnums: ProfileEnums.edit),
                                      _buildIconButton(context: context, iconData: Icons.camera_alt, profileEnums: ProfileEnums.camera),
                                      _buildIconButton(context: context, iconData: Icons.lock, profileEnums: ProfileEnums.lock),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
                              child: CustomPaint(
                                painter: TrianglePainter(
                                  strokeColor: kBackgroundBottomBar,
                                  strokeWidth: MediaQuery.of(context).size.width,
                                  paintingStyle: PaintingStyle.fill,
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.18,
                        left: 20.0,
                        right: 20.0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                    NetworkImage('https://kpopping.com/documents/1a/3/YongYong-fullBodyPicture.webp?v=7c2a3'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 30.0,),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.email,
                                        color: kTextColorGrey,
                                      ),
                                      const SizedBox(width: 5.0,),
                                      Text(
                                        'longnl@fpt.edu.vn',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  const SizedBox(height: 5.0,),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.phone,
                                        color: kTextColorGrey,
                                      ),
                                      const SizedBox(width: 5.0,),
                                      Text(
                                        '0123456789',
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.14,
                        right: 40.0,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          width: 90.0,
                          height: 90.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(90.0),
                            color: kBackgroundBottomBar,
                          ),
                          child: GestureDetector(
                            onTap: () => Get.toNamed(UploadPostPage.routeName),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                  gradient: kDefaultGradient
                              ),
                              child: const Icon(
                                Icons.upload,
                                size: 40.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  _buildButtonFunc(context: context, iconData: Icons.question_mark, title: 'Hướng dẫn sử dụng'),
                  _buildButtonFunc(context: context, iconData: Icons.menu_book, title: 'Điều khoản sử dụng'),
                  _buildButtonFunc(context: context, iconData: Icons.security, title: 'Chính sách bảo mật'),
                  _buildButtonFunc(context: context, iconData: Icons.info_outline, title: 'Thông tin ứng dụng'),
                  _buildButtonFunc(context: context, iconData: Icons.wallet, title: 'Ví của tôi'),
                  _buildButtonFunc(context: context, iconData: Icons.report_outlined, title: 'Báo cáo vi phạm'),
                  _buildButtonFunc(context: context, iconData: Icons.feedback_outlined, title: 'Đánh giá từ tôi'),
                  _buildButton(context),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Version: 1.0.0',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0)
              ),
              color: kBackground,
            ),

            height: 5.0,
          )
        ],
      ));
  }

  Widget _buildIconButton({required BuildContext context, required IconData iconData, required ProfileEnums profileEnums}){
    return GestureDetector(
      onTap: () {
        switch (profileEnums){
          case ProfileEnums.edit:
            Get.toNamed(EditProfilePage.routeName);
            break;
          case ProfileEnums.camera:
            Get.toNamed(EditProfilePage.routeName);
            break;
          case ProfileEnums.lock:
            Get.toNamed(ChangePasswordPage.routeName);
            break;
        }
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: kCardLightColor,
        ),
        margin: const EdgeInsets.only(right: 10.0),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
          child: Icon(
            iconData,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonFunc({required BuildContext context, required IconData iconData, required String title}){
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: kDefaultGradient
                ),
                child: Icon(
                    iconData,
                    color: Colors.white,
                    size: 20.0
                ),
              ),
              const SizedBox(width: 10.0,),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
            child: const Icon(
                Icons.arrow_forward_ios,
                color: kPrimaryLightColor,
                size: 25.0
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context){
    return GestureDetector(
      onTap: () => Get.toNamed(LoginPage.routeName),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: kDefaultGradient
        ),
        child: Text(
          'Đăng xuất',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kTextColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter({required this.strokeColor,required this.strokeWidth, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y )
      ..lineTo(y / y - 100, y)
      ..lineTo(x, y)
      ..lineTo(x, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}