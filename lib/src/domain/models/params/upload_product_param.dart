class UploadProductParam {
  late String title;
  late String content;
  late String categoryName;
  late double price;
  late bool isTrade;
  late bool isSell;
  late bool isUsed;
  late bool isFree;
  late bool isProfessional;
  late List<String> files;

  UploadProductParam(
      {required this.title,
        required this.content,
        required this.categoryName,
        required this.price,
        required this.isTrade,
        required this.isSell,
        required this.isUsed,
        required this.isFree,
        required this.isProfessional,
        required this.files});

  UploadProductParam.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    categoryName = json['categoryName'];
    price = json['price'];
    isTrade = json['isTrade'];
    isSell = json['isSell'];
    isUsed = json['isUsed'];
    isFree = json['isFree'];
    isProfessional = json['isProfessional'];
    files = json['files'];
  }
}