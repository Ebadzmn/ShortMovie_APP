class ShortsModel {
  final String videoUrl;
  final String title;
  final String description;
  final String? profileImage;
  final String episode;
  final String season;
  final List<String>? tags;

  ShortsModel({
    required this.videoUrl,
    required this.title,
    required this.description,
    this.profileImage,
    required this.episode,
    required this.season,
    this.tags,
  });
}
