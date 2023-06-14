import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/presentation/pages/search/search_controller.dart';

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
            for(int i = 0; i < 10; i++)
              GestureDetector(
                onTap: () => Get.toNamed(ProductDetailPage.routeName),
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
      ),
    );
  }
  
}