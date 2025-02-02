class Wallpaper {
  final String imageUrl;
  final String category;
  final List<String>? tags;

  Wallpaper({
    required this.imageUrl,
    required this.category,
    this.tags,
  });
}