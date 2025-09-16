class EmptyStateData {
  final String iconData;
  final String title;
  final String subtitle;
  final String? actionText;

  const EmptyStateData({
    required this.iconData,
    required this.title,
    required this.subtitle,
    this.actionText,
  });
}
