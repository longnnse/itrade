import 'package:i_trade/src/domain/models/request_result_model.dart';
import 'package:i_trade/src/domain/models/sell_free_result_model.dart';

class RequestPostResultModel {
  late int pageIndex;
  late int pageSize;
  late int totalPage;
  late int totalSize;
  late int pageSkip;
  late List<RequestResultModel> data;

  RequestPostResultModel(
      {required this.pageIndex,
        required this.pageSize,
        required this.totalPage,
        required this.totalSize,
        required this.pageSkip,
        required this.data});

  RequestPostResultModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    totalSize = json['totalSize'];
    pageSkip = json['pageSkip'];
    if (json['data'] != null) {
      data = <RequestResultModel>[];
      json['data'].forEach((v) {
        data.add(RequestResultModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['totalSize'] = totalSize;
    data['pageSkip'] = pageSkip;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}

class PostRequestedResultModel {
  late int pageIndex;
  late int pageSize;
  late int totalPage;
  late int totalSize;
  late int pageSkip;
  late List<Post> data;

  PostRequestedResultModel(
      {required this.pageIndex,
        required this.pageSize,
        required this.totalPage,
        required this.totalSize,
        required this.pageSkip,
        required this.data});

  PostRequestedResultModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalPage = json['totalPage'];
    totalSize = json['totalSize'];
    pageSkip = json['pageSkip'];
    if (json['data'] != null) {
      data = <Post>[];
      json['data'].forEach((v) {
        data.add(Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageIndex'] = pageIndex;
    data['pageSize'] = pageSize;
    data['totalPage'] = totalPage;
    data['totalSize'] = totalSize;
    data['pageSkip'] = pageSkip;
    data['data'] = this.data.map((v) => v.toJson()).toList();
    return data;
  }
}




