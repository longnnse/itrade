
import 'package:i_trade/src/domain/models/group_post_result_model.dart';

class ManagePersonalGroupModel {
  late int pageIndex;
  late int pageSize;
  late int totalPage;
  late int totalSize;
  late int pageSkip;
  late List<GroupPostResultModel> data;

  ManagePersonalGroupModel(
      {required this.pageIndex,
        required this.pageSize,
        required this.totalPage,
        required this.totalSize,
        required this.pageSkip,
        required this.data});

  ManagePersonalGroupModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'] ?? 0;
    pageSize = json['pageSize'] ?? 0;
    totalPage = json['totalPage'] ?? 0;
    totalSize = json['totalSize'] ?? 0;
    pageSkip = json['pageSkip'] ?? 0;
    if (json['data'] != null) {
      data = <GroupPostResultModel>[];
      json['data'].forEach((v) {
        data.add(GroupPostResultModel.fromJson(v));
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

