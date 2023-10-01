import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/format_datetime.dart';
import 'package:i_trade/src/presentation/pages/home/home_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_product_shimmer_widget.dart';

import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';

class NotiPage extends GetView<HomeController> {
  static const String routeName = '/NotiPage';
  final Widget? leading;
  const NotiPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ManageController());
    controller.getNoti(pageIndex: 1, pageSize: 99);
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
            context: context,
            title: 'Danh sách thông báo',
            isUseOnlyBack: true,
        ),
        backgroundColor: kBackground,
        body: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        if (controller.isNotiResultLoading.value) {
                          return const ManageProductShimmerWidget(
                            columnCount: 1,
                          );
                        }
                        if(controller.notiResult.value != null) {
                          return Column(
                            children: [
                              if(controller.notiResult.value!.data!.isNotEmpty)...[
                                for(var cont in controller.notiResult.value!.data!)
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: kBackground
                                        )
                                      ),
                                      color: kBackgroundBottomBar
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25.0,
                                          backgroundColor: Colors.transparent,
                                          child: ClipOval(
                                            child: Image.network(CoreUrl.baseAvaURL + cont.fromUser!.userAva!,
                                            fit: BoxFit.cover,),
                                          ),
                                        ),
                                        const SizedBox(width: 10.0,),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cont.action == 'Trade' ? 'Thông báo trao đổi' : 'Thông báo khác',
                                                style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w700),
                                              ),
                                              Text(
                                                cont.content!,
                                                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                                              ),
                                              if(cont.description != '')
                                                Text(
                                                  cont.description!,
                                                  style: Theme.of(context).textTheme.titleMedium,
                                                ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.access_time_outlined,
                                                    size: 20.0,
                                                    color: kTextColorGrey,
                                                  ),
                                                  Text(
                                                    '${FormatDateTime.getHourFormat(cont.dateCreated!)} ${FormatDateTime.getDateFormat(cont.dateCreated!)}',
                                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: kTextColorGrey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                          Icons.circle_notifications,
                                          size: 20.0,
                                          color: kSecondaryRed,
                                        ),
                                      ],
                                    ),
                                  )
                              ]else...[
                                Center(
                                    child: Text(
                                      'Không có dữ liệu',
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, color: kSecondaryRed),
                                    )
                                )
                              ]

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

                    ],
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
        ));
  }
}