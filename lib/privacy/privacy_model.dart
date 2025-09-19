class PrivacyPolicy {
  final String title;
  final String content;
  final DateTime lastUpdated;

  PrivacyPolicy({
    required this.title,
    required this.content,
    required this.lastUpdated,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    return PrivacyPolicy(
      title: json['title'] ?? 'Privacy Policy',
      content: json['content'] ?? '',
      lastUpdated: DateTime.tryParse(json['last_updated'] ?? '') ?? DateTime.now(),
    );
  }
}
