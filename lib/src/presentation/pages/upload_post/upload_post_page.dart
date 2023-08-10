import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_controller.dart';
import 'package:i_trade/src/presentation/widgets/appbar_customize.dart';

import '../../../../core/initialize/theme.dart';


class UploadPostPage extends GetView<UploadPostController> {
  static const String routeName = '/UploadPostPage';
  final Widget? leading;
  const UploadPostPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(controller.isFirst.value == true){
      controller.getCategories(pageIndex: 1, pageSize: 10);
    }

    return Scaffold(
      appBar: AppbarCustomize.buildAppbar(
        context: context,
        title: controller.isPostToTrade.value == false ? 'Đăng bài' : 'Đăng bài trao đổi',
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
                  _buildUploadPicture(context),
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator()
                    );
                  }
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Chọn danh mục',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: controller.items
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.split("@").first,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kTextColorBody,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: controller.selectedValue.value,
                      onChanged: (value) {
                        controller.selectedValue.call(value as String);

                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: kBackgroundBottomBar,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30.0,
                        ),
                        iconSize: 14,
                        iconEnabledColor: kPrimaryLightColor,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: kBackgroundBottomBar,
                          ),
                          elevation: 8,
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10.0,),
                RichText(
                  text: TextSpan(
                    text: 'Loại đồ muốn trao đổi',
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
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                        child: CircularProgressIndicator()
                    );
                  }
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Row(
                        children: const [
                          Icon(
                            Icons.list,
                            size: 16,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              'Chọn danh mục',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      items: controller.items
                          .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item.split("@").first,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: kTextColorBody,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ))
                          .toList(),
                      value: controller.selectedDesiredValue.value,
                      onChanged: (value) {
                        controller.selectedDesiredValue.call(value as String);

                      },
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 14, right: 14),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.black26,
                          ),
                          color: kBackgroundBottomBar,
                        ),
                        elevation: 2,
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 30.0,
                        ),
                        iconSize: 14,
                        iconEnabledColor: kPrimaryLightColor,
                        iconDisabledColor: Colors.grey,
                      ),
                      dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: MediaQuery.of(context).size.width * 0.9,
                          padding: null,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: kBackgroundBottomBar,
                          ),
                          elevation: 8,
                          offset: const Offset(0, 0),
                          scrollbarTheme: ScrollbarThemeData(
                            radius: const Radius.circular(40),
                            thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          )),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                        padding: EdgeInsets.only(left: 14, right: 14),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10.0,),
                RichText(
                  text: TextSpan(
                    text: 'Tình trạng',
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
                      onTap: () => controller.isNew.call(false),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color:  controller.isNew.value == false ?  kPrimaryLightColor2 : kBackground
                        ),
                        child: Text(
                          'Đã sử dụng',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                             color: controller.isNew.value == false ? kPrimaryLightColor : kTextColorBody,
                            fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0,),
                    GestureDetector(
                      onTap: () => controller.isNew.call(true),
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: controller.isNew.value == true ?  kPrimaryLightColor2 : kBackground
                        ),
                        child: Text(
                          'Mới',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: controller.isNew.value == true ? kPrimaryLightColor : kTextColorBody,
                            fontWeight: FontWeight.w500
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                )),
                const SizedBox(height: 10.0,),
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
                    if(controller.isPostToTrade.value == false)...[
                      const SizedBox(width: 10.0,),
                      GestureDetector(
                        onTap: () {
                          controller.isSell.call(true);
                          controller.isFree.call(false);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: controller.isFree.value == false ?  controller.isSell.value == true ?  kPrimaryLightColor2 : kBackground : kBackground
                          ),
                          child: Text(
                            'Bán',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: controller.isFree.value == false ? controller.isSell.value == true ? kPrimaryLightColor : kTextColorBody : kTextColorBody,
                                fontWeight: FontWeight.w500
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
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
                _buildTextFormField(context: context, title: 'Giá', maxLine: 1, textInputType: TextInputType.number, textController: controller.priceController, isPrice: true),
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
                // Obx(() => Row(
                //   children: [
                //     GestureDetector(
                //       onTap: () => controller.isPro.call(false),
                //       child: Container(
                //         width: MediaQuery.of(context).size.width * 0.35,
                //         padding: const EdgeInsets.all(10.0),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10.0),
                //             color:  controller.isPro.value == false ?  kPrimaryLightColor2 : kBackground
                //         ),
                //         child: Text(
                //           'Cá nhân',
                //           style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //               color: controller.isPro.value == false ? kPrimaryLightColor : kTextColorBody,
                //               fontWeight: FontWeight.w500
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //     ),
                //     const SizedBox(width: 10.0,),
                //     GestureDetector(
                //       onTap: () => controller.isPro.call(true),
                //       child: Container(
                //         width: MediaQuery.of(context).size.width * 0.35,
                //         padding: const EdgeInsets.all(10.0),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(10.0),
                //             color: controller.isPro.value == true ?  kPrimaryLightColor2 : kBackground
                //         ),
                //         child: Text(
                //           'Bán chuyên',
                //           style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //               color: controller.isPro.value == true ? kPrimaryLightColor : kTextColorBody,
                //               fontWeight: FontWeight.w500
                //           ),
                //           textAlign: TextAlign.center,
                //         ),
                //       ),
                //     ),
                //   ],
                // )),
                _buildTextFormField(context: context, title: 'Địa chỉ', maxLine: 1, textController: controller.addressController),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUploadPicture(BuildContext context){
    int indexListMedia = 0;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Text(
              '3. Đăng hình sản phẩm',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          GestureDetector(
            onTap: () => controller.mediaSelection(index: 1, context: context),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: kPrimaryLightColor,
                        style: BorderStyle.solid
                      ),
                      color: kBackground
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                          child: const Icon(
                              Icons.camera_alt,
                              color: kPrimaryLightColor,
                              size: 50.0
                          ),
                        ),
                        Text(
                          'Đăng từ 01 tới 06 hình',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, color: kTextColorGrey),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(() {
            return controller.mediaModels.value.isNotEmpty ? Container(
              height: 80,
              margin: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 16.0),
              child: Obx(() => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.mediaModels.value.length,
                itemBuilder: (context, index) {
                  indexListMedia = controller.mediaModels.value != null
                      ? controller.mediaModels.value.length
                      : 0;

                  return InkWell(
                    onTap: () {
                    },
                    child: Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 70,
                        width: ((MediaQuery.of(context).size.width -
                            (16 * 2) -
                            (10 * 2)) /
                            3),
                        child: controller.mediaModels.value[index].isLoading !=
                            true
                            ? Stack(
                          children: [
                            Image.file(
                              File(controller.mediaModels.value[index].pathFile!),
                              fit: BoxFit.cover,
                              height: 70,
                              width:
                              ((MediaQuery.of(context)
                                  .size
                                  .width -
                                  (16 * 2) -
                                  (10 * 2)) /
                                  3),
                            ),
                            Column(
                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .center,
                                  children: [
                                    GestureDetector(
                                      onTap: () => controller.deleteImage(index),
                                      child: Container(
                                        height: 35,
                                        width: 35,
                                        decoration:
                                        const BoxDecoration(
                                          shape: BoxShape
                                              .circle,
                                          color: Color
                                              .fromRGBO(
                                              00,
                                              00,
                                              00,
                                              0.4),
                                        ),
                                        child: const Icon(
                                          Icons.delete,
                                          color:
                                          Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                            : const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0,
                                horizontal: 30.0),
                            child:
                            CircularProgressIndicator())),
                  );
                },
              )),
            ) : const SizedBox();
          })
        ],
      ),
    );
  }

  Widget _buildButtonUpload(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => controller.postUploadProduct(context: context),
            child: Container(
              padding: const EdgeInsets.all(13.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: kDefaultGradient
              ),
              child: Text(
                'Đăng',
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