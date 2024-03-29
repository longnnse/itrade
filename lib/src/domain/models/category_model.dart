class CategoryModel {
  late String name;
  late String img;
  late String id;
  late String dateCreated;
  late String dateUpdated;
  late bool isDeleted;

  CategoryModel({
    required this.name,
    required this.img,
    required this.id,
    required this.dateCreated,
    required this.dateUpdated,
    required this.isDeleted
      });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    img = json['img'] ?? '';
    id = json['id'];
    dateCreated = json['dateCreated'];
    dateUpdated = json['dateUpdated'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img'] = img;
    data['id'] = id;
    data['dateCreated'] = dateCreated;
    data['dateUpdated'] = dateUpdated;
    data['isDeleted'] = isDeleted;
    return data;
  }
}