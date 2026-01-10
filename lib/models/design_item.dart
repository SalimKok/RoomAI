class DesignItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final String? badgeText;

  DesignItem({
    required this.title,
    required this.imagePath,
    this.subtitle = "",
    this.badgeText,
  });
}