import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/main.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/widgets/edit_password_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/bao_cao_vi_pham_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_feedback_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/vi_cua_toi_page.dart';
import 'package:momo_vn/momo_vn.dart';

import '../../../../core/initialize/theme.dart';
import '../../../../core/utils/app_settings.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/models/request_post_result_model.dart';
import '../../../domain/services/manage_service.dart';
import '../edit_profile/edit_profile_page.dart';
import '../home/home_controller.dart';
import '../login/login_page.dart';
import '../upload_post/upload_post_page.dart';
import 'widgets/iTrade_policy_page.dart';

class InformationController extends GetxController {
  RxString title = ''.obs;
  RxBool isBuyer = true.obs;
  RxBool isShow = true.obs;
  RxBool isMore = false.obs;
  RxString fullName = 'ITrade'.obs;
  RxString aud = ''.obs;
  RxString email = ''.obs;
  RxString phoneNumber = ''.obs;
  RxString urlLink = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDK4gXyt3wzCyT9ekbDsR-thEKFtWuQoFraQ&usqp=CAU'.obs;
  RxString buttonTxt = 'Đăng nhập'.obs;
  final RxBool isLoadingPersonalPost = false.obs;
  final RxBool isLoadingRequestReceived = false.obs;
  final ManageService _manageService = Get.find();
  final Rxn<List<Data>> personalProductList = Rxn<List<Data>>();
  final Rxn<RequestPostResultModel> requestReceivedLst = Rxn<RequestPostResultModel>();
  late MomoVn momoPay;
  late PaymentResponse momoPaymentResult;
  RxString paymentStatus = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void setStatusValue() {
    paymentStatus.call('Đã chuyển thanh toán');
    if (momoPaymentResult.isSuccess == true) {
      paymentStatus.value += "\nTình trạng: Thành công.";
      paymentStatus.value += "\nSố điện thoại: ${momoPaymentResult.phoneNumber}";
      paymentStatus.value += "\nExtra: ${momoPaymentResult.extra!}";
      paymentStatus.value += "\nToken: ${momoPaymentResult.token}";
    }
    else {
      paymentStatus.value += "\nTình trạng: Thất bại.";
      paymentStatus.value += "\nExtra: ${momoPaymentResult.extra}";
      paymentStatus.value += "\nMã lỗi: ${momoPaymentResult.status}";
    }
  }

  void handlePaymentSuccess(PaymentResponse response) {
    momoPaymentResult = response;
    setStatusValue();
    Get.snackbar('Thông báo', "THÀNH CÔNG: ${response.phoneNumber}", backgroundColor: kSecondaryGreen, colorText: kTextColor);
  }

  void handlePaymentError(PaymentResponse response) {
    momoPaymentResult = response;
    setStatusValue();
    Get.snackbar('Thông báo', "THẤT BẠI: ${response.message}", backgroundColor: kSecondaryRed, colorText: kTextColor);
  }

  Future<void> getPersonalPosts() async {
    //TODO use test
    isLoadingPersonalPost.call(true);
    final Either<ErrorObject, List<Data>> res = await _manageService.getPersonalPosts();

    res.fold(
          (failure) {

        isLoadingPersonalPost.call(false);
      },
          (value) async {

        personalProductList.call(value);
        isLoadingPersonalPost.call(false);
      },
    );
  }

  Future<void> getRequestReceived() async {
    //TODO use test
    isLoadingRequestReceived.call(true);
    final Either<ErrorObject, RequestPostResultModel> res = await _manageService.getRequestReceived();

    res.fold(
          (failure) {
        isLoadingRequestReceived.call(false);
      },
          (value) async {
        requestReceivedLst.call(value);
        isLoadingRequestReceived.call(false);
      },
    );
  }

  void checkInfoUser(){

    fullName.call(AppSettings.getValue(KeyAppSetting.fullName) != '' ? AppSettings.getValue(KeyAppSetting.fullName) : 'ITrade');
    aud.call(AppSettings.getValue(KeyAppSetting.aud) != '' ? AppSettings.getValue(KeyAppSetting.aud) :  'Buy, sell and trade');
    email.call(AppSettings.getValue(KeyAppSetting.email));
    phoneNumber.call(AppSettings.getValue(KeyAppSetting.phoneNumber));
    urlLink.call(AppSettings.getValue(KeyAppSetting.isDangNhap) == true ? 'https://kpopping.com/documents/1a/3/YongYong-fullBodyPicture.webp?v=7c2a3'
        : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSDK4gXyt3wzCyT9ekbDsR-thEKFtWuQoFraQ&usqp=CAU');
    buttonTxt.call((AppSettings.getValue(KeyAppSetting.isDangNhap) == false ||
        AppSettings.getValue(KeyAppSetting.isDangNhap) == null) ? 'Đăng nhập' : 'Đăng xuất');
  }

  void updateStatus(bool isChange){
    isBuyer.call(isChange == true ? true : false);
  }

  void updateStatusProfileTab(bool isChange){
    isShow.call(isChange == true ? true : false);
    if(isShow.value == true){
      getPersonalPosts();
    }else{
      getRequestReceived();
    }
  }

  Future<void> onButtonClick() async {
    // if(AppSettings.getValue(KeyAppSetting.isDangNhap) == true){
    //
    // }
    HomeController ctl = Get.find();
    ctl.selectedProductList.clear();
    ctl.selectedMyProductList.clear();
    ctl.selectedMyProductIDs.clear();
    AppSettings.clearAllSharePref();
    Get.offNamedUntil('LoginPage', (route) => false);
    // final result = Get.toNamed(LoginPage.routeName);
    // if(result == true){
    //   checkInfoUser();
    // }
  }

  void goPostProduct(){
    if(AppSettings.getValue(KeyAppSetting.isDangNhap) == true){
      Get.toNamed(UploadPostPage.routeName);
    }else{
      Get.snackbar('Thông báo', 'Vui lòng đăng nhập để đăng bài', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }



  void updateTitle(ITradePolicy policy){
    switch (policy){
      case ITradePolicy.chinhSachBaoMat:
        title.call('Chính sách bảo mật');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.dieuKhoanSuDung:
        title.call('Điều khoản sử dụng');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.huongDanSuDung:
        title.call('Hướng dẫn sử dụng');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.thongTinUngDung:
        title.call('Thông tin ứng dụng');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.viCuaToi:
        title.call('Ví của tôi');
        Get.toNamed(ViCuaToiPage.routeName);
        break;
      case ITradePolicy.baoCaoViPham:
        title.call('Báo cáo vi phạm');
        Get.toNamed(BaoCaoViPhamPage.routeName);
        break;
      case ITradePolicy.danhGiaTuToi:
        title.call('Chờ đánh giá');
        Get.toNamed(MyFeedbackPage.routeName);
        break;
    }
  }

  void goProfle(ProfileEnums profileEnums){
    switch (profileEnums){
      case ProfileEnums.edit:
        Get.toNamed(EditProfilePage.routeName);
        break;
      case ProfileEnums.camera:
        Get.toNamed(EditProfilePage.routeName);
        break;
      case ProfileEnums.lock:
        Get.toNamed(EditPasswordPage.routeName);
        break;
    }
  }
}