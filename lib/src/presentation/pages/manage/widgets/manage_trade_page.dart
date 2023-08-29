import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/search/widgets/search_product_shimmer_widget.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../../domain/models/trading_sent_model.dart';
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
    controller.getTradePosts(pageIndex: 1, pageSize: 50, fromPostID: controller.fromProductID.value, toPostID: controller.toProductID.value);
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Chi tiết sản phẩm trao đổi',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackground,
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildItemList(context: context)
                    ],
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
              if(controller.tradeList.value != null){
                if(controller.tradeList.value!.data.isNotEmpty) {
                  return Column(
                    children: [
                      for(var cont in controller.tradeList.value!.data)
                        if(cont.fromGroup != null)...[
                          if(cont.fromGroup!.groupPosts!.isNotEmpty)
                            _buildDetailTradeItem(context: context, dataTrade: cont, idPost: cont.id!)
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

  Widget _buildDetailTradeItem({required BuildContext context, required TradingSentResultModel dataTrade, required String idPost}){
    return Container(
      margin: const EdgeInsets.only(top: 5.0),
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
                margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Danh sách gửi yêu cầu',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    if(dataTrade.fromGroup != null)...[
                      if(dataTrade.fromGroup!.groupPosts!.isNotEmpty)...[
                        Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for(var cont in dataTrade.fromGroup!.groupPosts!)...[
                                        _buildItemTrade(context: context,model:  cont, idTraoDoi: cont.id!),
                                      ]
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: kBackground.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(5.0)
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 20.0,
                                                    color: kPrimaryLightColor2,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Text(
                                                    '${dataTrade.fromGroup!.groupPosts![0].post!.user!.lastName} ${dataTrade.fromGroup!.groupPosts![0].post!.user!.firstName}',
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.mail,
                                                    size: 20.0,
                                                    color: kSecondaryRed,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Text(
                                                    dataTrade.fromGroup!.groupPosts![0].post!.user!.email ?? '',
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  )
                                                ],
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.phone,
                                                    size: 20.0,
                                                    color: kPrimaryLightColor,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Text(
                                                    dataTrade.fromGroup!.groupPosts![0].post!.user!.phoneNumber ?? '',
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 5.0,),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    size: 20.0,
                                                    color: kSecondaryRed,
                                                  ),
                                                  const SizedBox(width: 5.0,),
                                                  Text(
                                                    dataTrade.fromGroup!.groupPosts![0].post!.user!.address ?? '',
                                                    style: Theme.of(context).textTheme.titleMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Container(
                                            // padding: const EdgeInsets.all(8.0),
                                            width: 50.0,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(70.0),
                                              color: kBackgroundBottomBar,
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(60.0),
                                                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25), spreadRadius: 2, offset: const Offset(0, 4))],
                                              ),
                                              child: CircleAvatar(
                                                radius: 50.0,
                                                backgroundImage:
                                                NetworkImage(CoreUrl.baseAvaURL + dataTrade.fromGroup!.groupPosts![0].post!.user!.userAva!),
                                                backgroundColor: Colors.transparent,
                                              ),
                                            ),
                                          )

                                        ],
                                      ),


                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if(dataTrade.fromGroup!.groupPosts!.length > 1)
                              Positioned(
                                  left: 0.0,
                                  top: 40.0,
                                  child: Icon(
                                    Icons.arrow_circle_left,
                                    size: 25.0,
                                    color: Colors.black.withOpacity(0.4),
                                  )
                              ),
                            if(dataTrade.fromGroup!.groupPosts!.length > 1)
                              Positioned(
                                  right: 0.0,
                                  top: 40.0,
                                  child: Icon(
                                    Icons.arrow_circle_right,
                                    size: 25.0,
                                    color: Colors.black.withOpacity(0.4),
                                  )
                              )
                          ],
                        )
                      ]
                    ],
                    Text(
                      'Danh sách sản phẩm đăng của bạn',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w700),
                    ),
                    if(dataTrade.toGroup != null)...[
                      if(dataTrade.toGroup!.groupPosts!.isNotEmpty)...[
                        Stack(
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for(var cont in dataTrade.toGroup!.groupPosts!)...[
                                    _buildItemTrade(context: context, model: cont, idTraoDoi: cont.id!),
                                  ]
                                ],
                              ),
                            ),
                            if(dataTrade.toGroup!.groupPosts!.length > 1)
                              Positioned(
                                  left: 0.0,
                                  top: 40.0,
                                  child: Icon(
                                    Icons.arrow_circle_left,
                                    size: 25.0,
                                    color: Colors.black.withOpacity(0.4),
                                  )
                              ),
                            if(dataTrade.toGroup!.groupPosts!.length > 1)
                              Positioned(
                                  right: 0.0,
                                  top: 40.0,
                                  child: Icon(
                                    Icons.arrow_circle_right,
                                    size: 25.0,
                                    color: Colors.black.withOpacity(0.4),
                                  )
                              )
                          ],
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

            ],
          ),
          const SizedBox(height: 10.0,),
          SizedBox(
            width: Get.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    if(dataTrade.status == 'Finish' || dataTrade.status == 'Deny')...[
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
                          dataTrade.status ?? '',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      )
                    ]else...[
                      if(dataTrade.status != 'Accept')
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => controller.postAcceptTrade(tradeID: idPost, context: context, isManagePage: true),
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
                              onTap: () => controller.postDenyTrade(tradeID: idPost, context: context, isManagePage: true),
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
                const SizedBox(width: 10.0,),
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
          ),
          const SizedBox(height: 10.0,),
        ],
      ),
    );
  }

  Widget _buildItemTrade({required BuildContext context, required GroupPosts model, required String idTraoDoi}){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kBackgroundBottomBar,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: Get.width* 0.9,
                      height: Get.height * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: kBackground
                      ),
                      child: model.post!.resources.isNotEmpty ? Image.network(
                          CoreUrl.baseImageURL + model.post!.resources[0].id + model.post!.resources[0].extension,
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
                                      model.post!.resources.length.toString(),
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
                SizedBox(
                  // height: MediaQuery.of(context).size.width * 0.21,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        model.post!.title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 5.0,),
                      Text(
                        model.post!.content ?? '',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey),
                      ),
                      const SizedBox(height: 5.0,),
                      Text(
                        'Đã đăng ${FormatDateTime.getHourFormat(model.post!.dateUpdated)} ${FormatDateTime.getDateFormat(model.post!.dateUpdated)}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}