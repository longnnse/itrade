import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class FileParam {
  late String contentType;
  late String contentDisposition;
  late IHeaderDictionary headers;
  late int length;
  late String name;
  late String fileName;

  FileParam(
      {required this.contentType,
        required this.contentDisposition,
        required this.headers,
        required this.length,
        required this.name,
        required this.fileName});
}

class IHeaderDictionary {
  late int contentLength;

  IHeaderDictionary(
      {required this.contentLength});

}

class MediaFilesModel extends Equatable {
  String? pathFile;
  String? urlFile;
  Uint8List? uint8list;
  bool? isLoading;
  bool? isShow;
  String? typeFile;

  MediaFilesModel(
      {this.pathFile,
        this.urlFile,
        this.isLoading,
        this.isShow,
        this.typeFile,
        this.uint8list});

  MediaFilesModel copyWith(
      {pathFile, urlFile, isLoading, isShow, typeFile, uint8list}) =>
      MediaFilesModel(
          pathFile: pathFile ?? this.pathFile,
          urlFile: urlFile ?? this.urlFile,
          isLoading: isLoading ?? this.isLoading,
          isShow: isShow ?? this.isShow,
          typeFile: typeFile ?? this.typeFile,
          uint8list: uint8list ?? this.uint8list);

  @override
  List<Object> get props =>
      [pathFile!, urlFile!, isLoading!, isShow!, typeFile!, uint8list!];
}