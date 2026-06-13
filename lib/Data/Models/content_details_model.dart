class ContentDetailsModel {
  final String id;
  final String title;
  final String description;
  final String posterUrl;
  final int duration;
  final int releaseYear;
  final double rating;
  final int views;
  final List<String> cast;
  final List<String> genres;
  final List<String> planStatus;
  final String type;
  final String status;

  ContentDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.duration,
    required this.releaseYear,
    required this.rating,
    required this.views,
    required this.cast,
    required this.genres,
    required this.planStatus,
    required this.type,
    required this.status,
  });

  factory ContentDetailsModel.fromJson(Map<String, dynamic> json) {
    return ContentDetailsModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      posterUrl: json['posterUrl']?.toString() ?? '',
      duration: json['duration'] is int ? json['duration'] : (int.tryParse(json['duration']?.toString() ?? '') ?? 0),
      releaseYear: json['releaseYear'] is int ? json['releaseYear'] : (int.tryParse(json['releaseYear']?.toString() ?? '') ?? 0),
      rating: (json['rating'] is num ? (json['rating'] as num).toDouble() : (double.tryParse(json['rating']?.toString() ?? '') ?? 0.0)),
      views: json['views'] is int ? json['views'] : (int.tryParse(json['views']?.toString() ?? '') ?? 0),
      cast: json['cast'] != null ? List<String>.from(json['cast']) : [],
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
      planStatus: json['planStatus'] != null ? List<String>.from(json['planStatus']) : [],
      type: json['type']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}

class PlaybackUrlModel {
  final String url;
  final String expiresAt;

  PlaybackUrlModel({
    required this.url,
    required this.expiresAt,
  });

  factory PlaybackUrlModel.fromJson(Map<String, dynamic> json) {
    return PlaybackUrlModel(
      url: json['url']?.toString() ?? '',
      expiresAt: json['expiresAt']?.toString() ?? '',
    );
  }
}
