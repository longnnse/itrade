import 'package:get/get.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/bao_cao_vi_pham_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_feedback_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/vi_cua_toi_page.dart';

import '../../../../core/initialize/theme.dart';
import '../../../../core/utils/app_settings.dart';
import '../change_password/change_password_page.dart';
import '../edit_profile/edit_profile_page.dart';
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
  @override
  void onInit() {
    super.onInit();
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
  }

  Future<void> onButtonClick() async {
    if(AppSettings.getValue(KeyAppSetting.isDangNhap) == true){
      AppSettings.clearAllSharePref();

    }
    final result = await Get.toNamed(LoginPage.routeName);
    if(result == true){
      checkInfoUser();
    }
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
        Get.toNamed(ChangePasswordPage.routeName);
        break;
    }
  }
}