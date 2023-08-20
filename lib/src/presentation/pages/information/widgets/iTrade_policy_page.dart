import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../information_controller.dart';


class ITradePolicyPage extends GetView<InformationController> {
  static const String routeName = '/ITradePolicyPage';
  final Widget? leading;
  const ITradePolicyPage({
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
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  width: Get.width/3,
                  child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDK4gXyt3wzCyT9ekbDsR-thEKFtWuQoFraQ&usqp=CAU',
                      fit: BoxFit.cover
                  ),
                ),
                const SizedBox(height: 10.0,),
                Text(
                  controller.title.value,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 30.0,),
                Text(
                  controller.desc.value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ));
  }
}
