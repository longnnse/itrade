import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/values/colors.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/entities/trading.dart';

import '../index.dart';

class ExchangeList extends GetView<ExchangeController> {
  const ExchangeList({super.key});

  Widget _buildListItem(TradingItem item) {
    return Container(
      padding: EdgeInsets.only(top: 10.h),
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: AppColors.primaySecondBackground, width: 1))),
      child: InkWell(
        onTap: () {
          controller.gochat(item);
        },
        child: Column(
          children: [
            // Positioned(child: Icon(Icons.call_received_outlined),top: 2.w, left: 2.w,),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          color: AppColors.primaySecondBackground,
                          borderRadius: BorderRadius.all(Radius.circular(22.w)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${CoreUrl.baseApiUrl}/${item.fromPost!.resources![0].id}${item.toPost!.resources![0].extension!}',
                        height: 40.w,
                        width: 40.w,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.w)),
                              image: DecorationImage(image: imageProvider)),
                        ),
                      )),
                  Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                          color: AppColors.primaySecondBackground,
                          borderRadius: BorderRadius.all(Radius.circular(22.w)),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ]),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${CoreUrl.baseApiUrl}/${item.toPost!.resources![0].id}${item.toPost!.resources![0].extension!}',
                        height: 44.w,
                        width: 44.w,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.w)),
                              image: DecorationImage(image: imageProvider)),
                        ),
                      )),
                  Container(
                    // width: 150.w,
                    padding: EdgeInsets.only(
                        top: 10.w, left: 10.w, right: 0.w, bottom: 0.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200.w,
                          height: 42.w,
                          child: Text(
                            item.content ?? "No content",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: AppColors.primaryText,
                                fontFamily: "Avenir"),
                          ),
                        ),
                        Container(
                          width: 12.w,
                          height: 12.w,
                          margin: EdgeInsets.only(top: 5.w),
                          // child: Image.asset("assets/icons/ang.png"),
                          child: item.toPost?.user?.id ==
                                  AppSettings.getValue(KeyAppSetting.userId)
                              ? Icon(Icons.admin_panel_settings)
                              : Icon(Icons.people),
                        )
                      ],
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 0.w, horizontal: 20.w),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                var item = controller.state.tradingList[index];
                return _buildListItem(item);
              }, childCount: controller.state.tradingList.length)),
            )
          ],
        ));
  }
}
