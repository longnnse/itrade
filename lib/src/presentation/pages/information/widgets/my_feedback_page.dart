import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../information_controller.dart';


class MyFeedbackPage extends GetView<InformationController> {
  static const String routeName = '/MyFeedbackPage';
  final Widget? leading;
  const MyFeedbackPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: controller.title.value,
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTab(context),
              _buildItem(context)
            ],
          ),
        ));
  }

  Widget _buildTab(BuildContext context){
    return Obx(() => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => controller.updateStatus(true),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: controller.isBuyer.value == true ? const Border(
                        bottom: BorderSide(
                            color: kPrimaryLightColor,
                            width: 2.0
                        )
                    ) : null
                ),
                child: Text(
                  'Người bán (1)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => controller.updateStatus(false),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: controller.isBuyer.value == false ? const Border(
                      bottom: BorderSide(
                          color: kPrimaryLightColor,
                          width: 2.0
                      )
                  ): null
              ),
              child: Text(
                'Người mua (0)',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildItem(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25), spreadRadius: 2, offset: const Offset(0, 4))],
        color: kBackgroundBottomBar
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                width: 60.0,
                height: 60.0,
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
              const SizedBox(width: 10.0,),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Nguyễn Ngọc Long',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                          child: const Icon(
                              Icons.chat,
                              color: kPrimaryLightColor,
                              size: 30.0
                          ),
                        ),
                        const SizedBox(width: 5.0,),
                        Text(
                          '4 ngày trước',
                          style: Theme.of(context).textTheme.titleMedium,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.15,
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
                    const SizedBox(width: 10.0,),
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Cần bán Rick Owen',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              '9,500,000 VND',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 5.0,),
                            Text(
                              'Đã đăng 04:55 08/05/2023',
                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Đánh giá ngay',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey),
                    ),
                    const SizedBox(width: 10.0,),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        gradient: kDefaultGradient,
                      ),
                      child: Text(
                        'Đánh giá',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextFieldLightColor),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

}
