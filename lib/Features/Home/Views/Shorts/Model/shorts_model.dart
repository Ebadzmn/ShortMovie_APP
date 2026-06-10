class ShortsModel {
  final String id;
  final String videoUrl;
  final String poster;
  final String title;
  final String description;
  final String? profileImage;
  final String episode;
  final String season;
  final List<String>? tags;

  ShortsModel({
    required this.id,
    required this.videoUrl,
    required this.poster,
    required this.title,
    required this.description,
    this.profileImage,
    required this.episode,
    required this.season,
    this.tags,
  });

  factory ShortsModel.fromJson(Map<String, dynamic> json) {
    return ShortsModel(
      id: json['id'] ?? json['_id'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      poster: json['poster'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      profileImage: json['profileImage'],
      episode: json['episode']?.toString() ?? '1',
      season: json['season']?.toString() ?? '1',
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
    );
  }
}
