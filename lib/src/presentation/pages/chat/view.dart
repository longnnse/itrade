import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/values/colors.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/initialize/theme.dart';
import 'package:i_trade/src/presentation/pages/chat/widgets/chat_list.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';

import 'controller.dart';

class ChatPage extends GetView<ChatController> {
  static const String routeName = '/ChatPage';
  const ChatPage({super.key});

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() {
        return Container(
          child: Text(
            "${controller.state.to_name}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
                fontFamily: "Avenir",
                fontWeight: FontWeight.bold,
                color: AppColors.primaryElementText,
                fontSize: 18.sp),
          ),
        );
      }),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44.h,
                height: 44.h,
                child: CachedNetworkImage(
                  imageUrl:
                      '${CoreUrl.baseApiUrl}/user/${controller.state.to_avatar.value}',
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22.h),
                        image: DecorationImage(image: imageProvider)),
                  ),
                  errorWidget: (context, url, error) => const Image(
                      image: AssetImage("assets/images/account_header.png")),
                ),
              ),
              Positioned(
                  bottom: 5.w,
                  right: 0.w,
                  height: 14.w,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                        color: controller.state.to_online.value == "1"
                            ? AppColors.primaryElementStatus
                            : AppColors.primarySecondaryElementText,
                        borderRadius: BorderRadius.circular(12.w),
                        border: Border.all(
                            width: 2, color: AppColors.primaryElementText)),
                  ))
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ManageController ctl = Get.find();
    return Scaffold(
        appBar: _buildAppBar(),
        body: Obx(() => SafeArea(
                child: Stack(
              children: [
                ChatList(),
                Positioned(
                  bottom: 0.h,
                  child: Container(
                    width: 360.w,
                    padding:
                        EdgeInsets.only(left: 20.w, bottom: 10.h, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //for text fields and send messages
                        Container(
                          width: 270.w,
                          padding: EdgeInsets.only(
                              top: 10.h, bottom: 10.h, left: 5.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primayBackground,
                              border: Border.all(
                                  color:
                                      AppColors.primarySecondaryElementText)),
                          child: Row(
                            children: [
                              Container(
                                width: 220.w,
                                child: TextField(
                                  controller: controller.myInputController,
                                  keyboardType: TextInputType.multiline,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                      hintText: "Message....",
                                      contentPadding: EdgeInsets.only(
                                          left: 15.w, top: 0, bottom: 0),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      disabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.transparent)),
                                      hintStyle: const TextStyle(
                                          color: AppColors
                                              .primarySecondaryElementText)),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  child: Image.asset("assets/icons/send.png"),
                                ),
                                onTap: () {
                                  //send message
                                  controller.sendMessage();
                                },
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                                color: AppColors.primaryElement,
                                borderRadius: BorderRadius.circular(40.w),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 2,
                                      offset: Offset(1, 1))
                                ]),
                            child: Image.asset(
                              "assets/icons/add.png",
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            controller.goMore();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                controller.state.more_status.value
                    ? Positioned(
                        right: 20.w,
                        bottom: 100.h,
                        height: 140.w,
                        width: 40.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // GestureDetector(
                            //   child: Container(
                            //     width: 40.w,
                            //     height: 40.w,
                            //     padding: EdgeInsets.all(10.w),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(40.w),
                            //         color: AppColors.primayBackground,
                            //         boxShadow: [
                            //           BoxShadow(
                            //               color: Colors.grey.withOpacity(0.2),
                            //               spreadRadius: 2,
                            //               blurRadius: 2,
                            //               offset: Offset(1, 1))
                            //         ]),
                            //     child: Image.asset("assets/icons/file.png"),
                            //   ),
                            //   onTap: () {},
                            // ),
                            GestureDetector(
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.w),
                                    color: AppColors.primayBackground,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: Offset(1, 1))
                                    ]),
                                child: Image.asset("assets/icons/photo.png"),
                              ),
                              onTap: () {
                                controller.imgFromGallery();
                              },
                            ),
                            // GestureDetector(
                            //   child: Container(
                            //     width: 40.w,
                            //     height: 40.w,
                            //     padding: EdgeInsets.all(10.w),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(40.w),
                            //         color: AppColors.primayBackground,
                            //         boxShadow: [
                            //           BoxShadow(
                            //               color: Colors.grey.withOpacity(0.2),
                            //               spreadRadius: 2,
                            //               blurRadius: 2,
                            //               offset: Offset(1, 1))
                            //         ]),
                            //     child: Image.asset("assets/icons/call.png"),
                            //   ),
                            //   onTap: () {
                            //     // controller.audioCall();
                            //   },
                            // ),
                            // GestureDetector(
                            //   child: Container(
                            //     width: 40.w,
                            //     height: 40.w,
                            //     padding: EdgeInsets.all(10.w),
                            //     decoration: BoxDecoration(
                            //         borderRadius: BorderRadius.circular(40.w),
                            //         color: AppColors.primayBackground,
                            //         boxShadow: [
                            //           BoxShadow(
                            //               color: Colors.grey.withOpacity(0.2),
                            //               spreadRadius: 2,
                            //               blurRadius: 2,
                            //               offset: Offset(1, 1))
                            //         ]),
                            //     child: Image.asset("assets/icons/video.png"),
                            //   ),
                            //   onTap: () {
                            //     // controller.videoCall();
                            //   },
                            // ),
                            GestureDetector(
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.w),
                                    color: AppColors.primayBackground,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(1, 1))
                                    ]),
                                child: const Icon(
                                  Icons.check_circle_outline,
                                  size: 35.0,
                                  color: kSecondaryGreen,
                                ),
                              ),
                              onTap: () {
                                ctl.postAcceptTrade(tradeID: controller.trading_id, context: context, isManagePage: true);
                              },
                            ),
                            GestureDetector(
                              child: Container(
                                width: 40.w,
                                height: 40.w,
                                padding: EdgeInsets.all(5.w),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40.w),
                                    color: AppColors.primayBackground,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(1, 1))
                                    ]),
                                child: const Icon(
                                  Icons.cancel_outlined,
                                  size: 35.0,
                                  color: kSecondaryRed,
                                ),
                              ),
                              onTap: () {
                                ctl.postDenyTrade(tradeID: controller.trading_id, context: context, isManagePage: true);
                              },
                            )
                          
                          ],
                        ))
                    : Container()
              ],
            ))));
  }
}
