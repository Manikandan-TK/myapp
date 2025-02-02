class Quote {
  final String text;
  final String? author;
  final String category;
  final String? source;

  Quote({
    required this.text,
    this.author,
    required this.category,
    this.source,
  });
}
