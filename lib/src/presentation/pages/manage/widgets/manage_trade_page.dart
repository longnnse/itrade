import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/search/widgets/search_product_shimmer_widget.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';


class ManageTradePage extends GetView<ManageController> {
  static const String routeName = '/ManageTradePage';
  final Widget? leading;
  const ManageTradePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller.isTrade.value == true){
      controller.getTradePosts(pageIndex: 1, pageSize: 20, fromPostID: '', toPostID: controller.productID.value);
    }else{
      controller.getRequestByID(postID: controller.productID.value);
    }

    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Danh sách sản phẩm ${controller.isTrade.value == true ? 'trao đổi' : 'Mua/Miễn phí'}',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackground,
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSearch(context: context),
                        Expanded(child: _buildItemList(context: context))
                      ],
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
            ),
            Obx(() => controller.isLoadingConfirmTrade.value == true ?
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
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBackgroundBottomBar,
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
            contentPadding: const EdgeInsets.only(top: 10.0),
            disabledBorder: InputBorder.none,
            hintText: 'Nhập bài đăng cần tìm...',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kTextColorGrey)),
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
      ),
    );
  }

  Widget _buildItemList({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.only(top: 5.0),
      color: kBackgroundBottomBar,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              if (controller.isLoadingTrade.value) {
                return const SearchProductShimmerWidget(
                  columnCount: 1,
                );
              }
              if(controller.isTrade.value == true ? controller.tradeList.value != null : controller.requestLst.value != null){
                if(controller.isTrade.value == true ? controller.tradeList.value!.data.isNotEmpty : controller.requestLst.value!.isNotEmpty) {
                  return Column(
                    children: [
                      if(controller.isTrade.value == true)...[
                        for(var cont in controller.tradeList.value!.data)
                          GestureDetector(
                            onTap: () => controller.goDetail(id: cont.fromPost.id),
                            child: Container(
                              decoration: const  BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: kBackground
                                    )
                                ),
                              ),
                              height: MediaQuery.of(context).size.width * 0.25,
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                              child: Row(
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
                                        child: cont.fromPost.resources.isNotEmpty ? Image.network(
                                            CoreUrl.baseImageURL + cont.fromPost.resources[0].id + cont.fromPost.resources[0].extension,
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
                                                        cont.fromPost.resources.length.toString(),
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
                                  const SizedBox(width: 5.0,),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  cont.fromPost.title,
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   child: Text(
                                              //     '${cont.fromPost.price.toString().split('.').first} đ',
                                              //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
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
                                                    'Đã đăng ${FormatDateTime.getHourFormat(cont.fromPost.dateUpdated)} ${FormatDateTime.getDateFormat(cont.fromPost.dateUpdated)}',
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if(cont.status == 'Accept' || cont.status == 'Deny')...[
                                            Container(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kBackground,
                                                      width: 2.0
                                                  ),
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: kBackground
                                              ),
                                              child: Text(
                                                cont.content != '' ? cont.content : cont.status,
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            )
                                          ]else...[
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => controller.postAcceptTrade(tradeID: cont.id, context: context),
                                                  child: Container(
                                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kSecondaryGreen,
                                                            width: 2.0
                                                        ),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: kSecondaryGreen
                                                    ),
                                                    child: Text(
                                                      'Đồng ý',
                                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0,),
                                                GestureDetector(
                                                  onTap: () => controller.postDenyTrade(tradeID: cont.id, context: context),
                                                  child: Container(
                                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kSecondaryRed,
                                                            width: 2.0
                                                        ),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: kSecondaryRed
                                                    ),
                                                    child: Text(
                                                      'Từ chối',
                                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ]
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          )
                      ],
                      if(controller.isTrade.value == false)...[
                        for(var cont in controller.requestLst.value!)
                          GestureDetector(
                            onTap: () => controller.goDetail(id: cont.id),
                            child: Container(
                              decoration: const  BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: kBackground
                                    )
                                ),
                              ),
                              //height: MediaQuery.of(context).size.width * 0.25,
                              margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                child: Text(
                                                  cont.post.title,
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              SizedBox(
                                                child: Text(
                                                  cont.description,
                                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              // SizedBox(
                                              //   child: Text(
                                              //     '${cont.post.price.toString().split('.').first} đ',
                                              //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                          SizedBox(
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
                                                    'Đã đăng ${FormatDateTime.getHourFormat(cont.post.dateUpdated)} ${FormatDateTime.getDateFormat(cont.post.dateUpdated)}',
                                                    style: Theme.of(context).textTheme.bodySmall,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if(cont.status == 'Accept' || cont.status == 'Deny')...[
                                            Container(
                                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: kBackground,
                                                      width: 2.0
                                                  ),
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color: kBackground
                                              ),
                                              child: Text(
                                                cont.status,
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                              ),
                                            )
                                          ]else...[
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => controller.postAcceptRequest(tradeID: cont.id, context: context),
                                                  child: Container(
                                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kSecondaryGreen,
                                                            width: 2.0
                                                        ),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: kSecondaryGreen
                                                    ),
                                                    child: Text(
                                                      'Đồng ý',
                                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10.0,),
                                                GestureDetector(
                                                  onTap: () => controller.postDenyRequest(tradeID: cont.id, context: context),
                                                  child: Container(
                                                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: kSecondaryRed,
                                                            width: 2.0
                                                        ),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                        color: kSecondaryRed
                                                    ),
                                                    child: Text(
                                                      'Từ chối',
                                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ]
                                        ],
                                      ),
                                    ),
                                  )

                                ],
                              ),
                            ),
                          )
                      ]
                    ],
                  );
                } else {
                  return Center(
                      child: Text(
                        'Không có bài trao đổi nào với sản phẩm của bạn',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                      )
                  );
                }
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
    );
  }
}