import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:i_trade/src/domain/models/params/register_account_param.dart';
import 'package:i_trade/src/domain/models/params/upload_product_param.dart';

import '../models/login_model.dart';

abstract class UploadProductService {
  Future<Either<ErrorObject, UploadProductParam>> postUploadProduct({required UploadProductParam param});
}