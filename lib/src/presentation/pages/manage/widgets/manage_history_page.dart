import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/request_post_result_model.dart';
import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/trade_model.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../../../core/utils/format_datetime.dart';
import '../../../../domain/models/sell_free_result_model.dart';
import '../../../../domain/models/trading_sent_model.dart';
import '../../../widgets/appbar_customize.dart';
import '../../information/widgets/bao_cao_vi_pham_page.dart';
import '../../search/widgets/search_product_shimmer_widget.dart';


class ManageHistoryPage extends GetView<ManageController> {
  static const String routeName = '/ManageHistoryPage';
  final Widget? leading;
  const ManageHistoryPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getTradingReceived();
    controller.getRequestReceived();
    controller.getPostRequestedReceived();
    controller.getTradingSent();
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Lịch sử',
          isUseOnlyBack: true,
          actionRights: [
            IconButton(
                onPressed: () => Get.toNamed(BaoCaoViPhamPage.routeName),
                icon: const Icon(
                  Icons.report,
                  color: Colors.white,
                  size: 25.0,
                )
            )
          ]
        ),
        backgroundColor: kBackgroundBottomBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoadingTradingReceived.value) {
                  return const SearchProductShimmerWidget(
                    columnCount: 2,
                  );
                }
                if(controller.tradingReceivedLst.value != null) {
                  return Column(
                    children: [
                      _buildTab(context,
                        controller.tradingReceivedLst.value!.length,
                        controller.requestReceivedLst.value!.data.length,
                        controller.postRequestedLst.value!.data.length,
                        controller.tradingSentLst.value!.length,
                      ),
                      if(controller.tabInt.value == 0)...[
                        for(var cont in controller.tradingReceivedLst.value!)
                          _buildHistoryTradeItem(context: context, dataTrade: cont)
                      ]else if(controller.tabInt.value == 1)...[
                        for(var cont in controller.requestReceivedLst.value!.data)
                          _buildHistoryRequestItem(context: context, dataRequest: cont)
                      ]else if(controller.tabInt.value == 2)...[
                        for(var cont in controller.postRequestedLst.value!.data)
                          _buildPostRequestedItem(context: context, dataRequest: cont)
                      ]else...[
                        for(var cont in controller.tradingSentLst.value!)
                          _buildHistoryTradeItem(context: context, dataTrade: cont)
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
              }),
            ],
          ),
        ));
  }

  Widget _buildTab(BuildContext context, int slTraoDoi, int slRequest, int slPost, int slSent){
    return Obx(() => SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => controller.updateStatus(0),
              child: Container(
                //width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  gradient: controller.tabInt.value == 0 ? kDefaultGradient : null,
                ),
                child: Text(
                  'Đã trao đổi ($slTraoDoi)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,
                      color: controller.tabInt.value == 0 ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.updateStatus(1),
              child: Container(
                //width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  gradient: controller.tabInt.value == 1 ? kDefaultGradient : null,
                ),
                child: Text(
                  'Đã cho ($slRequest)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,
                      color: controller.tabInt.value == 1 ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.updateStatus(2),
              child: Container(
                //width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  gradient: controller.tabInt.value == 2 ? kDefaultGradient : null,
                ),
                child: Text(
                  'Đã xin ($slPost)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,
                      color: controller.tabInt.value == 2 ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => controller.updateStatus(3),
              child: Container(
                //width: MediaQuery.of(context).size.width * 0.4,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  gradient: controller.tabInt.value == 3 ? kDefaultGradient : null,
                ),
                child: Text(
                  'Đã gửi trao đổi ($slSent)',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500,
                      color: controller.tabInt.value == 3 ? Colors.white : Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildHistoryTradeItem({required BuildContext context, required TradingSentResultModel dataTrade}){
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        color: kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 10.0),
                decoration: const BoxDecoration(
                    border: Border(
                        left: BorderSide(
                            width: 5.0,
                            color: kPrimaryLightColor
                        )
                    )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(dataTrade.fromGroup != null)...[
                      if(dataTrade.fromGroup!.groupPosts!.isNotEmpty)...[
                        for(var cont in dataTrade.fromGroup!.groupPosts!)...[
                          _buildItemTrade(context, cont, true),
                        ]
                      ]
                    ],
                    if(dataTrade.toGroup != null)...[
                      if(dataTrade.toGroup!.groupPosts!.isNotEmpty)...[
                        for(var cont in dataTrade.toGroup!.groupPosts!)...[
                          _buildItemTrade(context, cont, false),
                        ]
                      ]
                    ]

                  ],
                ),
              ),
              Positioned(
                top: 0.0,
                child: Column(
                  children: [
                    Container(
                      width: 10.0,
                      height: 30.0,
                      color: kBackgroundBottomBar,
                    ),
                    const Icon(
                      Icons.circle,
                      color: kPrimaryLightColor,
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0.0,
                child: Column(
                  children: [
                    const Icon(
                      Icons.circle,
                      color: kPrimaryLightColor,
                    ),
                    Container(
                      width: 10.0,
                      height: 40.0,
                      color: kBackgroundBottomBar,
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Trạng thái: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                    text: dataTrade.status,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: dataTrade.status == 'Accept' ? kSecondaryGreen :
                               dataTrade.status == 'Deny' ? kSecondaryRed : kSecondaryYellow,
                        fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _buildHistoryRequestItem({required BuildContext context, required RequestResultModel dataRequest}){
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        color: kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildItemRequest(context, dataRequest.post, true),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Trạng thái: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.status,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: dataRequest.status == 'Accept' ? kSecondaryGreen :
                          dataRequest.status == 'Deny' ? kSecondaryRed : kSecondaryYellow,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _buildPostRequestedItem({required BuildContext context, required Post dataRequest}){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        color: kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Tiêu đề: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Nội dung: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.content ?? 'Không có',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Địa chỉ: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.location,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10.0),
          //   child: RichText(
          //     // text: TextSpan(
          //     //   text: 'Giá: ',
          //     //   style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
          //     //   children: <TextSpan>[
          //     //     TextSpan(
          //     //         text: dataRequest.price != null ? dataRequest.price.toString().split('.').first : '0đ',
          //     //         style: Theme.of(context).textTheme.titleMedium!.copyWith(
          //     //             color: kPrimaryLightColor,
          //     //             fontWeight: FontWeight.w700)
          //     //     ),
          //     //   ],
          //     // ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Trạng thái: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.isUsed == true ? 'Đã sử dụng' : 'Mới',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: RichText(
              text: TextSpan(
                text: 'Loại hàng: ',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(
                      text: dataRequest.type,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: kPrimaryLightColor,
                          fontWeight: FontWeight.w700)
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _buildItemTrade(BuildContext context, GroupPosts cont, bool isLine){
    return GestureDetector(
      onTap: () => controller.goDetail(id: cont.id!),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isLine == true ? kBackground : kBackgroundBottomBar
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
                  child: cont.post!.resources.isNotEmpty ? Image.network(
                      CoreUrl.baseImageURL + cont.post!.resources[0].id + cont.post!.resources[0].extension,
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
                                  cont.post!.resources.length.toString(),
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
                            cont.title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        // SizedBox(
                        //   child: Text(
                          //     '${cont.price.toString().split('.').first} đ',
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
                              'Đã đăng ${FormatDateTime.getHourFormat(cont.dateUpdated)} ${FormatDateTime.getDateFormat(cont.dateUpdated)}',
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

          ],
        ),
      ),
    );
  }

  Widget _buildItemRequest(BuildContext context, Post cont, bool isLine){
    return GestureDetector(
      onTap: () => controller.goDetail(id: cont.id),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: isLine == true ? kBackground : kBackgroundBottomBar
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
                            cont.title,
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        // SizedBox(
                        //   child: Text(
                        //     '${cont.price.toString().split('.').first} đ',
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
                              'Đã đăng ${FormatDateTime.getHourFormat(cont.dateUpdated)} ${FormatDateTime.getDateFormat(cont.dateUpdated)}',
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

          ],
        ),
      ),
    );
  }
}
