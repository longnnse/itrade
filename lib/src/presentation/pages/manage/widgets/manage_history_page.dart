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
    controller.getRequestReceived();
    controller.getPostRequestedReceived();
    controller.getTradingSent();
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Lịch sử',
          isUseOnlyBack: false,
          actionLefts: [
            IconButton(
                onPressed: (){
                  Navigator.pop(context);
                  controller.tabInt.call(0);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 25.0,
                )
            )
          ],

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
                if (controller.isLoadingRequestReceived.value) {
                  return const SearchProductShimmerWidget(
                    columnCount: 2,
                  );
                }
                if(controller.requestReceivedLst.value != null) {
                  return Column(
                    children: [
                      _buildTab(context,
                        controller.requestReceivedLst.value!.data.length,
                        controller.postRequestedLst.value!.data.length,
                        controller.tradingSentLst.value!.length
                      ),
                      if(controller.tabInt.value == 1)...[
                        if(controller.requestReceivedLst.value!.data.isNotEmpty)...[
                          for(var cont in controller.requestReceivedLst.value!.data)
                            _buildHistoryRequestItem(context: context, dataRequest: cont, idReq: cont.id)
                        ]else...[
                          Center(
                              child: Text(
                                'Chưa có lịch sử',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                              )
                          )
                        ]

                      ]else if(controller.tabInt.value == 2)...[
                        if(controller.postRequestedLst.value!.data.isNotEmpty)...[
                          for(var cont in controller.postRequestedLst.value!.data)
                            _buildPostRequestedItem(context: context, dataRequest: cont)
                        ]else...[
                          Center(
                              child: Text(
                                'Chưa có lịch sử',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                              )
                          )
                        ]

                      ]else...[
                        if(controller.tradingSentLst.value!.isNotEmpty)...[
                          for(var cont in controller.tradingSentLst.value!)
                            _buildHistoryTradeItem(context: context, dataTrade: cont, idPost: cont.id!)
                        ]else...[
                          Center(
                              child: Text(
                                'Chưa có lịch sử',
                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                              )
                          )
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
              }),
            ],
          ),
        ));
  }

  Widget _buildTab(BuildContext context, int slRequest, int slPost, int slSent){
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
                  'Đã gửi trao đổi ($slSent)',
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

          ],
        ),
      ),
    ));
  }

  Widget _buildHistoryTradeItem({required BuildContext context, required TradingSentResultModel dataTrade, required String idPost}){
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Danh sách gửi yêu cầu',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w700),
                    ),
                    if(dataTrade.fromGroup != null)...[
                      if(dataTrade.fromGroup!.groupPosts!.isNotEmpty)...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for(var cont in dataTrade.fromGroup!.groupPosts!)...[
                                _buildItemTrade(context: context,cont:  cont, idTraoDoi: cont.id!),
                              ]
                            ],
                          ),
                        )
                      ]
                    ],
                    Text(
                      'Danh sách sản phẩm đăng của bạn',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w700),
                    ),
                    if(dataTrade.toGroup != null)...[
                      if(dataTrade.toGroup!.groupPosts!.isNotEmpty)...[
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for(var cont in dataTrade.toGroup!.groupPosts!)...[
                                _buildItemTrade(context: context, cont: cont, idTraoDoi: cont.id!),
                              ]
                            ],
                          ),
                        )
                      ]
                    ]

                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
              if(dataTrade.status != 'Deny' && dataTrade.status != 'Finish')
              GestureDetector(
                onTap: () => controller.gochat(dataTrade),
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: kPrimaryLightColor,
                          width: 2.0
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                      color: kPrimaryLightColor
                  ),
                  child: Text(
                    'Bắt đầu chat',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _buildHistoryRequestItem({required BuildContext context, required RequestResultModel dataRequest, required String idReq}){
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
          if(dataRequest.status != 'Accept')
            Container(
              padding: const EdgeInsets.only(bottom: 5.0),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => controller.postAcceptRequest(tradeID: idReq, context: context),
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
                    onTap: () => controller.postDenyRequest(tradeID: idReq, context: context),
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
              ),
            )
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

  Widget _buildItemTrade({required BuildContext context, required GroupPosts cont, required String idTraoDoi}){
    return GestureDetector(
      onTap: () => controller.goDetail(id: cont.id!),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: kBackgroundBottomBar,
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
                  const SizedBox(width: 10.0,),
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
