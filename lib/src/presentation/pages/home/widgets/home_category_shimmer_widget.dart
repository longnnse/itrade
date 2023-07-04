import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/initialize/theme.dart';

class HomeCategoryShimmerWidget extends StatelessWidget {
  final int columnCount;
  const HomeCategoryShimmerWidget(
      {Key? key, required this.columnCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   margin: const EdgeInsets.only(top: 10.0),
        //   width: Get.width,
        //   child: Column(
        //     children: [
        //       // const SizedBox(
        //       //   height: 4.0,
        //       // ),
        //       // Padding(
        //       //   padding:
        //       //       const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
        //       //   child: Row(
        //       //     crossAxisAlignment: CrossAxisAlignment.end,
        //       //     children: [
        //       //       Shimmer.fromColors(
        //       //         baseColor: Colors.grey[300] as Color,
        //       //         highlightColor: Colors.grey[200] as Color,
        //       //         child: Container(
        //       //           width: 25,
        //       //           height: 25,
        //       //           color: Colors.white,
        //       //         ),
        //       //       ),
        //       //       const SizedBox(
        //       //         width: 4.0,
        //       //       ),
        //       //       Shimmer.fromColors(
        //       //         baseColor: Colors.grey[300] as Color,
        //       //         highlightColor: Colors.grey[200] as Color,
        //       //         child: Container(
        //       //           width: 100,
        //       //           height: 20,
        //       //           color: Colors.white,
        //       //         ),
        //       //       ),
        //       //     ],
        //       //   ),
        //       // ),
        //       Padding(
        //         padding: const EdgeInsets.symmetric(vertical: 5.0),
        //         child: Row(
        //           children: [
        //             // const Spacer(),
        //             ...List.generate(
        //               columnCount,
        //               (index) => Shimmer.fromColors(
        //                 baseColor: Colors.grey[300] as Color,
        //                 highlightColor: Colors.grey[200] as Color,
        //                 child: Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 20),
        //                   child: Container(
        //                     width: 40,
        //                     height: 20,
        //                     color: Colors.white,
        //                   ),
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        ...List.generate(
            2, (index) => ItemHomeCategoryShimmerWidget(columnCount: columnCount))
      ],
    );
  }
}

class ItemHomeCategoryShimmerWidget extends StatelessWidget {
  final int columnCount;
  const ItemHomeCategoryShimmerWidget({Key? key, required this.columnCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5.0),
          //   child: Shimmer.fromColors(
          //     baseColor: Colors.grey[300] as Color,
          //     highlightColor: Colors.grey[200] as Color,
          //     child: Container(
          //       height: 20,
          //       width: 100,
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
          // const Spacer(),
          ...List.generate(
            columnCount,
            (index) => Shimmer.fromColors(
              baseColor: Colors.grey[300] as Color,
              highlightColor: Colors.grey[200] as Color,
              child: SizedBox(
                width: Get.width * 0.3,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
                      color: Colors.white
                    ),
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
