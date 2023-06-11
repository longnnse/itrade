import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/home/widgets/product_detail.dart';

import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../home_controller.dart';

class ProductListPage extends GetView<HomeController> {
  static const String routeName = '/ProductListPage';
  final Widget? leading;
  const ProductListPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'title',
          isUseOnlyBack: true,
          actionRights: [
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.filter_alt,
                color: Colors.white,
                size: 25.0,
              )
            )
          ]
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Column(
          children: [
            _buildSearch(context: context),
            const SizedBox(height: 10.0,),
            Expanded(child: _buildItemList(context: context))
          ],
        )
    );
  }

  Widget _buildSearch({required BuildContext context}){
    return Container(
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kBackgroundTextField,
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
            contentPadding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
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
    return SingleChildScrollView(
      child: Column(
        children: [
          for(int i = 0; i < 10; i++)
            GestureDetector(
              onTap: () => Get.toNamed(ProductDetailPage.routeName),
              child: Container(
                decoration: const  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: kBackground
                    )
                  )
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
                                    'Cần bán Rick Owen',
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                SizedBox(
                                  child: Text(
                                    '9,500,000 VND',
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
                    )

                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

}