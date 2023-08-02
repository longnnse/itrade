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

class TradeProductPage extends GetView<ManageController> {
  static const String routeName = '/TradeProductPage';
  final Widget? leading;
  const TradeProductPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getPersonalPosts();
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
            context: context,
            title: 'Danh sách sản phẩm trao đổi',
            isUseOnlyBack: true,
            actionRights: [
              IconButton(
                  onPressed: () => controller.goGoCreatePost(),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25.0,
                  )
              )
            ]
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildSearch(context: context),
                  const SizedBox(height: 10.0,),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const ManageProductShimmerWidget(
                        columnCount: 1,
                      );
                    }
                    if(controller.productList.value!.isNotEmpty) {
                      return Column(
                        children: [
                          for(var cont in controller.productList.value!)
                            _buildItem(context: context, model: cont)
                        ],
                      );
                    } else {
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
            Obx(() => controller.isLoadingRequestTrade.value == true ?
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

  Widget _buildSearch({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBackgroundTextField,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: TextFormField(
        //initialValue: number.toString(),
        //controller: blocQLDTTNMT.keySearchTextEditingController,
        decoration: InputDecoration(
            suffixIcon: const Icon(
                Icons.search
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
            disabledBorder: InputBorder.none,
            hintText: 'Nhập sản phẩm cần tìm...',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kTextColorGrey)),
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
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
                              if(model.requestTradeCount == 0)...[
                                Obx(() => GestureDetector(
                                  onTap: () => controller.idFromPost.value == model.id ? null : controller.postTrading(fromPostId: model.id, toPostId: controller.ownerPostID.value),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 10.0),
                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: controller.idFromPost.value == model.id ? kBackground : kPrimaryLightColor,
                                            width: 2.0
                                        ),
                                        borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Text(
                                      controller.idFromPost.value == model.id ? 'Đã yêu cầu' : 'Trao đổi',
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          color: controller.idFromPost.value == model.id ? kBackground : kPrimaryLightColor,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )),
                              ],
                              if(model.requestTradeCount == 1)...[
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0,),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: controller.idFromPost.value == model.id ? kBackground : kPrimaryLightColor,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                  child: Text(
                                    'Đã có 1 yêu cầu',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: controller.idFromPost.value == model.id ? kBackground : kPrimaryLightColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ]


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
            )

          ],
        ),
      ),
    );
  }

}