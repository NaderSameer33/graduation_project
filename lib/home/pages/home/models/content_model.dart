class ContentItem {
  final int id;
  final String type; // فيديو / بودكاست
  final int conditionId; // 1 to 4
  final String title;
  final String link;
  final String description;

  ContentItem({
    required this.id,
    required this.type,
    required this.conditionId,
    required this.title,
    required this.link,
    required this.description,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] as int,
      type: json['type'] as String,
      conditionId: json['condition_id'] as int,
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'condition_id': conditionId,
      'title': title,
      'link': link,
      'description': description,
    };
  }

  // Returns the category label in Arabic based on conditionId
  String get categoryLabel {
    switch (conditionId) {
      case 1:
        return 'الاكتئاب';
      case 2:
        return 'الاجهاد والقلق';
      case 3:
        return 'الاحتراق النفسي';
      case 4:
        return 'التفكير الزائد';
      default:
        return 'أخرى';
    }
  }

  // Check if type is video
  bool get isVideo => type == 'فيديو';
  
  // Check if type is podcast
  bool get isPodcast => type == 'بودكاست';
}
