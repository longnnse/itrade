import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_trade/common/values/colors.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/src/domain/entities/msg_content.dart';
import 'package:intl/intl.dart';

import '../../../../../core/initialize/theme.dart';

Widget ChatLeftList(Msgcontent item) {
  return Container(
      padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 250.w, minHeight: 40.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                          '${CoreUrl.baseApiUrl}/user/${item.tradingUserChat?.user?.userAva}',
                      height: 30.w,
                      width: 30.w,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(22.w)),
                            image: DecorationImage(image: imageProvider)),
                      ),
                    )),
                SizedBox(
                  width: 4.w,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: item.type == "Text"
                              ? kSecondaryRed
                              : Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.w))),
                      padding: item.type == "Text"
                          ? EdgeInsets.only(
                              top: 10.w, bottom: 10.w, left: 10.w, right: 10.w)
                          : const EdgeInsets.all(0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          item.type == "Text"
                              ? Text(
                                  item.content!,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.primaryElementText),
                                )
                              : CachedNetworkImage(
                                  imageUrl:
                                      '${CoreUrl.baseApiUrl}/message/trading/${item.content!}',
                                  height: 160.w,
                                  width: 160.w,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider)),
                                  ),
                                ),
                          SizedBox(
                            height: 12.w,
                          ),
                          Text(
                            DateTime.parse(item.dateCreated.toString()).hour > 1
                                ? DateFormat.Hm().format(
                                    DateTime.parse(item.dateCreated.toString()))
                                : DateFormat.yMd().add_jm().format(
                                    DateTime.parse(item.dateCreated.toString())),
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      )),
                )
              ],
            ),
          )
        ],
      ));
}
