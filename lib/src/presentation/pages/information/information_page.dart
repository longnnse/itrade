
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_profile_page.dart';

import '../../../../core/initialize/theme.dart';
import 'information_controller.dart';

class InformationPage extends GetView<InformationController> {
  static const String routeName = '/InformationPage';
  final Widget? leading;
  const InformationPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(InformationController());
    controller.checkInfoUser();
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
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.3,
                              decoration: const BoxDecoration(
                                  gradient: kDefaultGradient
                              ),
                              padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + 20.0, left: 20.0, right: 10.0),
                              child: Obx(() => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.fullName.value,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kTextFieldLightColor),
                                  ),
                                  const SizedBox(height: 5.0,),
                                  Text(
                                      controller.aud.value,
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
                              )),
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
                        top: MediaQuery.of(context).size.height * 0.2,
                        left: 20.0,
                        right: 20.0,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(MyProfilePage.routeName),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Obx(() {
                                  if(controller.isLoadingUpdateAva.value == true){
                                    return CircularProgressIndicator();
                                  }else{
                                    return Container(
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
                                        child: CircleAvatar(
                                          radius: 60.0,
                                          backgroundImage:
                                          NetworkImage(AppSettings.getValue(KeyAppSetting.userAva)),
                                          backgroundColor: Colors.transparent,
                                        ),
                                      ),
                                    );
                                  }
                                }),
                                Obx(() => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30.0,),
                                    if(controller.email.value != '')
                                      SizedBox(
                                        width: Get.width * 0.5,
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.email,
                                              color: kTextColorGrey,
                                            ),
                                            const SizedBox(width: 5.0,),
                                            Expanded(
                                              child: Text(
                                                controller.email.value,
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    const SizedBox(height: 5.0,),
                                    if(controller.phoneNumber.value != '')
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: kTextColorGrey,
                                          ),
                                          const SizedBox(width: 5.0,),
                                          Text(
                                            controller.phoneNumber.value,
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      )
                                  ],
                                ))
                              ],
                            ),
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
                            onTap: () => controller.goPostProduct(),
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
                  // _buildButtonFunc(context: context, iconData: Icons.report_outlined, title: 'Báo cáo vi phạm', iTradePolicy: ITradePolicy.baoCaoViPham),
                  _buildButtonFunc(context: context, iconData: Icons.feedback_outlined, title: 'Đánh giá từ tôi', iTradePolicy: ITradePolicy.danhGiaTuToi),
                  // _buildButtonFunc(context: context, iconData: Icons.wallet, title: 'Ví của tôi', iTradePolicy: ITradePolicy.viCuaToi),
                  _buildButtonFunc(context: context, iconData: Icons.question_mark, title: 'Hướng dẫn sử dụng', iTradePolicy: ITradePolicy.huongDanSuDung),
                  _buildButtonFunc(context: context, iconData: Icons.menu_book, title: 'Điều khoản sử dụng', iTradePolicy: ITradePolicy.dieuKhoanSuDung),
                  _buildButtonFunc(context: context, iconData: Icons.security, title: 'Chính sách bảo mật', iTradePolicy: ITradePolicy.chinhSachBaoMat),
                  _buildButtonFunc(context: context, iconData: Icons.info_outline, title: 'Thông tin ứng dụng', iTradePolicy: ITradePolicy.thongTinUngDung),
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
      onTap: () => controller.goProfle(profileEnums, context),
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

  Widget _buildButtonFunc({required BuildContext context, required IconData iconData, required String title, required ITradePolicy iTradePolicy}){
    return GestureDetector(
      onTap: () {
        controller.updateTitle(iTradePolicy);
      },
      child: Container(
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
      ),
    );
  }

  Widget _buildButton(BuildContext context){
    return Obx(() => GestureDetector(
      onTap: () => controller.onButtonClick(),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        margin: const EdgeInsets.only(top: 20.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: kDefaultGradient
        ),
        child: Text(
          controller.buttonTxt.value,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: kTextColor),
        textAlign: TextAlign.center,
      ),
     ),
    ));
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