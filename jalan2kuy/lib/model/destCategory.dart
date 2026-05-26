class destCategory {
  final String destCategoryID;
  final String categoryName;
  final String categoryImage;

  const destCategory({
    required this.destCategoryID,
    required this.categoryName,
    required this.categoryImage,
  });

  factory destCategory.fromJson(Map<String, dynamic> json) {
    return destCategory(
      destCategoryID: json['destCategoryID'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categoryImage: json['categoryImage'] ?? '',
    );
  }
}
