import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../../domain/models/product_model.dart';
import '../../../widgets/appbar_customize.dart';
import '../../upload_post/upload_post_page.dart';
import 'manage_product_shimmer_widget.dart';

class TradeCartProductPage extends GetView<ManageController> {
  static const String routeName = '/TradeCartProductPage';
  final Widget? leading;
  const TradeCartProductPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
            context: context,
            title: 'Danh sách sản phẩm muốn trao đổi',
            isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10.0,),
                  Obx(() {
                    if (controller.selectedProductList.isNotEmpty) {
                      return Column(
                        children: [
                          for(var cont in controller.selectedProductList)
                            _buildItem(context: context, model: cont),
                          const SizedBox(height: 50.0,),
                          _buildButtonTrade(context)
                        ],
                      );
                    }else {
                      return Center(
                          child: Text(
                            'Không có dữ liệu',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                          )
                      );
                    }
                  })
                ],
              ),
            ),
            Obx(() => controller.isLoadingGroup.value == true ?
            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: kBackground.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )) : const SizedBox())
          ],
        )
    );
  }
  Widget _buildButtonTrade(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => controller.tradeGroup(context),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: kDefaultGradient
              ),
              child: Text(
                'Trao đổi',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
  

  Widget _buildItem({required BuildContext context, required Data model}){
    return GestureDetector(
      onTap: (){},
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: kBackgroundBottomBar,
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: kBackground
                        ),
                        child: model.resources.isNotEmpty ? Image.network(
                            CoreUrl.baseImageURL + model.resources[0].id + model.resources[0].extension,
                            fit: BoxFit.contain
                        ) : const SizedBox(),
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
                                        model.resources.length.toString(),
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
                      //height: MediaQuery.of(context).size.width * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  model.title,
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  controller.selectedProductIDs.removeWhere( (item) => item == model.id);
                                  controller.selectedProductList.removeWhere( (item) => item.id == model.id);
                                  Get.snackbar('Thông báo', 'Xóa thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: kSecondaryRed,
                                  size: 30.0,
                                )
                              )

                            ],
                          ),
                          const SizedBox(height: 5.0,),
                          Text(
                            '${model.price.toString().split('.').first} đ',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 5.0,),
                          Text(
                            'Đã đăng ${FormatDateTime.getHourFormat(model.dateUpdated)} ${FormatDateTime.getDateFormat(model.dateUpdated)}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: kBackground
                ),
                color: kBackgroundBottomBar,
                boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
              ),
            ),

          ],
        ),
      ),
    );
  }

}