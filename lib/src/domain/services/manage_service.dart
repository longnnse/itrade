import 'package:core_http/core/error_handling/error_object.dart';
import 'package:dartz/dartz.dart';
import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/trade_result_model.dart';

import '../models/product_model.dart';
import '../models/trade_model.dart';


abstract class ManageService {
  Future<Either<ErrorObject, List<Data>>> getPersonalPosts();

  Future<Either<ErrorObject, TradeModel>> getTradePosts({required int pageIndex,required int pageSize, required String fromPostID, required String toPostID});

  Future<Either<ErrorObject, DataTrade>> postAcceptTrade({required String tradeID});

  Future<Either<ErrorObject, DataTrade>> postDenyTrade({required String tradeID});

  Future<Either<ErrorObject, TradeResultModel>> postTrading({required String fromPostId, required String toPostId});

  Future<Either<ErrorObject, List<RequestResultModel>>> getRequestByID({required String postID});

  Future<Either<ErrorObject, RequestResultModel>> postAcceptRequest({required String tradeID});

  Future<Either<ErrorObject, RequestResultModel>> postDenyReques({required String tradeID});

}