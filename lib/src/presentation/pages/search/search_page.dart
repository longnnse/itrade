import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/search/search_controller.dart';
import 'package:i_trade/src/presentation/pages/search/widgets/search_product_shimmer_widget.dart';
import 'package:intl/intl.dart';

import '../../../../core/initialize/core_url.dart';
import '../../../../core/initialize/theme.dart';
import '../home/widgets/product_detail.dart';

class SearchPage extends GetView<SearchController> {
  static const String routeName = '/SearchPage';
  final Widget? leading;
  const SearchPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchController());
    controller.getPosts(pageIndex: 1, pageSize: 20);
    return Scaffold(
        backgroundColor: kBackground,
        body: Column(
          children: [
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderFilter(context),
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
        )
    );
  }

  Widget _buildHeaderFilter(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width,
      color: kBackgroundBottomBar,
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 25.0,
              ),
              const SizedBox(width: 10.0,),
              Text(
                'Khu vực:',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2),
              ),
              const SizedBox(width: 10.0,),
              Row(
                children: [
                  Text(
                    'Tp Hồ Chí Minh',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    size: 20.0,
                  )
                ],
              )
            ],
          ),
          const SizedBox(height: 5.0,),
          Row(
            children: [
              GestureDetector(
                onTap: () => _buildModelBottomFilter(context),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: kBackground,
                      width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.filter_alt_outlined,
                        size: 20.0,
                      ),
                      Text(
                        'Lọc',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10.0,),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: kBackground,
                        width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                ),
                child: Row(
                  children: [
                    Text(
                      'Tất cả danh mục',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20.0,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0,),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: kBackground,
                  borderRadius: BorderRadius.circular(5.0)
                ),
                child: Text(
                  'Giá +',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            ],
          )
        ],
      ),
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
            hintText: 'Nhập sản phẩm cần tìm...',
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
              if (controller.isLoading.value) {
                return const SearchProductShimmerWidget(
                  columnCount: 1,
                );
              }
              if(controller.productModel.value != null) {
                return Column(
                  children: [
                    for(var cont in controller.productModel.value!.data)
                      GestureDetector(
                      onTap: () => controller.goDetail(id: cont.id),
                      child: Container(
                        decoration: const  BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: kBackground
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
                                      fit: BoxFit.fill
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
                                        SizedBox(
                                          child: Text(
                                            '${cont.price.toString().split('.').first} đ',
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                                          ),
                                        )
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
                    )
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
      ),
    );
  }

  void _buildModelBottomFilter(BuildContext context){
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: kBackground))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.close,
                            color: kTextColorGrey,
                            size: 30.0,
                          )),
                      Text(
                        'Lọc kết quả',
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Bỏ lọc',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: kBackground))),
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Danh mục',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            'Thời trang',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(color: kPrimaryLightColor),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: (){},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: kTextColorGrey,
                          size: 20.0,
                        )
                      )
                    ],
                  ),
                ),
               Obx(() =>  Container(
                   decoration: const BoxDecoration(
                       border: Border(
                           bottom: BorderSide(color: kBackground))),
                   padding: const EdgeInsets.all(10.0),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       RichText(
                         text: TextSpan(
                           text: 'Giá từ ',
                           style: Theme.of(context).textTheme.titleMedium,
                           children: <TextSpan>[
                             TextSpan(
                                 text: '${controller.formatNum.format(controller.currentRangeValues.value.start.round())} đ',
                                 style: Theme.of(context)
                                     .textTheme
                                     .titleMedium!
                                     .copyWith(fontWeight: FontWeight.w500)),
                             TextSpan(
                                 text: ' đến ',
                                 style: Theme.of(context)
                                     .textTheme
                                     .titleMedium),
                             TextSpan(
                                 text: '${controller.formatNum.format(controller.currentRangeValues.value.end.round())} đ',
                                 style: Theme.of(context)
                                     .textTheme
                                     .titleMedium!
                                     .copyWith(fontWeight: FontWeight.w500)),
                           ],
                         ),
                       ),
                       RangeSlider(
                         values: controller.currentRangeValues.value,
                         max: 30000000,
                         divisions: 300,
                         // labels: RangeLabels(
                         //   controller.currentRangeValues.value.start.round().toString(),
                         //   controller.currentRangeValues.value.end.round().toString(),
                         // ),
                         onChanged: (RangeValues values) {
                           controller.currentRangeValues.call(values);
                         },
                       )
                     ],
                   )
               ),),

              ],
            ),
          );
        });
  }
}