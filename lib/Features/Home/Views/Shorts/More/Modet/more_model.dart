class CastModel {
  final String name;
  final String seriesCount;
  final String imageUrl;

  CastModel({
    required this.name,
    required this.seriesCount,
    required this.imageUrl,
  });
}

class RelatedContentModel {
  final String title;
  final String category;
  final String views;
  final String imageUrl;
  final bool isNew;

  RelatedContentModel({
    required this.title,
    required this.category,
    required this.views,
    required this.imageUrl,
    this.isNew = false,
  });
}
