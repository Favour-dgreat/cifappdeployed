class NewsletterArticle {
  final String id;
  final String title;
  final String summary;
  final String image;
  final DateTime date;
  final String link;

  NewsletterArticle({
    required this.id,
    required this.title,
    required this.summary,
    required this.image,
    required this.date,
    required this.link,
  });

  factory NewsletterArticle.fromJson(Map<String, dynamic> json) {
    return NewsletterArticle(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      summary: json['summary'] ?? '',
      image: json['image'] ?? '',
      date: DateTime.parse(json['date']),
      link: json['link'] ?? '',
    );
  }
}
