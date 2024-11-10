class CategoryModel {
  final String collectionId;
  final String collectionName;
  final String created;
  final String description;
  final String id;
  final String image;
  final String slug;
  final String title;
  final String updated;

  CategoryModel({
    required this.collectionId,
    required this.collectionName,
    required this.created,
    required this.description,
    required this.id,
    required this.image,
    required this.slug,
    required this.title,
    required this.updated,
  });

  // Factory method to create a Category instance from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      collectionId: json['collectionId'] as String,
      collectionName: json['collectionName'] as String,
      created: json['created'] as String,
      description: json['description'] as String? ?? "",
      id: json['id'] as String,
      image: json['image'] as String,
      slug: json['slug'] as String,
      title: json['title'] as String,
      updated: json['updated'] as String,
    );
  }

  // Method to convert Category instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'collectionId': collectionId,
      'collectionName': collectionName,
      'created': created,
      'description': description,
      'id': id,
      'image': image,
      'slug': slug,
      'title': title,
      'updated': updated,
    };
  }
}
