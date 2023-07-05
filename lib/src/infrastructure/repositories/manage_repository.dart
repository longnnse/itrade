import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/category_model.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/services/home_service.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';

import '../../../core/initialize/core_url.dart';

class ManageRepositories implements ManageService {
  final CoreHttp _coreHttp = Get.find();

  @override
  Future<Either<ErrorObject, List<Data>>> getPersonalPosts() async {
    try {
      const url = '${CoreUrl.baseURL}/Post/Personal';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
              'eyJVc2VySWQiOiJkMDcyNzNjYy1jZDQ0LTRkODMtODg3My0wNjNjOGM2Mjg4YWEiLCJ'
              'FbWFpbCI6ImxvbmdubEBmcHQuZWR1LnZuIiwiRnVsbE5hbWUiOiJOZ-G7jWMgTG9uZ0'
              '5ndXnhu4VuIiwiVXNlck5hbWUiOiJsb25nbmwiLCJodHRwOi8vc2NoZW1hcy5taWNyb'
              '3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNZW1iZXIi'
              'LCJQaG9uZU51bWJlciI6IjA5ODc2NTQzMjEiLCJleHAiOjE2ODgzMDIzOTgsImlzcyI'
              '6Ik9ubGluZV9NYXJrZXRwbGFjZV9TeXN0ZW0iLCJhdWQiOiJPbmxpbmVfTWFya2V0cG'
              'xhY2VfU3lzdGVtIn0.1GC0fNz0RUw4SMKM-gwkxBrN1e2SSOdB-CDr75_ibd0'});

      if (res != null) {
        final data = res
            .map<Data>(
                (e) => Data.fromJson(e))
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