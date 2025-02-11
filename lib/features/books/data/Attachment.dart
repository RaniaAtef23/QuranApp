class Attachment {
  final int order;
  final String size;
  final String extensionType;
  final String description;
  final String url;

  Attachment({
    required this.order,
    required this.size,
    required this.extensionType,
    required this.description,
    required this.url,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      order: json['order'],
      size: json['size'],
      extensionType: json['extension_type'],
      description: json['description'],
      url: json['url'],
    );
  }
}
