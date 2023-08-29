import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_controller.dart';
import 'package:i_trade/src/presentation/pages/home/home_controller.dart';
import 'package:i_trade/src/presentation/widgets/FABBottomAppBar.dart';
import 'package:i_trade/src/presentation/widgets/appbar_customize.dart';
import 'package:i_trade/src/presentation/widgets/floating_action_button.dart';

import '../../../../core/initialize/theme.dart';
import '../home/widgets/multi_trade_cart_product_page.dart';
import '../home/widgets/noti_page.dart';


class DashboardPage extends GetView<DashboardController> {
  static const String routeName = '/DashboardPage';
  final Widget? leading;
  const DashboardPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    HomeController ctrler = Get.find();
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Obx(() => Scaffold(
        appBar: controller.lastSelected.value != 'TAB: 4' ? AppbarCustomize.buildAppbar(
          context: context,
          title: controller.appBarTitle.value,
          isUseOnlyBack: false,
          actionRights: [
            // if(controller.lastSelected.value == 'TAB: 0')
            //   IconButton(
            //       onPressed: () => Get.toNamed(UploadPostPage.routeName),
            //       icon: const Icon(
            //         Icons.upload,
            //         color: Colors.white,
            //         size: 25.0,
            //       )
            //   ),
            Stack(
              children: [
                IconButton(
                    onPressed: () => Get.toNamed(MultiCartProductPage.routeName),
                    icon: const Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 25.0,
                    )
                ),
                Positioned(
                  right: 0.0,
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    padding: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      color: kSecondaryRed
                    ),
                    child: Text(
                      '${ctrler.selectedProductList.length}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )
                )
              ],
            ),
            // if(controller.lastSelected.value == 'TAB: 0' || controller.lastSelected.value == 'TAB: 1')
            //   IconButton(
            //       onPressed: () => _buildModelBottomFilter(context),
            //       icon: const Icon(
            //         Icons.filter_alt,
            //         color: Colors.white,
            //         size: 25.0,
            //       )
            //   ),
            IconButton(
              onPressed: () => Get.toNamed(NotiPage.routeName),
              icon: const Icon(
                Icons.notifications,
                color: Colors.white,
                size: 25.0,
              )
            )
          ]
        ) : null,
        floatingActionButtonLocation: CenterDockedFloatingActionButtonLocation(controller.itemCount.value),
        floatingActionButton: FloatingActionButton(
          heroTag: "btn1",
          onPressed: () {},
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: kDefaultGradient,
            ),
            child: controller.icon.value,
          ),
        ),
        backgroundColor: kBackground,
        bottomNavigationBar: FABBottomAppBar(
            items: [
              FABBottomAppBarItem(iconData: Icons.home, text: 'Trang chủ'),
              FABBottomAppBarItem(iconData: Icons.dashboard, text: 'Quản lý'),
              FABBottomAppBarItem(iconData: Icons.list_alt, text: 'Trao đổi'),
              FABBottomAppBarItem(iconData: Icons.search, text: 'Tìm kiếm'),
              FABBottomAppBarItem(iconData: Icons.person, text: 'Cá nhân'),
            ],
            backgroundColor: kBackgroundBottomBar,
            color: kPrimaryLightColor,
            selectedColor: kPrimaryLightColor,
            notchedShape: const CircularNotchedRectangle(),
            onTabSelected: controller.selectedTab
        ),
        body: Obx(
            () => controller.changePage()
        ),
      )),
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
                // Obx(() =>  Container(
                //     decoration: const BoxDecoration(
                //         border: Border(
                //             bottom: BorderSide(color: kBackground))),
                //     padding: const EdgeInsets.all(10.0),
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         RichText(
                //           text: TextSpan(
                //             text: 'Giá từ ',
                //             style: Theme.of(context).textTheme.titleMedium,
                //             children: <TextSpan>[
                //               TextSpan(
                //                   text: '${controller.formatNum.format(controller.currentRangeValues.value.start.round())} đ',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleMedium!
                //                       .copyWith(fontWeight: FontWeight.w500)),
                //               TextSpan(
                //                   text: ' đến ',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleMedium),
                //               TextSpan(
                //                   text: '${controller.formatNum.format(controller.currentRangeValues.value.end.round())} đ',
                //                   style: Theme.of(context)
                //                       .textTheme
                //                       .titleMedium!
                //                       .copyWith(fontWeight: FontWeight.w500)),
                //             ],
                //           ),
                //         ),
                //         RangeSlider(
                //           values: controller.currentRangeValues.value,
                //           max: 30000000,
                //           divisions: 300,
                //           // labels: RangeLabels(
                //           //   controller.currentRangeValues.value.start.round().toString(),
                //           //   controller.currentRangeValues.value.end.round().toString(),
                //           // ),
                //           onChanged: (RangeValues values) {
                //             controller.currentRangeValues.call(values);
                //           },
                //         )
                //       ],
                //     )
                // ),),

              ],
            ),
          );
        });
  }

}
