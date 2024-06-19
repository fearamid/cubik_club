class Promotion {
  final int id;
  final String title;
  final String text;
  final String coverLink;

  Promotion({
    required this.id,
    required this.title,
    required this.text,
    required this.coverLink,
  });

  static Promotion fromJson(Map<dynamic, dynamic> json) {
    return Promotion(
      id: json['id'],
      title: '${json['title']}',
      text: '${json['text']}',
      coverLink: '${json['cover_link']}',
    );
  }
}
