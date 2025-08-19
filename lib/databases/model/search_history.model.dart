class SearchHistory {
  final int? id;
  final String keyword;
  final DateTime createdDate;

  SearchHistory({this.id, required this.keyword, required this.createdDate});

  // Convert to Map for databases operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'keyword': keyword,
      'createdDate': createdDate.toIso8601String(),
    };
  }

  // Create from Map retrieved from databases
  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['id'] as int?,
      keyword: map['keyword'] as String,
      createdDate: DateTime.parse(map['createdDate'] as String),
    );
  }

  @override
  String toString() {
    return 'SearchHistory(id: $id, keyword: $keyword, createdDate: $createdDate)';
  }
}
