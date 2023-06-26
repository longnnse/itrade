import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/src/domain/models/login_model.dart';
import 'package:i_trade/src/domain/services/login_service.dart';


class LoginRepositories implements LoginService {
  final CoreHttp _coreHttp = Get.find();

  @override
  Future<Either<ErrorObject, LoginModel>> postLogin({required String email, required String password}) async {
    try {
      const url = '${CoreUrl.baseURL}/User/Login';
      final Map<String, dynamic> queryParameters = {
        'email': email,
        'password': password,
      };

      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
          'eyJVc2VySWQiOiJkMDcyNzNjYy1jZDQ0LTRkODMtODg3My0wNjNjOGM2Mjg4YWEiLCJFbWFpbCI6ImxvbmdubEBmcHQuZWR1Ln'
          'ZuIiwiRnVsbE5hbWUiOiJOZ-G7jWMgTG9uZ05ndXnhu4VuIiwiVXNlck5hbWUiOiJsb25nbmwiLCJodHRwOi8vc2NoZW1hcy5ta'
          'WNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJNZW1iZXIiLCJQaG9uZU51bWJlciI6IjA5ODc2'
          'NTQzMjEiLCJleHAiOjE2ODc4NzEzMDgsImlzcyI6Ik9ubGluZV9NYXJrZXRwbGFjZV9TeXN0ZW0iLCJhdWQiOiJPbmxpbmVfTWFy'
          'a2V0cGxhY2VfU3lzdGVtIn0.gRePLm9mAi_vbK9C6Gw4bWnfwJFw37weUlwbUOS6MB8'});

      if (res != null) {
        final data = LoginModel.fromJson(res);
        return Right(data);
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Có lỗi xảy ra hoặc không tìm thấy thông tin'));
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }
}
