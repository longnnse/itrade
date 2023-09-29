import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/common/apis/exchange.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/models/group_post_result_model.dart';
import 'package:i_trade/src/domain/models/manage_personal_group_model.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/request_post_result_model.dart';
import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/trade_model.dart';
import 'package:i_trade/src/domain/models/trade_result_model.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';
import 'package:i_trade/src/presentation/pages/chat/index.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_group_page.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_group_personal_page.dart';
import 'package:i_trade/src/presentation/pages/manage/widgets/manage_trade_page.dart';
import 'package:i_trade/src/presentation/pages/upload_post/upload_post_controller.dart';

import '../../../../core/initialize/theme.dart';
import '../../../domain/models/trading_sent_model.dart';
import '../../../domain/services/upload_product_service.dart';
import '../../../infrastructure/repositories/upload_product_repository.dart';
import '../home/home_controller.dart';
import '../home/widgets/product_detail.dart';
import '../upload_post/upload_post_page.dart';

final RxString groupID = ''.obs;

class ManageController extends GetxController {
  RxInt tabInt = 0.obs;
  RxInt tabIntTD = 0.obs;
  final ManageService _manageService = Get.find();
  final RxBool isLoading = false.obs;
  final RxBool isLoadingDelete = false.obs;
  final RxBool isLoadingGroup = false.obs;
  final RxBool isLoadingGroupPersonal = false.obs;
  final RxBool isLoadingGroupList = false.obs;
  final RxBool isLoadingTrade = false.obs;
  final RxBool isLoadingConfirmTrade = false.obs;
  final RxBool isLoadingRequestTrade = false.obs;
  final RxBool isLoadingTradingReceived = false.obs;
  final RxBool isLoadingTradingSent = false.obs;
  final RxBool isLoadingRequestReceived = false.obs;
  final RxBool isLoadingPostRequested = false.obs;
  final Rxn<List<Data>> productList = Rxn<List<Data>>();
  final RxList<Data> selectedProductList = RxList<Data>();
  final RxList<String> selectedProductIDs = RxList<String>();
  final Rxn<TradeModel> tradeList = Rxn<TradeModel>();
  final Rxn<TradeResultModel> tradeResult = Rxn<TradeResultModel>();
  final Rxn<List<RequestResultModel>> requestLst =
      Rxn<List<RequestResultModel>>();
  final Rxn<List<TradingSentResultModel>> tradingReceivedLst =
      Rxn<List<TradingSentResultModel>>();
  final Rxn<List<TradingSentResultModel>> tradingSentLst =
      Rxn<List<TradingSentResultModel>>();
  final Rxn<ManagePersonalGroupModel> managePersonalGroup =
      Rxn<ManagePersonalGroupModel>();
  final Rxn<ManagePersonalGroupModel> managePersonal =
      Rxn<ManagePersonalGroupModel>();
  final Rxn<RequestPostResultModel> requestReceivedLst =
      Rxn<RequestPostResultModel>();
  final Rxn<PostRequestedResultModel> postRequestedLst =
      Rxn<PostRequestedResultModel>();
  final TextEditingController searchController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  RxString searchStr = ''.obs;
  // final RxString idFromPost = ''.obs;
  final RxString productID = ''.obs;

  final RxString fromProductID = ''.obs;
  final RxString toProductID = ''.obs;
  final RxString ownerPostID = ''.obs;
  final RxBool isTrade = false.obs;
  final RxBool isTradeLst = false.obs;
  final List<String> lstDropdown = ['Ẩn', 'Chỉnh sửa', 'Thêm nhóm'];
  RxList<String> lstHide = RxList<String>();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> refreshPage() async {
    getGroup(pageIndex: 1, pageSize: 50);
  }

  Future<void> refreshPageQuanLy() async {
    getPersonalPosts();
  }

  Future<void> refreshPageTraoDoi() async {
    getTradingReceived();
    getTradingSent();
  }

  void goGoCreatePost() async {
    Get.put<UploadProductService>(UploadProdcutRepositories());
    Get.put(UploadPostController());
    final UploadPostController uploadPostController = Get.find();
    uploadPostController.isPostToTrade.call(true);
    uploadPostController.toPostID.call(ownerPostID.value);
    var result = await Get.toNamed(UploadPostPage.routeName);
    if (result == true) {
      getPersonalPosts();
    }
  }

  void goDetail({required String id}) {
    final HomeController homeController = Get.find();
    homeController.idPost.call(id);
    Get.toNamed(ProductDetailPage.routeName);
  }

  void updateStatusIsTradeLst() {
    if (isTradeLst.value == false) {
      isTradeLst.call(true);
      getTradingReceived();
    } else {
      isTradeLst.call(false);
      getPersonalPosts();
    }
  }

  void updateStatus(int countTab) {
    tabInt.call(countTab);
    if (tabInt.value == 0) {
      getRequestReceived();
    }
    if (tabInt.value == 1) {
      getPostRequestedReceived();
    } else {
      getTradingSent();
    }
  }

  void updateStatusTraoDoi(int countTab) {
    tabIntTD.call(countTab);
    if (tabIntTD.value == 0) {
      getTradingReceived();
    } else {
      getTradingSent();
    }
  }

  void goGroupPersonalPage(String id) {
    productID.call(id);
    Get.toNamed(ManageGroupPersonalPage.routeName);
  }

  void goGroup(String id) {
    productID.call(id);
    Get.toNamed(ManageGroupPage.routeName);
  }

  void goTradePage(String fromID, String toID) {
    fromProductID.call(fromID);
    toProductID.call(toID);
    Get.toNamed(ManageTradePage.routeName);
  }

  Future<void> postGroup2(
      {required String description, required List<String> lstPostID}) async {
    //TODO use test
    final Either<ErrorObject, GroupPostResultModel> res = await _manageService
        .postGroup(description: description, lstPostID: lstPostID);
    res.fold(
      (failure) {
        Get.snackbar('Thông báo', 'Nhóm bài đăng thất bại',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
      (value) async {
        groupID.call(value.id);
        selectedProductIDs.clear();
        selectedProductList.clear();
        Get.snackbar('Thông báo', 'Nhóm bài đăng thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
      },
    );
  }

  Future<String> postGroup(
      {required String description, required List<String> lstPostID}) async {
    //TODO use test
    String valueReturn = '';
    final Either<ErrorObject, GroupPostResultModel> res = await _manageService
        .postGroup(description: description, lstPostID: lstPostID);
    res.fold(
      (failure) {},
      (value) async {
        valueReturn = value.id;
      },
    );
    return valueReturn;
  }

  void tradeMultiGroup(BuildContext context, String fromGroupID) async {
    isLoadingGroup.call(true);

    if (groupID.value != '') {
      await postTrading(fromPostId: fromGroupID, toPostId: productID.value);

      isLoadingGroup.call(false);
      if (tradeResult.value != null) {
        descController.clear();
        selectedProductIDs.clear();
        Get.snackbar('Thông báo', 'Trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        Navigator.pop(context);
      } else {
        Get.snackbar('Thông báo', 'Không thể trao đổi',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      }
    } else {
      isLoadingGroup.call(false);
      Get.snackbar('Thông báo',
          'Không thể nhóm các bài post lại do không cùng chủ sở hữu',
          backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }

  void tradeGroup(BuildContext context) async {
    isLoadingGroup.call(true);
    List<String> lstOwnerPost = [];
    lstOwnerPost.add(ownerPostID.value);

    String fromPostId = await postGroup(
        description: descController.text, lstPostID: selectedProductIDs);
    String toPostId = await postGroup(description: '', lstPostID: lstOwnerPost);
    if (fromPostId != '' && toPostId != '') {
      await postTrading(fromPostId: fromPostId, toPostId: toPostId);

      isLoadingGroup.call(false);
      if (tradeResult.value != null) {
        descController.clear();
        selectedProductIDs.clear();
        selectedProductList.clear();
        Get.snackbar('Thông báo', 'Trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Get.snackbar('Thông báo', 'Không thể trao đổi',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      }
    } else {
      isLoadingGroup.call(false);
      Get.snackbar('Thông báo',
          'Không thể nhóm các bài post lại do không cùng chủ sở hữu',
          backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }

  void tradeGroupMultiMulti(
      {required BuildContext context,
      required String desc,
      required List<String> lstFromPostID,
      required List<String> lstToPostID}) async {
    isLoadingGroup.call(true);

    String fromPostId =
        await postGroup(description: desc, lstPostID: lstFromPostID);
    String toPostId = await postGroup(description: '', lstPostID: lstToPostID);
    if (fromPostId != '' && toPostId != '') {
      await postTrading(fromPostId: fromPostId, toPostId: toPostId);
      isLoadingGroup.call(false);
      if (tradeResult.value != null) {
        Get.snackbar('Thông báo', 'Trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        HomeController ctl = Get.find();
        ctl.selectedProductList.clear();
        ctl.selectedMyProductList.clear();
        ctl.selectedMyProductIDs.clear();
        Navigator.pop(context);
      } else {
        Get.snackbar('Thông báo', 'Không thể trao đổi',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      }
    } else {
      isLoadingGroup.call(false);
      Get.snackbar('Thông báo',
          'Không thể nhóm các bài post lại do không cùng chủ sở hữu',
          backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }

  Future<void> getPersonalPosts() async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, List<Data>> res =
        await _manageService.getPersonalPosts();

    res.fold(
      (failure) {
        isLoading.call(false);
      },
      (value) async {
        productList.call(value);
        isLoading.call(false);
      },
    );
  }

  Future<void> deletePost(String postID) async {
    //TODO use test
    isLoadingDelete.call(true);
    final Either<ErrorObject, String> res =
        await _manageService.deletePost(postId: postID);

    res.fold(
      (failure) {
        Get.snackbar('Thông báo', 'Ẩn bài đăng thất bại',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
        isLoadingDelete.call(false);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Ẩn thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingDelete.call(false);
      },
    );
  }

  Future<void> getTradingReceived() async {
    //TODO use test
    isLoadingTradingReceived.call(true);
    final Either<ErrorObject, List<TradingSentResultModel>> res =
        await _manageService.getTradingReceived();

    res.fold(
      (failure) {
        isLoadingTradingReceived.call(false);
      },
      (value) async {
        tradingReceivedLst.call(value);
        isLoadingTradingReceived.call(false);
      },
    );
  }

  Future<void> getTradingSent() async {
    //TODO use test
    isLoadingTradingSent.call(true);
    final Either<ErrorObject, List<TradingSentResultModel>> res =
        await _manageService.getTradingSent();

    res.fold(
      (failure) {
        isLoadingTradingSent.call(false);
      },
      (value) async {
        tradingSentLst.call(value);
        isLoadingTradingSent.call(false);
      },
    );
  }

  Future<void> getRequestReceived() async {
    //TODO use test
    isLoadingRequestReceived.call(true);
    final Either<ErrorObject, RequestPostResultModel> res =
        await _manageService.getRequestReceived();

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

  Future<void> getPostRequestedReceived() async {
    //TODO use test
    isLoadingPostRequested.call(true);
    final Either<ErrorObject, PostRequestedResultModel> res =
        await _manageService.getPostRequested();

    res.fold(
      (failure) {
        isLoadingPostRequested.call(false);
      },
      (value) async {
        postRequestedLst.call(value);
        isLoadingPostRequested.call(false);
      },
    );
  }

  Future<void> postTrading(
      {required String fromPostId, required String toPostId}) async {
    //TODO use test
    isLoadingRequestTrade.call(true);
    final Either<ErrorObject, TradeResultModel> res = await _manageService
        .postTrading(fromPostId: fromPostId, toPostId: toPostId);

    res.fold(
      (failure) {
        Get.snackbar('Thông báo', 'Không thể trao đổi',
            backgroundColor: kSecondaryRed, colorText: kTextColor);
        isLoadingRequestTrade.call(false);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        tradeResult.call(value);
        // idFromPost.call(value.fromPostId);
        isLoadingRequestTrade.call(false);
      },
    );
  }

  Future<void> getGroupPersonal(
      {required int pageIndex,
      required int pageSize,
      String searchValue = ''}) async {
    //TODO use test
    isLoadingGroupPersonal.call(true);

    final Either<ErrorObject, ManagePersonalGroupModel> res =
        await _manageService.getGroupPersonal(
            pageIndex: pageIndex, pageSize: pageSize, searchValue: searchValue);

    res.fold(
      (failure) {
        isLoadingGroupPersonal.call(false);
      },
      (value) async {
        managePersonalGroup.call(value);
        isLoadingGroupPersonal.call(false);
      },
    );
  }

  Future<void> getGroup(
      {required int pageIndex,
      required int pageSize,
      String searchValue = ''}) async {
    //TODO use test
    isLoadingGroupList.call(true);

    final Either<ErrorObject, ManagePersonalGroupModel> res =
        await _manageService.getGroup(
            pageIndex: pageIndex, pageSize: pageSize, searchValue: searchValue);

    res.fold(
      (failure) {
        isLoadingGroupList.call(false);
      },
      (value) async {
        managePersonal.call(value);
        isLoadingGroupList.call(false);
      },
    );
  }

  Future<void> getTradePosts(
      {required int pageIndex,
      required int pageSize,
      required String fromPostID,
      required String toPostID}) async {
    //TODO use test
    isLoadingTrade.call(true);
    final Either<ErrorObject, TradeModel> res =
        await _manageService.getTradePosts(
            pageIndex: pageIndex,
            pageSize: pageSize,
            fromPostID: fromPostID,
            toPostID: toPostID);

    res.fold(
      (failure) {
        isLoadingTrade.call(false);
      },
      (value) async {
        tradeList.call(value);
        isLoadingTrade.call(false);
      },
    );
  }

  Future<void> getRequestByID({required String postID}) async {
    //TODO use test
    isLoadingTrade.call(true);
    final Either<ErrorObject, List<RequestResultModel>> res =
        await _manageService.getRequestByID(postID: postID);

    res.fold(
      (failure) {
        isLoadingTrade.call(false);
      },
      (value) async {
        requestLst.call(value);
        isLoadingTrade.call(false);
      },
    );
  }

  Future<void> postAcceptTrade(
      {required String tradeID,
      required BuildContext context,
      bool isManagePage = false}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, DataTrade> res =
        await _manageService.postAcceptTrade(tradeID: tradeID);

    res.fold(
      (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message,
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        if (isManagePage == false) {
          Navigator.pop(context, true);
        } else {
          getTradingReceived();
        }
      },
    );
  }

  Future<void> postDenyTrade(
      {required String tradeID,
      required BuildContext context,
      bool isManagePage = false}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, DataTrade> res =
        await _manageService.postDenyTrade(tradeID: tradeID);

    res.fold(
      (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message,
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Từ chối trao đổi thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        if (isManagePage == false) {
          Navigator.pop(context, true);
        } else {
          getTradingReceived();
        }
      },
    );
  }

  Future<void> postAcceptRequest(
      {required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, RequestResultModel> res =
        await _manageService.postAcceptRequest(tradeID: tradeID);

    res.fold(
      (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message,
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Yêu cầu mua/miễn phí thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }

  Future<void> postDenyRequest(
      {required String tradeID, required BuildContext context}) async {
    //TODO use test
    isLoadingConfirmTrade.call(true);
    final Either<ErrorObject, RequestResultModel> res =
        await _manageService.postDenyReques(tradeID: tradeID);

    res.fold(
      (failure) {
        isLoadingConfirmTrade.call(false);
        Get.snackbar('Thông báo', failure.message,
            backgroundColor: kSecondaryRed, colorText: kTextColor);
      },
      (value) async {
        Get.snackbar('Thông báo', 'Từ chối mua/miễn phí thành công',
            backgroundColor: kSecondaryGreen, colorText: kTextColor);
        isLoadingConfirmTrade.call(false);
        Navigator.pop(context, true);
      },
    );
  }

//handle chat
  Future<void> gochat(TradingSentResultModel tradingItem) async {
    var tradingUserChat =
        await ExchangeAPI.create_trading_user_chat(tradingItem.id!);
    // ignore: unnecessary_null_comparison
    if (tradingUserChat != null) {
      var toName = AppSettings.getValue(KeyAppSetting.userId) ==
              tradingItem.fromGroup!.user!.id
          ? '${tradingItem.toGroup!.groupPosts![0].post!.user!.firstName} ${tradingItem.toGroup!.groupPosts![0].post!.user!.lastName}'
          : '${tradingItem.fromGroup!.user!.firstName} ${tradingItem.fromGroup!.user!.lastName}';
      Get.toNamed(ChatPage.routeName, parameters: {
        "trading_id": tradingItem.id!,
        "to_avatar": AppSettings.getValue(KeyAppSetting.userId) ==
                tradingItem.fromGroup!.user!.id
            ? tradingItem.toGroup!.groupPosts![0].post!.user!.userAva!
            : tradingItem.fromGroup!.user!.userAva!,
        "to_name": toName
      });
    }
  }
}
