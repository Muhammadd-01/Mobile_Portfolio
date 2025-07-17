class Project {
  final int id;
  final String title;
  final String category;
  final String imageUrl;
  final String description;
  final List<String> technologies;
  final String github;
  final String live;

  Project({
    required this.id,
    required this.title,
    required this.category,
    required this.imageUrl,
    required this.description,
    required this.technologies,
    required this.github,
    required this.live,
  });
}
