import 'package:core_http/core/error_handling/error_object.dart';
import 'package:core_http/core/error_handling/exceptions.dart';
import 'package:core_http/core/error_handling/failures.dart';
import 'package:core_http/core_http.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:i_trade/src/domain/models/product_model.dart';
import 'package:i_trade/src/domain/models/request_post_result_model.dart';
import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/trade_model.dart';
import 'package:i_trade/src/domain/models/trade_result_model.dart';
import 'package:i_trade/src/domain/services/manage_service.dart';

import '../../../core/initialize/core_url.dart';
import '../../../core/utils/app_settings.dart';

class ManageRepositories implements ManageService {
  final CoreHttp _coreHttp = Get.find();

  @override
  Future<Either<ErrorObject, List<Data>>> getPersonalPosts() async {
    try {
      const url = '${CoreUrl.baseURL}/Post/Personal';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

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

  @override
  Future<Either<ErrorObject, TradeModel>> getTradePosts({required int pageIndex, required int pageSize, required String fromPostID, required String toPostID}) async {
    try {
      const url = '${CoreUrl.baseURL}/Trading';

      final Map<String, dynamic> queryParameters = {
        'PageIndex': pageIndex,
        'PageSize': pageSize,
        'FromPostID': fromPostID,
        'ToPostID': toPostID,
      };


      final res = await _coreHttp.get(url, queryParameters: queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = TradeModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, DataTrade>> postAcceptTrade({required String tradeID}) async {
    try {
      const url = '${CoreUrl.baseURL}/Trading/AcceptTrading';

      final Map<String, dynamic> queryParameters = {
        'id': tradeID,
      };


      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = DataTrade.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, DataTrade>> postDenyTrade({required String tradeID}) async {
    try {
      const url = '${CoreUrl.baseURL}/Trading/DenyTrading';

      final Map<String, dynamic> queryParameters = {
        'id': tradeID,
      };


      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = DataTrade.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, TradeResultModel>> postTrading({required String fromPostId, required String toPostId}) async {
    try {
      const url = '${CoreUrl.baseURL}/Trading';

      final Map<String, dynamic> queryParameters = {
        'fromPostId': fromPostId,
        'toPostId': toPostId,
      };


      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = TradeResultModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, List<RequestResultModel>>> getRequestByID({required String postID}) async {
    try {
      final url = '${CoreUrl.baseURL}/Request/$postID';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = res
            .map<RequestResultModel>(
                (e) => RequestResultModel.fromJson(e))
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

  @override
  Future<Either<ErrorObject, RequestResultModel>> postAcceptRequest({required String tradeID}) async{
    try {
      const url = '${CoreUrl.baseURL}/Request/AcceptRequest';

      final Map<String, dynamic> queryParameters = {
        'id': tradeID,
      };


      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = RequestResultModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, RequestResultModel>> postDenyReques({required String tradeID}) async {
    try {
      const url = '${CoreUrl.baseURL}/Request/DenyRequest';

      final Map<String, dynamic> queryParameters = {
        'id': tradeID,
      };


      final res = await _coreHttp.post(url, queryParameters,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = RequestResultModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, List<DataTrade>>> getTradingReceived() async {
    try {
      const url = '${CoreUrl.baseURL}/Trading/TradingReceived';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = res
            .map<DataTrade>(
                (e) => DataTrade.fromJson(e))
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

  @override
  Future<Either<ErrorObject, RequestPostResultModel>> getRequestReceived() async {
    try {
      const url = '${CoreUrl.baseURL}/Request/Received?PageSize=20';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = RequestPostResultModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, PostRequestedResultModel>> getPostRequested() async {
    try {
      const url = '${CoreUrl.baseURL}/Post/Requested?PageSize=20';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = PostRequestedResultModel.fromJson(res);
        return Right(data);
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

  @override
  Future<Either<ErrorObject, List<DataTrade>>> getTradingSent() async {
    try {
      const url = '${CoreUrl.baseURL}/Trading/TradingSent';

      final res = await _coreHttp.get(url,
          headers: {'Authorization': 'Bearer ${AppSettings.getValue(KeyAppSetting.token)}'});

      if (res != null) {
        final data = res
            .map<DataTrade>(
                (e) => DataTrade.fromJson(e))
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