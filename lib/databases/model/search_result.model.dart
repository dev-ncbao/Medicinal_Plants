class SearchResult {
  final int? id;
  final String plantName;
  final String descriptions;
  final String image;

  SearchResult({
    this.id,
    required this.plantName,
    required this.descriptions,
    required this.image,
  });

  // Convert to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'plantName': plantName,
      'descriptions': descriptions,
      'image': image,
    };
  }

  // Create from Map retrieved from database
  factory SearchResult.fromMap(Map<String, dynamic> map) {
    return SearchResult(
      id: map['id'] as int?,
      plantName: map['plantName'] as String,
      descriptions: map['descriptions'] as String,
      image: map['image'] as String,
    );
  }

  @override
  String toString() {
    return 'SearchResult(id: $id, plantName: $plantName, descriptions: $descriptions, image: $image)';
  }
}
