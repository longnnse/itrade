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