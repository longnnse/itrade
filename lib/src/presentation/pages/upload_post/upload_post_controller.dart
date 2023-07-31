import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';
import 'package:i_trade/src/presentation/pages/manage/manage_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/initialize/core_images.dart';
import '../../../../core/initialize/theme.dart';
import '../../../domain/enums/enums.dart';
import '../../../domain/models/category_model.dart';
import '../../../domain/models/params/file_param.dart';
import '../../../domain/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class UploadPostController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  RxList<String>  items = ['Chọn danh mục'].obs;
  RxString selectedValue = 'Chọn danh mục'.obs;
  RxList<FileParam>? files;
  RxList<MediaFilesModel> mediaModels = (List<MediaFilesModel>.of([])).obs;
  RxList<File> lstFiles = (List<File>.of([])).obs;
  RxBool isNew = false.obs;
  //RxBool isPro = false.obs;
  RxBool isFree = false.obs;
  RxBool isSell = false.obs;
  final ImagePicker picker = ImagePicker();
  final RxBool isLoading = false.obs;
  final RxBool isFirst = true.obs;
  final RxString toPostID = ''.obs;
  final RxBool isPostToTrade = false.obs;
  final UploadProductService _uploadProductService = Get.find();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> postUploadProduct({required BuildContext context}) async {
    //TODO use test
    bool isValid = true;
    if(selectedValue.value == 'Chọn danh mục'){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng chọn danh mục', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(priceController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập giá tiền', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(contentController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập nội dung', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(addressController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập địa chỉ', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
    if(titleController.text == ''){
      isValid = false;
      Get.snackbar('Thông báo', 'Vui lòng nhập tiêu đề', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }

    if(isValid == true){
      UploadProductParam param = UploadProductParam(
          title: titleController.text,
          content: contentController.text,
          location: addressController.text,
          price: double.parse(priceController.text),
          isUsed: isNew.value == false ? true : false,
          type: isFree.value == true ? 'Free' : isSell.value == true ? 'Sell' : 'Trade',
          files: lstFiles.call(),
          categoryIds: [selectedValue.value.split('@').last],
      );
      isLoading.call(true);
      final Either<ErrorObject, Data> res = await _uploadProductService.postUploadProduct(param: param);

      res.fold(
            (failure) {
          isLoading.call(false);
          Get.snackbar('Thông báo', failure.message, backgroundColor: kSecondaryRed, colorText: kTextColor);
        },
            (value) async {
          if(isPostToTrade.value == true){
            final ManageController manageController = Get.find();
            await manageController.postTrading(fromPostId: value.id, toPostId: toPostID.value);
          }
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
           items.add('${cont.name}@${cont.id}');
         }
        isLoading.call(false);
        isFirst.call(false);
      },
    );
  }

  void deleteImage(int index){
    mediaModels.call().removeAt(index);
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

  Future<void> uploadImage(FileParam fileParam, File imageFile) async {

    var request = http.MultipartRequest('POST', Uri.parse('YOUR_UPLOAD_URL'));


    request.headers['Content-Type'] = fileParam.contentType;
    request.headers['Content-Length'] = fileParam.length.toString();


    var filePart = http.MultipartFile(
      'file',
      imageFile.readAsBytes().asStream(),
      imageFile.lengthSync(),
      filename: fileParam.fileName,
      contentType: MediaType.parse(fileParam.contentType),
    );

    request.files.add(filePart);


    var response = await request.send();


    if (response.statusCode == 200) {

      print('Image uploaded successfully!');
    } else {

      print('Failed to upload image. Status code: ${response.statusCode}');
    }
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
          lstFiles.call().add(imageFile);
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
          lstFiles.call().add(imageFile);
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

      mediaModels.call().add(MediaFilesModel(
        isLoading: false,
        pathFile: pathFile,
        typeFile: typeFile,
        urlFile: pathFile,
        isShow: true,
        uint8list: Uint8List.fromList(utf8.encode(pathFile))
      ));
      // medias[index] = medias.elementAt(index).copyWith(
      //     pathFile: pathFile,
      //     typeFile: typeFile,
      //     urlFile: '',
      //     isLoading: false);
      // http.ByteStream? stream = await uploadFile(pathFile, filename);
      // if (stream != null) {
      //   bool isCheckUploadSuccess = false;
      //   stream.transform(utf8.decoder).listen((value) {
      //
      //     medias[index] = medias.elementAt(index).copyWith(
      //         pathFile: pathFile,
      //         typeFile: typeFile,
      //         urlFile: jsonDecode(value),
      //         isLoading: false);
      //
      //     isCheckUploadSuccess = true;
      //   });
      // } else {
      //   Get.snackbar('Thông báo', 'Tải tập tin lỗi!', backgroundColor: kSecondaryRed, colorText: kTextColor);
      // }

    } on Exception catch (ex) {
      Get.snackbar('Thông báo', 'Tải tập tin lỗi!', backgroundColor: kSecondaryRed, colorText: kTextColor);
    }
  }


  Future<http.ByteStream?> uploadFile(String path, String filename) async {
    var postUri = Uri.parse(CoreUrl.baseImageURL);

    /// Tạm thời đóng
    var request = new http.MultipartRequest("POST", postUri);
    // request.fields['PhanLoai'] = 'VPTT';

    Uri uri = Uri(path: path);
    request.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(uri).readAsBytes(),
        filename: filename));

    try {
      http.StreamedResponse streamedResponse = await request.send();
      if (streamedResponse.statusCode != 200) {
        return null;
      }
      return streamedResponse.stream;
    } catch (e) {
      return null;
    }
  }

}