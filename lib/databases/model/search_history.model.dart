class SearchHistory {
  final int? id;
  final String keyword;

  SearchHistory({
    this.id,
    required this.keyword,
  });

  // Convert to Map for databases operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'keyword': keyword,
    };
  }

  // Create from Map retrieved from databases
  factory SearchHistory.fromMap(Map<String, dynamic> map) {
    return SearchHistory(
      id: map['id'] as int?,
      keyword: map['keyword'] as String,
    );
  }

  @override
  String toString() {
    return 'SearchHistory(id: $id, keyword: $keyword)';
  }
}