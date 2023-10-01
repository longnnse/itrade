import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/home/home_controller.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_detail.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../../domain/models/product_model.dart';
import '../../../widgets/appbar_customize.dart';
import '../../upload_post/upload_post_page.dart';

class MultiCartProductPage extends GetView<HomeController> {
  static const String routeName = '/MultiCartProductPage';
  final Widget? leading;
  const MultiCartProductPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getPersonalPosts();
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for(var cont in controller.selectedProductList)
                            _buildItem(context: context, model: cont),
                          const SizedBox(height: 20.0,),
                          Text(
                            'Chọn sản phẩm của bạn để trao đổi',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          _buildSearch(context: context),
                          Obx(() {
                            if (controller.isLoadingPersonalPost.value) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            if(controller.personalProductList.value!.isNotEmpty) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    for(var cont in controller.personalProductList.value!)...[
                                      if(cont.isCompleted == false)
                                      if(controller.searchStr.value != '')...[
                                        if(cont.title.contains(controller.searchStr.value))...[
                                          GestureDetector(
                                            onTap: () {
                                              if(!controller.selectedMyProductIDs.contains(cont.id)){
                                                controller.selectedMyProductList.add(cont);
                                                controller.selectedMyProductIDs.add(cont.id);
                                              }else{
                                                controller.selectedMyProductIDs.removeWhere( (item) => item == cont.id);
                                                controller.selectedMyProductList.removeWhere( (item) => item.id == cont.id);
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(5.0),
                                              margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                                              decoration: controller.selectedMyProductIDs.contains(cont.id) ? BoxDecoration(
                                                  border: Border.all(
                                                      width: 3.0,
                                                      color: kPrimaryLightColor
                                                  ),
                                                  borderRadius: BorderRadius.circular(5.0)
                                              ) : null,
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
                                                        child: cont.resources.isNotEmpty ? Image.network(
                                                            CoreUrl.baseImageURL + cont.resources[0].id + cont.resources[0].extension,
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
                                                                        cont.resources.length.toString(),
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
                                                      cont.title,
                                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context).size.width * 0.4,
                                                  //   child: Text(
                                                  //     '${cont.price.toString().split('.').first} đ',
                                                  //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                                                  //   ),
                                                  // ),
                                                  SizedBox(
                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        ShaderMask(
                                                          blendMode: BlendMode.srcIn,
                                                          shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                                                          child: const Icon(
                                                              Icons.date_range,
                                                              color: kPrimaryLightColor,
                                                              size: 15.0
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            '${FormatDateTime.getHourFormat(cont.dateUpdated)} ${FormatDateTime.getDateFormat(cont.dateUpdated)}',
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
                                        ]
                                      ]else...[
                                        GestureDetector(
                                          onTap: () {
                                            if(!controller.selectedMyProductIDs.contains(cont.id)){
                                              controller.selectedMyProductList.add(cont);
                                              controller.selectedMyProductIDs.add(cont.id);
                                            }else{
                                              controller.selectedMyProductIDs.removeWhere( (item) => item == cont.id);
                                              controller.selectedMyProductList.removeWhere( (item) => item.id == cont.id);
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5.0),
                                            margin: const EdgeInsets.only(right: 10.0, top: 10.0),
                                            decoration: controller.selectedMyProductIDs.contains(cont.id) ? BoxDecoration(
                                                border: Border.all(
                                                    width: 3.0,
                                                    color: kPrimaryLightColor
                                                ),
                                                borderRadius: BorderRadius.circular(5.0)
                                            ) : null,
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
                                                      child: cont.resources.isNotEmpty ? Image.network(
                                                          CoreUrl.baseImageURL + cont.resources[0].id + cont.resources[0].extension,
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
                                                                      cont.resources.length.toString(),
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
                                                    cont.title,
                                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // SizedBox(
                                                //   width: MediaQuery.of(context).size.width * 0.4,
                                                //   child: Text(
                                                //     '${cont.price.toString().split('.').first} đ',
                                                //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                                                //   ),
                                                // ),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width * 0.4,
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ShaderMask(
                                                        blendMode: BlendMode.srcIn,
                                                        shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                                                        child: const Icon(
                                                            Icons.date_range,
                                                            color: kPrimaryLightColor,
                                                            size: 15.0
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Text(
                                                          '${FormatDateTime.getHourFormat(cont.dateUpdated)} ${FormatDateTime.getDateFormat(cont.dateUpdated)}',
                                                          style: Theme.of(context).textTheme.bodySmall,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]
                                    ]

                                  ],
                                ),
                              );
                            } else {
                              return Center(
                                  child: Text(
                                    'Không có dữ liệu',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                                  )
                              );
                            }
                          }),
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
                  }),

                ],
              ),
            ),
            Obx(() => controller.manageController.isLoadingGroup.value == true ?
            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: kBackground.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )) : const SizedBox())
          ],
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.goGoCreatePost(),
        backgroundColor: kPrimaryLightColor,
        child: const Icon(
            Icons.upload
        ),
      ),
    );
  }
  Widget _buildButtonTrade(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => controller.manageController.tradeGroupMultiMulti(
                context: context,
                desc: '',
                lstFromPostID: controller.selectedMyProductIDs,
                lstToPostID: controller.selectedProductIDs),
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
            contentPadding: const EdgeInsets.only(top: 15.0),
            disabledBorder: InputBorder.none,
            hintText: 'Nhập sản phẩm cần tìm của bạn...',
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
                          // const SizedBox(height: 5.0,),
                          // Text(
                          //   '${model.price.toString().split('.').first} đ',
                          //   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                          // ),
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