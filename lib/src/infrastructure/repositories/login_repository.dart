import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/core/initialize/core_url.dart';
import 'package:i_trade/src/domain/models/login_model.dart';
import 'package:i_trade/src/domain/models/params/edit_password_param.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';
import 'package:i_trade/src/domain/services/login_service.dart';

import '../../../core/utils/app_settings.dart';


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
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

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

  @override
  Future<Either<ErrorObject, RegisterAccountParam>> postRegister({required RegisterAccountParam param}) async {
    try {
      const url = '${CoreUrl.baseURL}/User/Register';

      final Map<String, dynamic> queryParameters = {
        'userName': param.userName,
        'password': param.password,
        'email': param.email,
        'firstName': param.firstName,
        'lastName': param.lastName,
        'address': param.address,
        'phoneNumber': param.phoneNumber,
        'age': param.age,
        'idenficationNumber': param.idenficationNumber
      };

      final res = await _coreHttp.post(url, queryParameters);

      if (res != null) {
        final data = RegisterAccountParam.fromJson(res);
        return Right(data);
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Sai thông tin nhập, vui lòng kiểm tra lại số CMND/CCCD, email hoặc SDT')
      );
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }

  @override
  Future<Either<ErrorObject, String>> postEditPassword({required EditPasswordParam param}) async {
    try {
      const url = '${CoreUrl.baseURL}/User/ChangePassword';

      final Map<String, dynamic> queryParameters = {
        'email': param.email,
        'currentPassword': param.currentPassword,
        'newPassword': param.newPassword
      };

      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        return const Right('Đổi mật khẩu thành công');
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Sai thông tin nhập, vui lòng kiểm tra lại số email, mật khẩu hiện tại hoặc mới')
      );
    }
    on NoConnectionException {
      print('1213123');
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }

  @override
  Future<Either<ErrorObject, String>> postForgetPassword({required String email}) async {
    try {
      const url = '${CoreUrl.baseURL}/User/ForgotPassword';

      final Map<String, dynamic> queryParameters = {
        'email': email,
      };

      final res = await _coreHttp.post(url, queryParameters);

      if (res != null) {
        return const Right('Mật khẩu reset email đã được gửi');
      }
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const DataParsingFailure()));
    } on ServerException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const ServerFailure(),
          title: 'Thông báo',
          mess: 'Sai thông tin nhập, vui lòng kiểm tra lại số email')
      );
    } on NoConnectionException {
      return Left(ErrorObject.mapFailureToErrorObject(
          failure: const NoConnectionFailure()));
    }
  }
}
// final url =
//     '${_thongKeModuleConfig.baseUrlCongViec}/thong-ke/tinh-trang-cong-viec-theo-phong-ban';
// final Map<String, dynamic> queryParameters = {
//   'TuNgay': param.tuNgay,
//   'DenNgay': param.denNgay,
// };
// if (param.phongBanIds != null) {
// queryParameters.putIfAbsent('PhongBanIds', () => param.phongBanIds);
// }
// final res = await _coreHttp.get(url, queryParameters: queryParameters);
// if (res != null) {
// final data = res
//     .map<TinhTrangCongViecModel>(
// (e) => TinhTrangCongViecModel.fromJson(e))
//     .toList();
// return Right(data ?? []);
// }
// return Left(ErrorObject.mapFailureToErrorObject(
// failure: const DataParsingFailure()));
// } on ServerException {
// return Left(ErrorObject.mapFailureToErrorObject(
// failure: const ServerFailure(),
// title: 'Thông báo',
// mess: 'Có lỗi xảy ra hoặc không tìm thấy thông tin'));
// } on NoConnectionException {
// return Left(ErrorObject.mapFailureToErrorObject(
// failure: const NoConnectionFailure()));
// }
// }