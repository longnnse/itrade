import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/core/utils/app_settings.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';
import 'package:i_trade/src/domain/services/upload_product_service.dart';


class UploadProdcutRepositories implements UploadProductService {
  final CoreHttp _coreHttp = Get.find();

  @override
  Future<Either<ErrorObject, UploadProductParam>> postUploadProduct({required UploadProductParam param}) async {
    try {
      const url = '${CoreUrl.baseURL}/Post';

      final Map<String, dynamic> queryParameters = {
        'Title': param.title,
        'Content': param.content,
        'IsTrade': param.isTrade,
        'IsSell': param.isSell,
        'isUsed': param.isUsed,
        'CategoryName': param.categoryName,
        'price': param.price,
        'isProfessional': param.isProfessional,
        'isFree': param.isFree,
        'Files': param.files
      };

      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
              'eyJVc2VySWQiOiJkMDcyNzNjYy1jZDQ0LTRkODMtODg3My0wNjNjOGM2Mjg4YWEiLCJ'
              'FbWFpbCI6ImxvbmdubEBmcHQuZWR1LnZuIiwiRnVsbE5hbWUiOiJOZ-G7jWMgTG9uZ0'
              '5ndXnhu4VuIiwiVXNlck5hbWUiOiJsb25nbmwiLCJodHRwOi8vc2NoZW1hcy5taWNyb'
              '3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNZW1iZXIi'
              'LCJQaG9uZU51bWJlciI6IjA5ODc2NTQzMjEiLCJleHAiOjE2ODgzMDIzOTgsImlzcyI'
              '6Ik9ubGluZV9NYXJrZXRwbGFjZV9TeXN0ZW0iLCJhdWQiOiJPbmxpbmVfTWFya2V0cG'
              'xhY2VfU3lzdGVtIn0.1GC0fNz0RUw4SMKM-gwkxBrN1e2SSOdB-CDr75_ibd0'});

      if (res != null) {
        final data = UploadProductParam.fromJson(res);
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
}