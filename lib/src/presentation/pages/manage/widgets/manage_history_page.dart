import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';


class ManageHistoryPage extends GetView<ManageController> {
  static const String routeName = '/ManageHistoryPage';
  final Widget? leading;
  const ManageHistoryPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Quản lý lịch sử',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildTab(context),
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
                    border: controller.isBuying.value == true ? const Border(
                        bottom: BorderSide(
                            color: kPrimaryLightColor,
                            width: 2.0
                        )
                    ) : null
                ),
                child: Text(
                  'Đã mua (0)',
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
                  border: controller.isBuying.value == false ? const Border(
                      bottom: BorderSide(
                          color: kPrimaryLightColor,
                          width: 2.0
                      )
                  ): null
              ),
              child: Text(
                'Đã bán (0)',
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
