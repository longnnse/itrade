import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/initialize/core_images.dart';
import '../../../../core/initialize/theme.dart';
import '../../../domain/enums/enums.dart';
import '../../../domain/models/category_model.dart';

class UploadPostController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  RxList<String>  items = ['Chọn danh mục'].obs;
  RxString selectedValue = 'Chọn danh mục'.obs;
  RxBool isNew = false.obs;
  RxBool isPro = false.obs;
  RxBool isFree = false.obs;
  RxBool isSell = false.obs;
  final ImagePicker picker = ImagePicker();
  final RxBool isLoading = false.obs;
  final RxBool isFirst = true.obs;
  final UploadProductService _uploadProductService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> postUploadProduct({required BuildContext context}) async {
    //TODO use test
    bool isValid = true;
    if(priceController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập giá tiền', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(contentController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập nội dung', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    // if(addressController.text == ''){
    //   isValid = false;
    //   Get.snackbar('Thông báo', 'Vui lòng nhập địa chỉ', backgroundColor: kSecondaryRed, colorText: kTextColor);
    // }
    if(titleController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập tiêu đề', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }

    if(isValid == true){
      UploadProductParam param = UploadProductParam(
          title: titleController.text,
          content: contentController.text,
          categoryName: selectedValue.value,
          price: double.parse(priceController.text),
          isTrade: isSell.value == false ? true : false,
          isSell: isSell.value,
          isUsed: isNew.value,
          isFree: isFree.value,
          isProfessional: isPro.value,
          files: [],
      );
      isLoading.call(true);
      final Either<ErrorObject, UploadProductParam> res = await _uploadProductService.postUploadProduct(param: param);

      res.fold(
            (failure) {
          isLoading.call(false);
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        },
            (value) async {
          Get.snackbar('Thông báo', 'Đăng bài thành công', backgroundColor: kSecondaryGreen, colorText: kTextColor);
          titleController.clear();
          contentController.clear();
          priceController.clear();
          addressController.clear();
          isLoading.call(false);
          Navigator.pop(context, true);
        },
      );
    }
  }

  Future<void> getCategories({required int pageIndex,required int pageSize}) async {
    //TODO use test
    isLoading.call(true);
    final Either<ErrorObject, List<CategoryModel>> res = await _uploadProductService.getCategories(pageSize: pageSize, pageIndex: pageIndex);

    res.fold(
          (failure) {
        isLoading.call(false);
      },
          (value) async {
         for(var cont in value){
           items.add(cont.name);
         }
        isLoading.call(false);
        isFirst.call(false);
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


    } on Exception catch (ex) {
      print("lỗi $ex");
    }
  }

}