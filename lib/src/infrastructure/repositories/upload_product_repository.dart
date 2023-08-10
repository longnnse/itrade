import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';

import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';


class UploadProdcutRepositories implements UploadProductService {
  final CoreHttp _coreHttp = Get.find();

  @override
  Future<Either<ErrorObject, Data>> postUploadProduct({required UploadProductParam param}) async {
    try {
      const url = '${CoreUrl.baseURL}/Post';

      final Map<String, dynamic> queryParameters = {
        'Title': param.title,
        'Content': param.content,
        'Location': param.location,
        'Price': param.price,
        'isUsed': param.isUsed,
        'Type': param.type,
        'Files': param.files,
        'CategoryIds': param.categoryIds[0],
        'CategoryDesiredIds': param.categoryDesiredIds[0]
      };

      final res = await _coreHttp.postWithFile(url, queryParameters, param.files, fileKey: 'Files',
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = Data.fromJson(res);
        return Right(data);
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Sai thông tin nhập, vui lòng kiểm tra lại')
      );
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }

  @override
  Future<Either<ErrorObject, List<CategoryModel>>> getCategories({required int pageIndex, required int pageSize}) async {
    try {
      const url = '${CoreUrl.baseURL}/Category';

      final Map<String, dynamic> queryParameters = {
        'PageIndex': pageIndex,
        'PageSize': pageSize
      };

      final res = await _coreHttp.get(url, queryParameters: queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = res
            .map<CategoryModel>(
                (e) => CategoryModel.fromJson(e))
            .toList();
        return Right(data ?? []);
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo')
      );
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }
}