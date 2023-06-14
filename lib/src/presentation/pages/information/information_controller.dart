import 'package:get/get.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/bao_cao_vi_pham_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_feedback_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/vi_cua_toi_page.dart';

import '../change_password/change_password_page.dart';
import '../edit_profile/edit_profile_page.dart';
import 'widgets/iTrade_policy_page.dart';

class InformationController extends GetxController {
  RxString title = ''.obs;
  RxBool isBuyer = true.obs;
  RxBool isShow = true.obs;
  RxBool isMore = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void updateStatus(bool isChange){
    isBuyer.call(isChange == true ? true : false);
  }

  void updateStatusProfileTab(bool isChange){
    isShow.call(isChange == true ? true : false);
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