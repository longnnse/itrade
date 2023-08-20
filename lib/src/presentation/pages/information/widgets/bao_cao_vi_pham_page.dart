import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../information_controller.dart';


class BaoCaoViPhamPage extends GetView<InformationController> {
  static const String routeName = '/BaoCaoViPhamPage';
  final Widget? leading;
  const BaoCaoViPhamPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: 'Báo cáo bài đăng',
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: Text(
                    'Vui lòng nhập nội dung báo cáo kèm hình ảnh/video (nếu có)',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                        color: kBackground
                    ),
                    color: kBackgroundBottomBar,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))],
                  ),
                  child: TextFormField(
                    //initialValue: number.toString(),
                    controller: controller.reportController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                        disabledBorder: InputBorder.none,
                        hintText: 'Nhập nội dung báo cáo...',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: kTextColorGrey)),
                    onChanged: (value) {},
                    onFieldSubmitted: (value) {},
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Container(
                //         padding: const EdgeInsets.all(20.0),
                //         decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(5.0),
                //             border: Border.all(
                //                 color: kPrimaryLightColor,
                //                 style: BorderStyle.solid
                //             ),
                //             color: kBackground
                //         ),
                //         width: MediaQuery.of(context).size.width,
                //         child: ShaderMask(
                //           blendMode: BlendMode.srcIn,
                //           shaderCallback: (Rect bounds) => kDefaultIconGradient.createShader(bounds),
                //           child: const Icon(
                //               Icons.camera_alt,
                //               color: kPrimaryLightColor,
                //               size: 50.0
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                _buildButton(context)
              ],
            ),
            Obx(() => controller.isLoadingReport.value == true ?
            Positioned(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: kBackground.withOpacity(0.5),
                  child: const Center(child: CircularProgressIndicator()),
                )) : const SizedBox())
          ],
        ));
  }

  Widget _buildButton(BuildContext context){
    return Column(
      children: [
        GestureDetector(
          onTap: () => controller.postSendReport(context),
          child: Container(
            padding: const EdgeInsets.all(13.0),
            margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                gradient: kDefaultGradient
            ),
            child: Text(
              'Gửi báo cáo',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColor, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
