class Post {
  final String imageUrl;
  final String description;
  final List<String> hashtags;
  final String posterName;
  final String posterImage; // URL for the poster's image
  final DateTime timestamp; // Time when the post was created

  Post({
    required this.imageUrl,
    required this.description,
    required this.hashtags,
    required this.posterName,
    required this.posterImage,
    required this.timestamp,
  });
}
