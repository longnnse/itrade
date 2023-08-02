import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/home_category_shimmer_widget.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/home_product_shimmer_widget.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_detail.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_list.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/models/category_model.dart';
import '../upload_post/upload_post_page.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  static const String routeName = '/HomePage';
  final Widget? leading;
  const HomePage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    controller.getCategories(pageIndex: 1, pageSize: 10);
    controller.getPosts(pageIndex: 1, pageSize: 20, categoryIds: '');
    return Scaffold(
        backgroundColor: kBackgroundBottomBar,
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Khám phá danh mục',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          children: [
                            Obx(() {
                              if (controller.isLoading.value) {
                                return const HomeCategoryShimmerWidget(
                                  columnCount: 3,
                                );
                              }
                              if(controller.categoryList.value!.isNotEmpty) {
                                return GridView.count(
                                    shrinkWrap: true,
                                    primary: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                    children: List.generate(controller.categoryList.value!.length, (index) {
                                      return _buildItemButton(context: context, title: controller.categoryList.value![index].name, cont: controller.categoryList.value![index]);
                                    }));
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
                      Text(
                        'Nổi bật',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0,),
                      Obx(() {
                        if (controller.isLoadingProduct.value) {
                          return const HomeProductShimmerWidget(
                            columnCount: 2,
                          );
                        }
                        if(controller.productModel.value != null) {
                          return _buildItemGridView(context: context, productModel: controller.productModel.value!);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(UploadPostPage.routeName),
        backgroundColor: kPrimaryLightColor,
        child: const Icon(
            Icons.upload
        ),
      ),
    );
  }

  Widget _buildItemButton({required BuildContext context, required String title, required CategoryModel cont}){
    return GestureDetector(
      onTap: () {
        controller.title.call(title);
        controller.idCate.call(cont.id);
        Get.toNamed(ProductListPage.routeName);
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            margin: const EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
              color: kBackground
            ),
            child: cont.id.isNotEmpty ? Image.network(
                CoreUrl.baseCateURL + cont.img,
                fit: BoxFit.fill
            ) : const SizedBox(),
          ),
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildItemGridView({required BuildContext context, required ProductModel productModel}){
    return GridView.count(
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        for(var cont in productModel.data)
          if(cont.isConfirmed == true)...[
            GestureDetector(
              onTap: () => controller.goDetail(id: cont.id),
              child: Padding(
                padding: const EdgeInsets.all(0),
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
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Text(
                        '${cont.price.toString().split('.').first} đ',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kSecondaryRed, fontWeight: FontWeight.w700),
                      ),
                    ),
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
            )
          ]

      ],
    );
  }
}