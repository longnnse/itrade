import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:i_trade/src/domain/models/params/edit_password_param.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';

import '../models/login_model.dart';

abstract class LoginService {
  Future<Either<ErrorObject, LoginModel>> postLogin({required String email,required String password});
  Future<Either<ErrorObject, RegisterAccountParam>> postRegister({required RegisterAccountParam param});
  Future<Either<ErrorObject, String>> postEditPassword({required EditPasswordParam param});
  Future<Either<ErrorObject, String>> postForgetPassword({required String email});
}