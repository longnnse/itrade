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
              _buildTab(context)
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

}
