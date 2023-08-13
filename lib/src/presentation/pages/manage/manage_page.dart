import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_history_page.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_product_shimmer_widget.dart';

import '../../../../core/initialize/core_url.dart';
import '../../../../core/initialize/theme.dart';
import '../../../../core/utils/app_settings.dart';
import '../../../domain/models/trading_sent_model.dart';


class ManagePage extends GetView<ManageController> {
  static const String routeName = '/ManagePage';
  final Widget? leading;
  const ManagePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ManageController());
    controller.getPersonalPosts();
    return Scaffold(
        backgroundColor: kBackground,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: kBackgroundBottomBar,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                            child: Text(
                              AppSettings.getValue(KeyAppSetting.fullName),
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => Get.toNamed(ManageHistoryPage.routeName),
                                child: Container(
                                  margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      border: Border.all(
                                          color: kPrimaryLightColor,
                                          width: 2.0
                                      )
                                  ),
                                  child: Text(
                                    'Lịch sử trao đổi cho mua',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor),
                                  ),
                                ),
                              ),
                              // GestureDetector(
                              //   onTap: () => controller.updateStatusIsTradeLst(),
                              //   child: Container(
                              //     margin: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 10.0, right: 10.0),
                              //     padding: const EdgeInsets.all(8.0),
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(5.0),
                              //         border: Border.all(
                              //             color: kPrimaryLightColor,
                              //             width: 2.0
                              //         ),
                              //       color: kPrimaryLightColor
                              //     ),
                              //     child: Obx(() => Text(
                              //       controller.isTradeLst.value == true ? 'Bài đăng của tôi' : 'Đã trao đổi',
                              //       style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                              //     )),
                              //   ),
                              // ),
                            ],
                          )
                        ],
                      ),
                    ),
                    _buildSearch(context: context),
                    Obx(() {
                      if (controller.isLoading.value) {
                        return const ManageProductShimmerWidget(
                          columnCount: 1,
                        );
                      }
                      if(controller.productList.value!.isNotEmpty) {
                        return Column(
                          children: [
                            for(var cont in controller.productList.value!)...[
                              if(controller.searchStr.value != '')...[
                                if(cont.title.contains(controller.searchStr.value))...[
                                  if(controller.lstHide.value.isNotEmpty)...[
                                    if(!controller.lstHide.contains(cont.id))
                                      _buildItem(context: context, model: cont)
                                  ]else...[
                                    _buildItem(context: context, model: cont)
                                  ]
                                ]
                              ]else...[
                                if(controller.lstHide.value.isNotEmpty)...[
                                  if(!controller.lstHide.contains(cont.id))
                                    _buildItem(context: context, model: cont)
                                ]else...[
                                  _buildItem(context: context, model: cont)
                                ]
                              ]
                            ]
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
              )
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

  Widget _buildSearch({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: TextFormField(
        //initialValue: number.toString(),
        controller: controller.searchController,
        decoration: InputDecoration(
            suffixIcon: const Icon(
                Icons.search
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 10.0),
            disabledBorder: InputBorder.none,
            hintText: 'Nhập sản phẩm cần tìm...',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kTextColorGrey)),
        onChanged: (value) => controller.searchStr.call(value),
        onFieldSubmitted: (value){},
      ),
    );
  }

  Widget _buildItem({required BuildContext context, required Data model}){
    return Container(
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
                    height: MediaQuery.of(context).size.width * 0.21,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5.0,),
                        // Text(
                        //   '${model.price.toString().split('.').first} đ',
                        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                        // ),
                        const SizedBox(height: 5.0,),
                        Expanded(
                          child: Text(
                            'Đã đăng ${FormatDateTime.getHourFormat(model.dateUpdated)} ${FormatDateTime.getDateFormat(model.dateUpdated)}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    icon: const Icon(
                      Icons.more_vert,
                      size: 30.0,
                    ),
                    elevation: 16,
                    style: Theme.of(context).textTheme.titleMedium,
                    onChanged: (String? value) {
                      if(value == 'Ẩn'){
                        controller.lstHide.call().add(model.id);
                        controller.getPersonalPosts();
                      }
                    },
                    items: controller.lstDropdown.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                )
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
            child: Row(
              children: [
                if(model.type == 'Trade')...[
                  GestureDetector(
                    onTap: () => controller.goGroupPersonalPage(model.id),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      padding: const EdgeInsets.all(10.0),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.chat,
                            color: kPrimaryLightColor,
                          ),
                          Text(
                            'Danh sách nhóm trao đổi sản phẩm',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10.0,)
                        ],
                      ),
                    ),
                  ),
                ]else...[
                  GestureDetector(
                    onTap: () => controller.goTradePage(model.id, false),
                    child: Container(
                      width: MediaQuery.of(context).size.width -10,
                      padding: const EdgeInsets.all(10.0),
                      decoration: const BoxDecoration(
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.free_cancellation,
                            color: kPrimaryLightColor,
                          ),
                          Text(
                            'Mua/miễn phí SP',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 10.0,)
                        ],
                      ),
                    ),
                  )
                ]

              ],
            ),
          )

        ],
      ),
    );
  }
}