import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/search/widgets/search_product_shimmer_widget.dart';

import '../../../../../core/initialize/core_url.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../../domain/models/group_post_result_model.dart';
import '../../../widgets/appbar_customize.dart';


class ManageGroupPersonalPage extends GetView<ManageController> {
  static const String routeName = '/ManageGroupPersonalPage';
  final Widget? leading;
  const ManageGroupPersonalPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getGroupPersonal(pageIndex: 1, pageSize: 20);
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Danh sách nhóm sản phẩm trao đổi',
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
              if (controller.isLoadingGroupPersonal.value) {
                return const SearchProductShimmerWidget(
                  columnCount: 1,
                );
              }
              if(controller.managePersonalGroup.value != null){
                if(controller.managePersonalGroup.value!.data.isNotEmpty) {
                  return Column(
                    children: [
                      for(var cont in controller.managePersonalGroup.value!.data)
                        if(cont.groupPosts.isNotEmpty)...[
                          for(var temp in cont.groupPosts)
                          _buildItem(context: context, model: temp, idTraoDoi: cont.id)
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

  Widget _buildItem({required BuildContext context, required GroupPosts model, required String idTraoDoi}){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kBackgroundBottomBar,
      margin: const EdgeInsets.only(top: 10.0),
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
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.2,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: kBackground
                      ),
                      child: model.post.resources.isNotEmpty ? Image.network(
                          CoreUrl.baseImageURL + model.post.resources[0].id + model.post.resources[0].extension,
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
                                      model.post.resources.length.toString(),
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
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.21,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model.post.title,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5.0,),
                        // Text(
                        //   '${model.price.toString().split('.').first} đ',
                        //   style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                        // ),
                        const SizedBox(height: 5.0,),
                        Expanded(
                          child: Text(
                            'Đã đăng ${FormatDateTime.getHourFormat(model.post.dateUpdated)} ${FormatDateTime.getDateFormat(model.post.dateUpdated)}',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: kBackground
              ),
              color: kBackgroundBottomBar,
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width - 10,
                    padding: const EdgeInsets.all(10.0),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.chat,
                          color: kPrimaryLightColor,
                        ),
                        Text(
                          'Trao đổi SP',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 10.0,)
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )

        ],
      ),
    );
  }
}