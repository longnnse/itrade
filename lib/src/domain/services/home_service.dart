import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:i_trade/src/domain/models/category_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';

import '../models/product_model.dart';


abstract class HomeService {
  Future<Either<ErrorObject, List<CategoryModel>>> getCategories({required int pageIndex,required int pageSize});
  Future<Either<ErrorObject, ProductModel>> getPosts({required int pageIndex,required int pageSize});
  Future<Either<ErrorObject, Data>> getPostByID({required String id});
  Future<Either<ErrorObject, SellFreeResultModel>> postSellFree({required String postID, required String desc});
}