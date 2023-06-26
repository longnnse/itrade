import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';

import '../models/login_model.dart';

abstract class LoginService {
  Future<Either<ErrorObject, LoginModel>> postLogin({required String email,required String password});

}