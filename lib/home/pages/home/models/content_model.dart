class ContentItem {
  final int id;
  final String type; // فيديو / بودكاست / مقالة
  final int conditionId; // 1 to 4
  final String title;
  final String link;
  final String description;
  final int? doctorId; // links article to a specific doctor
  final String? articleBody; // full article text for مقالة type
  final String? doctorName; // doctor who wrote or is associated with article
  final String? imageUrl; // For preview images (like podcast thumbnails)

  ContentItem({
    required this.id,
    required this.type,
    required this.conditionId,
    required this.title,
    required this.link,
    required this.description,
    this.doctorId,
    this.articleBody,
    this.doctorName,
    this.imageUrl,
  });

  factory ContentItem.fromJson(Map<String, dynamic> json) {
    return ContentItem(
      id: json['id'] as int,
      type: json['type'] as String,
      conditionId: json['condition_id'] as int,
      title: json['title'] as String,
      link: json['link'] as String,
      description: json['description'] as String,
      doctorId: json['doctor_id'] as int?,
      articleBody: json['article_body'] as String?,
      doctorName: json['doctor_name'] as String?,
      imageUrl: json['image_url'] as String?,
    );
  }

  factory ContentItem.fromBackendJson(Map<String, dynamic> json, int defaultConditionId) {
    final doc = json['doctor'];
    final docName = doc != null ? (doc['fullName'] ?? doc['FullName']) : null;
    final docId = json['doctorId'] ?? json['DoctorId'] ?? json['doctor_id'] ?? doc?['id'] ?? doc?['Id'];

    final bodyContent = json['content'] ?? json['Content'] ?? json['body'] ?? json['Body'] ?? json['articleBody'] ?? json['article_body'] ?? '';
    final fileLink = json['fileUrl'] ?? json['FileUrl'] ?? json['filePath'] ?? json['FilePath'] ?? json['link'] ?? '';
    final desc = json['description'] ?? json['Description'] ?? (bodyContent.toString().length > 100 ? bodyContent.toString().substring(0, 100) + '...' : bodyContent);

    return ContentItem(
      id: json['id'] ?? json['Id'] ?? 0,
      type: 'مقالة',
      conditionId: json['conditionId'] ?? json['ConditionId'] ?? json['condition_id'] ?? defaultConditionId,
      title: json['title'] ?? json['Title'] ?? 'مقالة علاجية',
      link: fileLink,
      description: desc,
      doctorId: docId,
      articleBody: bodyContent,
      doctorName: docName ?? json['doctorName'] ?? json['DoctorName'] ?? '',
      imageUrl: json['imageUrl'] ?? json['ImageUrl'] ?? json['image_url'],
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
      'image_url': imageUrl,
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

  // Check if type is article
  bool get isArticle => type == 'مقالة';
}
