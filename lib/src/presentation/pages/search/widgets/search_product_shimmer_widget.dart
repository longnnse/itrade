import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/initialize/theme.dart';

class SearchProductShimmerWidget extends StatelessWidget {
  final int columnCount;
  const SearchProductShimmerWidget(
      {Key? key, required this.columnCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            3, (index) => ItemSearchShimmerWidget(columnCount: columnCount))
      ],
    );
  }
}

class ItemSearchShimmerWidget extends StatelessWidget {
  final int columnCount;
  const ItemSearchShimmerWidget({Key? key, required this.columnCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(right:10.0, left: 10.0, top: 10.0),
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...List.generate(
            columnCount,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300] as Color,
              highlightColor: Colors.grey[200] as Color,
              child: SizedBox(
                width: Get.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right:0.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
                          color: Colors.white
                      ),
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          for(int i = 0; i < 3; i++)
                            Container(
                              margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: Colors.white
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: 20.0,
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
