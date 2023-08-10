import 'dart:io';

import 'package:i_trade/src/domain/models/params/file_param.dart';

class UploadProductParam {
  late String title;
  late String content;
  late String location;
  late double? price;
  late bool isUsed;
  late String type;
  late List<File> files;
  late List<String> categoryIds;
  late List<String> categoryDesiredIds;

  UploadProductParam(
      {required this.title,
        required this.content,
        required this.location,
                 this.price,
        required this.isUsed,
        required this.type,
        required this.files,
        required this.categoryIds,
        required this.categoryDesiredIds});

  UploadProductParam.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    content = json['Content'];
    location = json['Location'];
    price = json['Price'] ?? "";
    isUsed = json['IsUsed'];
    type = json['Type'];
    files = json['Files'];
    categoryIds = json['CategoryIds'];
    categoryDesiredIds = json['CategoryDesiredIds'];
  }
}