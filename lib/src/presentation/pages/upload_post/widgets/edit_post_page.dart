import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_controller.dart';
import 'package:i_trade/src/presentation/widgets/appbar_customize.dart';

import '../../../../../core/initialize/theme.dart';


class EditPostPage extends GetView<UploadPostController> {
  static const String routeName = '/EditPostPage';
  final Widget? leading;
  const EditPostPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller.isFirst.value == true){
      controller.getCategories(pageIndex: 1, pageSize: 10);
      controller.isNew.call(controller.productInfo.value!.isUsed == false ? true : false);
      controller.isSell.call(false);
      controller.isFree.call(controller.productInfo.value!.type == 'Free' ? true : false);
      controller.titleController.text = controller.productInfo.value!.title;
      controller.contentController.text = controller.productInfo.value!.content;
      controller.addressController.text = controller.productInfo.value!.location;
    }

    return Scaffold(
      appBar: AppbarCustomize.buildAppbar(
        context: context,
        title: 'Chỉnh sửa bài đăng bài',
        isUseOnlyBack: true,
      ),
        backgroundColor: kBackground,
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: kBackgroundBottomBar,
          ),
          margin: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoUpload(context),
                  _buildTraderInfo(context),
                  _buildButtonUpload(context)
                ],
              ),
            )
        ));
    }
  Widget _buildInfoUpload(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '1. Thông tin bài đăng',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Mong muốn',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                    children: <TextSpan>[
                      TextSpan(
                          text: '*',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: kSecondaryRed, fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
                const SizedBox(height: 10.0,),
                Obx(() => Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.isSell.call(false);
                        controller.isFree.call(false);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color:  controller.isFree.value == false ? controller.isSell.value == false ?  kPrimaryLightColor2 : kBackground : kBackground
                        ),
                        child: Text(
                          'Trao đổi',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: controller.isFree.value == false ?  controller.isSell.value == false ? kPrimaryLightColor : kTextColorBody : kTextColorBody,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    // if(controller.isPostToTrade.value == false)...[
                    //   const SizedBox(width: 10.0,),
                    //   GestureDetector(
                    //     onTap: () {
                    //       controller.isSell.call(true);
                    //       controller.isFree.call(false);
                    //     },
                    //     child: Container(
                    //       padding: const EdgeInsets.all(10.0),
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10.0),
                    //           color: controller.isFree.value == false ?  controller.isSell.value == true ?  kPrimaryLightColor2 : kBackground : kBackground
                    //       ),
                    //       child: Text(
                    //         'Bán',
                    //         style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    //             color: controller.isFree.value == false ? controller.isSell.value == true ? kPrimaryLightColor : kTextColorBody : kTextColorBody,
                    //             fontWeight: FontWeight.w500
                    //         ),
                    //         textAlign: TextAlign.center,
                    //       ),
                    //     ),
                    //   )
                    // ],
                    const SizedBox(width: 10.0,),
                    GestureDetector(
                      onTap: () => controller.isFree.call(controller.isFree.value == false ? true : false),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: controller.isFree.value == true ?  kPrimaryLightColor2 : kBackground
                        ),
                        child: Text(
                          'Miễn phí',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: controller.isFree.value == true ? kPrimaryLightColor : kTextColorBody,
                              fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                )),
                _buildTextFormField(context: context, title: 'Tiêu đề', maxLine: 1, textController: controller.titleController),
                _buildTextFormField(context: context, title: 'Mô tả sản phẩm', maxLine: 5, textController: controller.contentController),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTraderInfo(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '2. Về người trao đổi',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextFormField(context: context, title: 'Địa chỉ', maxLine: 1, textController: controller.addressController),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonUpload(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => controller.putProduct(context: context),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: kDefaultGradient
              ),
              child: Text(
                'Cập nhật',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField({required BuildContext context,
    required String title, required int maxLine,
    TextInputType textInputType = TextInputType.text,
    required TextEditingController textController,
    bool isPrice = false}){
    return isPrice == true ? Obx(() => Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: kBackground
        ),
        color: isPrice == true ? controller.isFree.value == true ? kBackground : kBackgroundBottomBar : kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: TextFormField(
        //initialValue: number.toString(),
        enabled: isPrice == true ? controller.isFree.value == true ? false : true : true,
        controller: textController,
        keyboardType: textInputType,
        maxLines: maxLine,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            disabledBorder: InputBorder.none,
            hintText: '$title...',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kTextColorGrey)),
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
      ),
    )) : Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      margin: const EdgeInsets.only(top: 10.0, bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: kBackground
        ),
        color: isPrice == true ? controller.isFree.value == true ? kBackground : kBackgroundBottomBar : kBackgroundBottomBar,
        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
      ),
      child: TextFormField(
        //initialValue: number.toString(),
        enabled: isPrice == true ? controller.isFree.value == true ? false : true : true,
        controller: textController,
        keyboardType: textInputType,
        maxLines: maxLine,
        decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
            disabledBorder: InputBorder.none,
            hintText: '$title...',
            hintStyle: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: kTextColorGrey)),
        onChanged: (value) {},
        onFieldSubmitted: (value) {},
      ),
    );
  }
}