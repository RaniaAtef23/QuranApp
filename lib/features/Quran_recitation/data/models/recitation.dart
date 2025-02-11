class Recitation {
  final int id;
  final String title;
  final int addDate;
  final String type;
  final List<PreparedBy> preparedBy; // List to hold the prepared_by details
  final String apiUrl;

  Recitation({
    required this.id,
    required this.title,
    required this.addDate,
    required this.type,
    required this.preparedBy,
    required this.apiUrl,
  });

  // Factory method to create Recitation from JSON
  factory Recitation.fromJson(Map<String, dynamic> json) {
    // Parsing the 'prepared_by' field as a list of PreparedBy objects
    var preparedByList = json['prepared_by'] as List? ?? [];
    List<PreparedBy> preparedBy = preparedByList
        .map((item) => PreparedBy.fromJson(item))
        .toList();

    return Recitation(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      addDate: json['add_date'] ?? 0,
      type: json['type'] ?? '',
      preparedBy: preparedBy,
      apiUrl: json['api_url'] ?? '',
    );
  }
}

// Model for the "prepared_by" field
class PreparedBy {
  final int id;
  final int sourceId;
  final String title;
  final String type;
  final String kind;

  PreparedBy({
    required this.id,
    required this.sourceId,
    required this.title,
    required this.type,
    required this.kind,
  });

  // Factory method to create PreparedBy from JSON
  factory PreparedBy.fromJson(Map<String, dynamic> json) {
    return PreparedBy(
      id: json['id'] ?? 0,
      sourceId: json['source_id'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      kind: json['kind'] ?? '',
    );
  }
}
