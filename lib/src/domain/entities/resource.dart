class ResourceItem {
  String? id;
  String? dateCreated;
  String? dateUpdated;
  bool? isDeleted;
  String? postId;
  String? description;
  String? extension;

  ResourceItem(
      {this.id,
      this.dateCreated,
      this.dateUpdated,
      this.isDeleted,
      this.postId,
      this.description,
      this.extension});

  factory ResourceItem.fromJson(Map<String, dynamic> json) => ResourceItem(
        id: json["id"],
        dateCreated: json["dateCreated"],
        dateUpdated: json["dateUpdated"],
        isDeleted: json["isDeleted"],
        postId: json["postId"],
        description: json["description"],
        extension: json["extension"],
      );
}
