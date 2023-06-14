import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/edit_profile_page.dart';
import 'package:i_trade/src/presentation/pages/information/information_controller.dart';

import '../../../../../core/initialize/theme.dart';
import '../../../../domain/enums/enums.dart';
import '../../../widgets/appbar_customize.dart';
import '../../home/widgets/product_detail.dart';


class MyProfilePage extends GetView<InformationController> {
  static const String routeName = '/MyProfilePage';
  final Widget? leading;
  const MyProfilePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Thông tin của tôi',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackground,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  _buildHeader(context),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: 15.0,
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
                          NetworkImage('https://kpopping.com/documents/1a/3/YongYong-fullBodyPicture.webp?v=7c2a3'),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.125,
                    right: 10.0,
                    child: GestureDetector(
                      onTap: () => Get.toNamed(EditProfilePage.routeName),
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: kPrimaryLightColor,
                                width: 2.0
                            ),
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Text(
                          'Chỉnh sửa thông tin',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.01,
                    right: 10.0,
                    child:  _buildIconButton(context: context, iconData: Icons.camera_alt, profileEnums: ProfileEnums.camera),
                  )
                ],
              ),
              _buildTab(context)
            ],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context){
    return Container(
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Container(
            color: kBackground,
            height: MediaQuery.of(context).size.height * 0.12,
          ),
          const SizedBox(height: 70.0,),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Nguyễn Ngọc Long',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Chưa có đánh giá',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.location_on,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      'Vinhome Grand Park, S201',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.access_time,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      'Đã tham gia: 27/05/2023',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(height: 5.0,),
                Obx(() => GestureDetector(
                  onTap: () => controller.isMore.call(controller.isMore.value == false ? true : false),
                  child: Text(
                    controller.isMore.value == false ? 'Xem thêm...' : 'Thu gọn...',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                  ),
                ))

              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTab(BuildContext context){
    return Obx(() => Container(
      margin: const EdgeInsets.only(top: 10.0),
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.updateStatusProfileTab(true),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: controller.isShow.value == true ? const Border(
                            bottom: BorderSide(
                                color: kPrimaryLightColor,
                                width: 2.0
                            )
                        ) : null
                    ),
                    child: Text(
                      'Đang hiển thị (2)',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.updateStatusProfileTab(false),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: controller.isShow.value == false ? const Border(
                          bottom: BorderSide(
                              color: kPrimaryLightColor,
                              width: 2.0
                          )
                      ): null
                  ),
                  child: Text(
                    'Đã bán/Đấu giá (0)',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0,),
          _buildItemGridView(context: context)
        ],
      ),
    ));
  }

  Widget _buildItemGridView({required BuildContext context}){
    return GridView.count(
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        for(int i = 0; i < 2; i++)
          GestureDetector(
            onTap: () => Get.toNamed(ProductDetailPage.routeName),
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.width * 0.25,
                        margin: const EdgeInsets.only(bottom: 5.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kBackground
                        ),
                      ),
                      Positioned(
                          right: 10.0,
                          top: 10.0,
                          child: Stack(
                            children: [
                              const Icon(
                                Icons.camera_alt,
                                size: 30.0,
                                color: Colors.grey,
                              ),
                              Positioned(
                                child: SizedBox(
                                  width: 30.0,
                                  height: 30.0,
                                  child: Center(
                                    child: Container(
                                      width: 15.0,
                                      height: 15.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                      ),
                                      child: Text(
                                        '6',
                                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w900),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      'Cần bán Rick Owen',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      '9,500,000 VND',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                          child: const Icon(
                              Icons.person,
                              color: kPrimaryLightColor,
                              size: 15.0
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '2 giờ trước - Tp.Hồ Chí Minh',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildIconButton({required BuildContext context, required IconData iconData, required ProfileEnums profileEnums}){
    return GestureDetector(
      onTap: () => controller.goProfle(profileEnums),
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

}