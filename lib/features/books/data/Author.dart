class Author {
  final int id;
  final int sourceId;
  final String title;
  final String type;
  final String kind;
  final String? description;
  final String apiUrl;

  Author({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.type,
    required this.kind,
    this.description,
    required this.apiUrl,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'],
      sourceId: json['source_id'],
      title: json['title'],
      type: json['type'],
      kind: json['kind'],
      description: json['description'],
      apiUrl: json['api_url'],
    );
  }
}