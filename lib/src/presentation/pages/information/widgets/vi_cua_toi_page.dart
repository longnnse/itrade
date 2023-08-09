import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/initialize/theme.dart';
import '../../../widgets/appbar_customize.dart';
import '../information_controller.dart';
import 'package:momo_vn/momo_vn.dart';

class ViCuaToiPage extends GetView<InformationController> {
  static const String routeName = '/ViCuaToiPage';
  final Widget? leading;
  const ViCuaToiPage({
    Key? key,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.momoPay = MomoVn();
    controller.momoPay.on(MomoVn.EVENT_PAYMENT_SUCCESS, controller.handlePaymentSuccess);
    controller.momoPay.on(MomoVn.EVENT_PAYMENT_ERROR, controller.handlePaymentError);
    return Scaffold(
        appBar: AppbarCustomize.buildAppbar(
          context: context,
          title: controller.title.value,
          isUseOnlyBack: true,
        ),
        backgroundColor: kBackgroundBottomBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                height: MediaQuery.of(context).size.height * 0.25,
                color: kBackground,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Liên kết ví ngân hàng',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20.0,),
                    RichText(
                      text: TextSpan(
                        text: 'Sau khi',
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                              text: ' Liên kết Ví',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w900)),
                          TextSpan(
                              text: ' thành công, tin đăng của bạn sẽ được kích hoạt tính năng ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: ' “Thanh toán Đảm bảo” ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w900)),
                          TextSpan(
                              text: 'cho phép người mua có thẻ thanh toán trực tuyến cho sản phẩm của bạn qua ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(fontWeight: FontWeight.w400)),
                          TextSpan(
                              text: 'ITrade',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w900)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0,),
                    TextButton(
                      // color: Colors.blue,
                      // textColor: Colors.white,
                      // disabledColor: Colors.grey,
                      // disabledTextColor: Colors.black,
                      // padding: EdgeInsets.all(8.0),
                      // splashColor: Colors.blueAccent,
                      child: const Text('DEMO PAYMENT WITH MOMO.VN'),
                      onPressed: () async {
                        MomoPaymentInfo options = MomoPaymentInfo(
                            merchantName: "TTN",
                            appScheme: "MOxx",
                            merchantCode: 'MOxx',
                            partnerCode: 'Mxx',
                            amount: 60000,
                            orderId: '12321312',
                            orderLabel: 'Gói combo',
                            merchantNameLabel: "HLGD",
                            fee: 10,
                            description: 'Thanh toán combo',
                            username: '01234567890',
                            partner: 'merchant',
                            extra: "{\"key1\":\"value1\",\"key2\":\"value2\"}",
                            isTestMode: true
                        );
                        try {
                          controller.momoPay.open(options);
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                    ),
                    Obx(() => Text(controller.paymentStatus.value.isEmpty ? "CHƯA THANH TOÁN" : controller.paymentStatus.value)),
                    _buildConnectWallet(context),
                    const SizedBox(height: 20.0,),
                    Text(
                      'Lưu ý: bạn chỉ nhận được thanh toán khi đã xác thực đầy đủ thông tin(CMND/CCCD/ Hộ chiếu và Tài Khoản Ngân Hàng) '
                          'mà ví điện tử đó yêu cầu.',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: kTextColorGrey2 ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
  
  Widget _buildConnectWallet(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: kBackground,
          width: 1.5
        )
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBackground
                )
              )
            ),
            child: Row(
              children: [
                Container(
                  width: 50.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: kBackground,
                    boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))]
                  ),
                ),
                const SizedBox(width: 10.0,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Momo',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const Icon(
                            Icons.check_circle,
                            color: kSecondaryGreen,
                            size: 20.0,
                          )
                        ],
                      ),
                      Text(
                        '*******321',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.cancel,
                    color: kTextColorGrey,
                  )
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: kSecondaryGreen,
                  size: 20.0,
                ),
                Text(
                  'Cho phép thanh toán: ',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: kBackground,
                      boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(0.25), spreadRadius: 1, offset: const Offset(2, 3))]
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

}
