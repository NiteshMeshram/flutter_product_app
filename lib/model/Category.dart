class Category {
  final int id;
  final String name;
  final String slug;
  final String image;
  final String creationAt;
  final String updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      creationAt: json['creationAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }
}