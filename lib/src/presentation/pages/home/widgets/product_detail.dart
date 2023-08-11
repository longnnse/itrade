import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_profile_page.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_page.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../home_controller.dart';

class ProductDetailPage extends GetView<HomeController> {
  static const String routeName = '/ProductDetailPage';
  final Widget? leading;
  const ProductDetailPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.countImage.call(0);
    controller.getPostByID(id: controller.idPost.value);
    controller.getPersonalPosts();
    controller.getPosts(pageIndex: 1, pageSize: 20, categoryIds: '');
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
            context: context,
            title: 'Chi tiết sản phẩm',
            isUseOnlyBack: true,
        ),
        backgroundColor: kBackground,
        body: Obx(() {
          if (controller.isLoadingData.value) {
            return const Center(child:  CircularProgressIndicator());
          }
          if(controller.productByIDModel.value != null) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeader(context, controller.productByIDModel.value!),
                      _buildDetail(context, controller.productByIDModel.value!),
                      _buildSpecifications(context, controller.productByIDModel.value!),
                      _buildProfile(context, controller.productByIDModel.value!),
                      _buildOtherItem(context: context, name: '${controller.productByIDModel.value!.user.firstName} ${controller.productByIDModel.value!.user.lastName}'),
                      _buildOtherItem(context: context, isSimilar: true),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.07,)
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 0.0,
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     decoration: const BoxDecoration(
                //         border: Border(
                //             top: BorderSide(
                //                 color: kBackground,
                //                 width: 2.0
                //             )
                //         ),
                //         color: kBackgroundBottomBar
                //     ),
                //     child: Row(
                //       children: [
                //         Container(
                //           padding: const EdgeInsets.all(10.0),
                //           width: MediaQuery.of(context).size.width * 0.45,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               ShaderMask(
                //                 blendMode: BlendMode.srcIn,
                //                 shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                //                 child: const Icon(
                //                     Icons.message,
                //                     color: kPrimaryLightColor,
                //                     size: 25.0
                //                 ),
                //               ),
                //               const SizedBox(width: 5.0,),
                //               Text(
                //                 'Nhắn tin',
                //                 style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                //               )
                //             ],
                //           ),
                //         ),
                //         Expanded(
                //           child: Container(
                //             padding: const EdgeInsets.all(10.0),
                //             decoration: const BoxDecoration(
                //                 gradient: kDefaultGradient
                //             ),
                //             width: MediaQuery.of(context).size.width * 0.45,
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 const Icon(
                //                     Icons.call,
                //                     color: kTextColor,
                //                     size: 25.0
                //                 ),
                //                 const SizedBox(width: 5.0,),
                //                 Text(
                //                   'Gọi điện',
                //                   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
                //                 )
                //               ],
                //             ),
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                Obx(() => controller.isLoadingRequest.value == true ?
                Positioned(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: kBackground.withOpacity(0.5),
                      child: const Center(child: CircularProgressIndicator()),
                    )) : const SizedBox())
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
        })
    );
  }

  Widget _buildHeader(BuildContext context, Data content){
    return Container(
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            children: [
              content.resources.isNotEmpty ? Obx(() => Container(
                color: kBackground,
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                    CoreUrl.baseImageURL + content.resources[controller.countImage.value].id + content.resources[controller.countImage.value].extension,
                    fit: BoxFit.contain
                ),
              ))  : Container(
                color: kBackground,
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                left: 10.0,
                right: 10.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => controller.nextImage(
                            controller.countImage.value > 0 ?
                            controller.countImage.value - 1 :
                            controller.countImage.value
                        ),
                        icon: Icon(
                          Icons.arrow_circle_left_rounded,
                          size: 25.0,
                          color: Colors.black.withOpacity(0.7),
                        )
                      ),
                      IconButton(
                          onPressed: () => controller.nextImage(
                              controller.countImage.value < (content.resources.length - 1) ?
                              controller.countImage.value + 1 :
                              controller.countImage.value
                          ),
                          icon: Icon(
                              Icons.arrow_circle_right_rounded,
                            size: 25.0,
                            color: Colors.black.withOpacity(0.7),
                          )
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          content.title,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    if(content.type != '')
                      if(content.user.id != AppSettings.getValue(KeyAppSetting.userId))
                        Row(
                          children: [

                              Obx(() => GestureDetector(
                                onTap: () {
                                  if(!controller.selectedProductIDs.contains(content.id)){
                                    controller.selectedProductList.add(content);
                                    controller.selectedProductIDs.add(content.id);
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: !controller.selectedProductIDs.contains(content.id) ? kPrimaryLightColor : kBackground,
                                          width: 2.0
                                      ),
                                      borderRadius: BorderRadius.circular(5.0)
                                  ),
                                  child: Text(
                                    'Thêm',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: !controller.selectedProductIDs.contains(content.id) ? kPrimaryLightColor : kBackground,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )),
                            GestureDetector(
                              onTap: () => controller.funcButton(content.type, content.id, context),
                              child: Container(
                                margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: kPrimaryLightColor,
                                        width: 2.0
                                    ),
                                    borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Text(
                                  content.type == 'Trade' ? 'Trao đổi' :
                                  content.type == 'Sell' ? 'Bán' :
                                  content.type == 'Free' ? 'Miễn phí' :
                                  '',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        )

                  ],
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width,
                //   child: Text(
                //     content.price.toString().split('.').first,
                //     style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                //   ),
                // ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.location_on,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      content.user.address,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.access_time,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      '${FormatDateTime.getHourFormat(content.dateUpdated)} ${FormatDateTime.getDateFormat(content.dateUpdated)}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                    )
                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.verified_user_rounded,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      'Tin đã được kiểm duyệt',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(width: 5.0,),
                    ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                      child: const Icon(
                          Icons.info_outline,
                          color: kPrimaryLightColor,
                          size: 20.0
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDetail(BuildContext context, Data content){
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Mô tả chi tiết',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Obx(() => Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    content.content,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                    maxLines: controller.isMore.value == false ? 2 : 20,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Liên hệ ngay: ${content.user.phoneNumber.substring(0,6).replaceAll(RegExp(r'.'), '*') +
                        content.user.phoneNumber.substring(7,content.user.phoneNumber.length)}',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w400),
                  ),
                ),
                Obx(() {
                  if(controller.isMore.value == true){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Loại sản phẩm: ',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                for(var cont in content.postCategories)...[
                                  TextSpan(
                                      text: cont.category.name,
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w400)),
                                  TextSpan(
                                      text: ', ',
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w400)),
                                ]
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RichText(
                            text: TextSpan(
                              text: 'Mong muốn: ',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                                TextSpan(
                                    text: content.type,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w400)),
                              ],
                            ),
                          ),
                        )

                      ],
                    );
                  }
                  return const SizedBox();
                })
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.isMore.call(controller.isMore.value == false ? true : false),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: kBackground
                      )
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Xem thêm',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                  ),
                  Obx(() => Icon(
                    controller.isMore.value == false ? Icons.arrow_drop_down_outlined : Icons.arrow_drop_up_outlined,
                    color: kPrimaryLightColor,
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildSpecifications(BuildContext context, Data content){
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    'Thông số kỹ thuật',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            'Tình trạng: Đã sử dụng',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                          ),
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: RichText(
                            text: TextSpan(
                              text: 'Loại: ',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                              children: <TextSpan>[
                                for(var cont in content.postCategories)...[
                                  TextSpan(
                                    text: cont.category.name,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),),
                                  TextSpan(
                                    text: ', ',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                // Padding(
                //     padding: const EdgeInsets.only(top: 10.0),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width * 0.4,
                //           child: Text(
                //             'Xuất xứ: Không rõ',
                //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                //           ),
                //         ),
                //         SizedBox(
                //           width: MediaQuery.of(context).size.width * 0.4,
                //           child: Text(
                //             'Mã phụ tùng: In trên box',
                //             style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2, fontWeight: FontWeight.w400),
                //           ),
                //         ),
                //       ],
                //     )
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context, Data content){
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.only(bottom: 10.0),
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: 70.0,
            height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(70.0),
              color: kBackgroundBottomBar,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60.0),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(0.25), spreadRadius: 2, offset: const Offset(0, 4))],
              ),
              child: const CircleAvatar(
                radius: 60.0,
                backgroundImage:
                NetworkImage('https://kpopping.com/documents/1a/3/YongYong-fullBodyPicture.webp?v=7c2a3'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(width: 10.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${content.user.firstName} ${content.user.lastName}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(MyProfilePage.routeName),
                      child: Container(
                        margin: const EdgeInsets.only(top: 5.0, right: 10.0),
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: kPrimaryLightColor,
                            width: 2.0
                          ),
                          borderRadius: BorderRadius.circular(5.0)
                        ),
                        child: Text(
                          'Xem trang',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 15.0,
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    Text(
                      'Cá nhân',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                    ),

                  ],
                ),
                const SizedBox(height: 5.0,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    for(int i = 0; i < 5; i++)
                      const Icon(
                        Icons.star,
                        size: 25.0,
                        color: kSecondaryYellow,
                      ),
                    Text(
                      '5.0',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                    ),
                    Text(
                      ' (4 đánh giá)',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400, color: kPrimaryLightColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtherItem({required BuildContext context, bool isSimilar = false, String name = ''}){
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      color: kBackgroundBottomBar,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isSimilar == false ? 'Tin khác của $name' : 'Tin đăng tương tự',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            'Xem tất cả',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500, color: kPrimaryLightColor),
                          ),
                          const Icon(
                            Icons.arrow_right,
                            color: kPrimaryLightColor,
                            size: 20.0,
                          )
                        ],
                      )

                    ],
                  ),
                ),
                if(isSimilar == false)...[
                  Obx(() {
                    if (controller.isLoadingPersonalPost.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if(controller.personalProductList.value!.isNotEmpty) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for(var cont in controller.personalProductList.value!)
                              GestureDetector(
                                onTap: () => Get.toNamed(ProductDetailPage.routeName),
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10.0, top: 10.0),
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
                  })
                ]else...[
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for(var cont in controller.productModel.value!.data)...[
                          if(cont.isConfirmed == true)...[
                            GestureDetector(
                              onTap: () => Get.toNamed(ProductDetailPage.routeName),
                              child: Container(
                                margin: const EdgeInsets.only(right: 10.0, top: 10.0),
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
                        ]

                      ],
                    ),
                  )
                ]

              ],
            ),
          ),
        ],
      ),
    );
  }
}