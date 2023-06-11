import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_detail.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_list.dart';

import '../../../../core/initialize/theme.dart';
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildItemButton(context: context, title: 'Đồ điện tử'),
                                _buildItemButton(context: context, title: 'Quần/áo'),
                                _buildItemButton(context: context, title: 'Phụ kiện'),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildItemButton(context: context, title: 'Gia dụng'),
                                _buildItemButton(context: context, title: 'Sách'),
                                _buildItemButton(context: context, title: 'Miễn phí'),
                              ],
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Deals tốt mỗi ngày',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 10.0,),
                      _buildItemGridView(context: context)
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
        )
    );
  }

  Widget _buildItemButton({required BuildContext context, required String title}){
    return GestureDetector(
      onTap: () {
        //controller.title.call(title);
        Get.toNamed(ProductListPage.routeName);
      },
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
              color: kBackground
            ),
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget _buildItemGridView({required BuildContext context}){
    return GridView.count(
      primary: true,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        for(int i = 0; i < 10; i++)
          GestureDetector(
            onTap: () => Get.toNamed(ProductDetailPage.routeName),
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
                                      '6',
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
                      'Cần bán Rick Owen',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      '9,500,000 VND',
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
                              Icons.person,
                              color: kPrimaryLightColor,
                              size: 15.0
                          ),
                        ),
                        Flexible(
                          child: Text(
                            '2 giờ trước - Tp.Hồ Chí Minh',
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
    );
  }
}