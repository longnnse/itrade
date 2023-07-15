import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/models/category_model.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';
import 'package:i_trade/src/domain/services/home_service.dart';

import '../../../core/initialize/core_url.dart';

class HomeRepositories implements HomeService {
  final CoreHttp _coreHttp = Get.find();

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

  @override
  Future<Either<ErrorObject, ProductModel>> getPosts({required int pageIndex, required int pageSize}) async {
    try {
      const url = '${CoreUrl.baseURL}/Post';

      final Map<String, dynamic> queryParameters = {
        'PageIndex': pageIndex,
        'PageSize': pageSize
      };

      final res = await _coreHttp.get(url, queryParameters: queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = ProductModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, Data>> getPostByID({required String id}) async {
    try {
      final url = '${CoreUrl.baseURL}/Post/$id';


      final res = await _coreHttp.get(url,
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
          title: 'Thông báo')
      );
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }

  @override
  Future<Either<ErrorObject, SellFreeResultModel>> postSellFree({required String postID, required String desc}) async {
    try {
      const url = '${CoreUrl.baseURL}/Request';
      final Map<String, dynamic> queryParameters = {
        'postId': postID,
        'description': desc,
      };

      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = SellFreeResultModel.fromJson(res);
        return Right(data);
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Không thể yêu cầu mua hoặc nhận miễn phí do đã tồn tại yêu cầu hoặc bài đăng này là của bạn'));
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }
}