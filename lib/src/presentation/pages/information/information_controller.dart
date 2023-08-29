import 'dart:io';

import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/enums/enums.dart';
import 'package:i_trade/src/domain/models/login_model.dart';
import 'package:i_trade/src/domain/services/login_service.dart';
import 'package:i_trade/src/presentation/pages/dashboard/dashboard_page.dart';
import 'package:i_trade/src/presentation/pages/edit_profile/widgets/edit_password_page.dart';
import 'package:i_trade/src/presentation/pages/information/information_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/bao_cao_vi_pham_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/my_feedback_page.dart';
import 'package:i_trade/src/presentation/pages/information/widgets/vi_cua_toi_page.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:momo_vn/momo_vn.dart';

import '../../../../core/initialize/core_images.dart';
import '../../../../core/initialize/core_url.dart';
import '../../../../core/initialize/theme.dart';
import '../../../../core/utils/app_settings.dart';
import '../../../domain/models/product_model.dart';
import '../../../domain/models/request_post_result_model.dart';
import '../../../domain/models/request_result_model.dart';
import '../../../domain/models/update_ava_result_model.dart';
import '../../../domain/services/manage_service.dart';
import '../dashboard/dashboard_controller.dart';
import '../edit_profile/edit_profile_page.dart';
import '../home/home_controller.dart';
import '../upload_post/upload_post_page.dart';
import 'widgets/iTrade_policy_page.dart';

class InformationController extends GetxController {
  RxString title = ''.obs;
  RxString desc = ''.obs;
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
  final RxBool isLoadingReport = false.obs;
  final RxBool isLoadingUpdateAva = false.obs;
  final ManageService _manageService = Get.find();
  final LoginService _loginService = Get.find();
  final Rxn<List<Data>> personalProductList = Rxn<List<Data>>();
  final Rxn<RequestPostResultModel> requestReceivedLst = Rxn<RequestPostResultModel>();
  final Rxn<RequestResultModel> responseReport = Rxn<RequestResultModel>();
  final TextEditingController reportController = TextEditingController();
  // late MomoVn momoPay;
  final ImagePicker picker = ImagePicker();
  Rxn<File> file = Rxn<File>();
  // late PaymentResponse momoPaymentResult;
  RxString paymentStatus = ''.obs;
  RxString postID = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  // void setStatusValue() {
  //   paymentStatus.call('Đã chuyển thanh toán');
  //   if (momoPaymentResult.isSuccess == true) {
  //     paymentStatus.value += "\nTình trạng: Thành công.";
  //     paymentStatus.value += "\nSố điện thoại: ${momoPaymentResult.phoneNumber}";
  //     paymentStatus.value += "\nExtra: ${momoPaymentResult.extra!}";
  //     paymentStatus.value += "\nToken: ${momoPaymentResult.token}";
  //   }
  //   else {
  //     paymentStatus.value += "\nTình trạng: Thất bại.";
  //     paymentStatus.value += "\nExtra: ${momoPaymentResult.extra}";
  //     paymentStatus.value += "\nMã lỗi: ${momoPaymentResult.status}";
  //   }
  // }

  // void handlePaymentSuccess(PaymentResponse response) {
  //   momoPaymentResult = response;
  //   setStatusValue();
  //   Get.snackbar('Thông báo', "THÀNH CÔNG: ${response.phoneNumber}", backgroundColor: kSecondaryGreen, colorText: kTextColor);
  // }
  //
  // void handlePaymentError(PaymentResponse response) {
  //   momoPaymentResult = response;
  //   setStatusValue();
  //   Get.snackbar('Thông báo', "THẤT BẠI: ${response.message}", backgroundColor: kSecondaryRed, colorText: kTextColor);
  // }

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

  Future<void> postSendReport(BuildContext context) async {
    //TODO use test
    isLoadingReport.call(true);
    final Either<ErrorObject, RequestResultModel> res =
          await _manageService.postSendReport(postId: postID.value, description: reportController.text);

    res.fold(
          (failure) {
            Get.snackbar('Thông báo', 'Không thể báo có do lỗi hoặc bạn đã báo cáo rồi', backgroundColor: kSecondaryRed, colorText: kTextColor);
            isLoadingReport.call(false);
      },
          (value) async {
        reportController.clear();
        Get.snackbar('Thông báo', 'Báo cáo thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        responseReport.call(value);
        isLoadingReport.call(false);
        Navigator.pop(context);
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
    DashboardController ctlDB = Get.find();
    ctlDB.selectedTab(0);
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
        title.call('Chính sách sử dụng');
        desc.call('Chính sách bảo mật: Xác định cách thông tin người dùng được thu thập, lưu trữ và bảo vệ.\n\n'
            'Chính sách thanh toán: Quy định về các phương thức thanh toán, quy trình hoàn tiền và bảo mật giao dịch.\n\n'
            'Chính sách về sản phẩm và dịch vụ: Xác định các quy tắc và tiêu chuẩn đối với hàng hóa, dịch vụ và người bán/truyền thông.');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.dieuKhoanSuDung:
        title.call('Điều khoản sử dụng');
        desc.call('Điều kiện và quy định: Liệt kê các điều khoản mà người dùng phải tuân thủ khi sử dụng hệ thống, bao gồm quy định về vi phạm bản quyền, việc trao đổi thông tin giữa người dùng và trách nhiệm của mỗi bên.\n\n'
            'Quản lý tài khoản: Mô tả quy trình đăng ký, đăng nhập, và quản lý tài khoản cá nhân cho người dùng và người bán/truyền thông.\n\n'
            'Giới hạn trách nhiệm: Xác định trách nhiệm của hệ thống và người dùng trong việc đảm bảo tính toàn vẹn và bảo mật thông tin, cũng như giới hạn trách nhiệm pháp lý.');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.huongDanSuDung:
        title.call('Hướng dẫn sử dụng');
        desc.call('Đăng ký và bắt đầu: Cung cấp hướng dẫn cho người dùng về cách tạo tài khoản và bắt đầu sử dụng hệ thống.\n\n'
            'Tìm kiếm và mua hàng: Hướng dẫn người dùng về cách tìm kiếm sản phẩm, xem thông tin chi tiết, đặt hàng và thanh toán.\n\n'
            'Quản lý tài khoản: Giúp người dùng hiểu cách cập nhật thông tin cá nhân, xem lịch sử giao dịch và quản lý danh sách yêu thích.\n\n'
            'Đánh giá và phản hồi: Hướng dẫn người dùng về cách đánh giá sản phẩm, đánh giá người bán/truyền thông và gửi phản hồi.');
        Get.toNamed(ITradePolicyPage.routeName);
        break;
      case ITradePolicy.thongTinUngDung:
        title.call('Thông tin ứng dụng');
        desc.call('Mô tả tổng quan: Cung cấp thông tin về mục đích, tính năng và lợi ích của hệ thống trao đổi hàng hóa trực tuyến.\n\n'
            'Các chức năng chính: Liệt kê các tính năng cung cấp cho người dùng, bao gồm tìm kiếm sản phẩm, đặt hàng, thanh toán, đánh giá và đánh giá người bán/truyền thông.\n\n'
            'Giao diện người dùng: Miêu tả cách người dùng tương tác với giao diện ứng dụng, bao gồm các trang, nút và hướng dẫn sử dụng.');
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

  void goProfle(ProfileEnums profileEnums, BuildContext context) async {
    switch (profileEnums){
      case ProfileEnums.edit:
        var result = await Get.toNamed(EditProfilePage.routeName);
        if(result == true){
          checkInfoUser();
        }
        break;
      case ProfileEnums.camera:
        mediaSelection(index: 1, context: context);
        break;
      case ProfileEnums.lock:
        Get.toNamed(EditPasswordPage.routeName);
        break;
    }
  }


  Future<void> postUpdateAva(BuildContext context, File file) async {
    //TODO use test
    isLoadingUpdateAva.call(true);
    List<File> lstFile = [];
    lstFile.add(file);
    final Either<ErrorObject, UpdateAvaResultModel> res =
      await _loginService.postUpdateAva(file: lstFile);

    res.fold(
          (failure) {
        Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        isLoadingUpdateAva.call(false);
      },
          (value) async {
        Get.snackbar('Thông báo', 'Cập nhật thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
        AppSettings.setValue(KeyAppSetting.userAva, CoreUrl.baseAvaURL + value.userAva!);
        isLoadingUpdateAva.call(false);
      },
    );
  }

  Future mediaSelection({required int index, required BuildContext context}) async {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
        context: context,
        builder: (BuildContext ct) {
          return SizedBox(
            height: MediaQuery.of(ct).size.shortestSide < 600 ? 200 : 350.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Chọn chức năng',
                  style: Theme.of(ct).textTheme.titleLarge!.copyWith(color: kPrimaryLightColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  margin: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: true,
                        child: InkWell(
                          onTap: () => showMediaSelection(
                              index: index,
                              context: context,
                              loaiChucNang: MediaLoaiChucNangDinhKem.camera),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: Image.asset(
                                  CoreImages.mbs_camera,
                                  height: 65.0,
                                  width: 65.0,
                                ),
                              ),
                              Text(
                                'Chụp hình',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: InkWell(
                          onTap: () => showMediaSelection(
                              index: index,
                              context: context,
                              loaiChucNang: MediaLoaiChucNangDinhKem.album),
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: Image.asset(
                                  CoreImages.mbs_albumn,
                                  height: 65.0,
                                  width: 65.0,
                                ),
                              ),
                              Text(
                                'Bộ sưu tập',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }


  void showMediaSelection(
      {required int index,
        required  BuildContext context,
        required MediaLoaiChucNangDinhKem loaiChucNang}) async {
    String pathFile = '';

    // FlushbarDatasource flushbar = FlushbarResponse();

    print('vao chon lay hinh tu camera hoac gallery');
    switch (loaiChucNang) {

    /// Lấy hình từ camera
      case MediaLoaiChucNangDinhKem.camera:
        PickedFile? pickedFile = await ImagePicker()
            .getImage(source: ImageSource.camera, imageQuality: 50);
        Navigator.pop(context);

        if (pickedFile != null) {
          pathFile = pickedFile.path;
          File imageFile = File(pathFile);
          file.call(imageFile);
        } else {
          final LostData response = await picker.getLostData();

          if (response.isEmpty) {
            break;
          }

          if (response.file != null) {
            pathFile = pickedFile!.path;
          }
        }

        break;

    ///Lấy hình từ Album
      case MediaLoaiChucNangDinhKem.album:
        PickedFile? pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
        Navigator.pop(context);

        if (pickedFile != null) {
          pathFile = pickedFile.path;
          File imageFile = File(pathFile);
          file.call(imageFile);
        } else {
          final LostData response = await picker.getLostData();
          if (response.isEmpty) {
            break;
          }
          if (response.file != null) {
            pathFile = pickedFile!.path;
          }
        }
        break;
      case MediaLoaiChucNangDinhKem.video:
      // TODO: Handle this case.
        break;
      case MediaLoaiChucNangDinhKem.file:
      // TODO: Handle this case.
        break;
    }

    if (pathFile == '') return;

    try {
      var filename = pathFile.split('/').last;
      var typeFile = pathFile.split('.').last;
      await postUpdateAva(context, file.value!);
    } on Exception catch (ex) {
      Get.snackbar('Thông báo', 'Tải tập tin lỗi!', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }


}