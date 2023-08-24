import 'dart:io';

import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:i_trade/src/domain/models/params/edit_password_param.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';
import 'package:i_trade/src/domain/models/update_user_result_model.dart';

import '../models/login_model.dart';
import '../models/update_ava_result_model.dart';

abstract class LoginService {
  Future<Either<ErrorObject, LoginModel>> postLogin({required String email,required String password});
  Future<Either<ErrorObject, RegisterAccountParam>> postRegister({required RegisterAccountParam param});
  Future<Either<ErrorObject, String>> postEditPassword({required EditPasswordParam param});
  Future<Either<ErrorObject, String>> postForgetPassword({required String email});
  Future<Either<ErrorObject, UpdateAvaResultModel>> postUpdateAva({required List<File> file});

  Future<Either<ErrorObject, UpdateUserResultModel>> putUser({required String id,required String firstName, required String lastName,required String address,required String phoneNumber,required String age,});
}