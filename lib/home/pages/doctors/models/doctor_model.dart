class DoctorModel {
  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.price,
    this.isTopRated = false,
    this.isFavorite = false,
    this.experience = 8,
    this.reviewCount = 12,
    this.sessionDuration = 45,
    this.imageUrl,
  });

  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int price;
  final bool isTopRated;
  bool isFavorite;
  final int experience;
  final int reviewCount;
  final int sessionDuration;
  final String? imageUrl;

  /// Parse a doctor from the API JSON response.
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: (json['id'] ?? json['doctorId'] ?? '').toString(),
      name: json['fullName'] ?? json['name'] ?? json['firstName'] ?? '',
      specialty: json['specialization'] ?? json['specialty'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      price: (json['sessionPrice'] ?? json['price'] ?? 0).toInt(),
      isTopRated: json['isTopRated'] ?? false,
      isFavorite: json['isFavorite'] ?? false,
      experience: (json['experienceYears'] ?? json['experience'] ?? 0).toInt(),
      reviewCount: (json['reviewCount'] ?? 0).toInt(),
      sessionDuration: (json['sessionDuration'] ?? 45).toInt(),
    );
  }
}

final sampleDoctors = [
  DoctorModel(
    id: '1',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.9,
    price: 400,
    isTopRated: true,
    isFavorite: false,
    experience: 8,
    reviewCount: 12,
    sessionDuration: 45,
  ),
  DoctorModel(
    id: '2',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.9,
    price: 400,
    isTopRated: true,
    isFavorite: false,
    experience: 6,
    reviewCount: 8,
    sessionDuration: 45,
  ),
  DoctorModel(
    id: '3',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.8,
    price: 400,
    isTopRated: false,
    isFavorite: false,
    experience: 5,
    reviewCount: 10,
    sessionDuration: 60,
  ),
  DoctorModel(
    id: '4',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.8,
    price: 400,
    isTopRated: false,
    isFavorite: false,
    experience: 7,
    reviewCount: 15,
    sessionDuration: 45,
  ),
  DoctorModel(
    id: '5',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.7,
    price: 350,
    isTopRated: false,
    isFavorite: false,
    experience: 4,
    reviewCount: 6,
    sessionDuration: 30,
  ),
  DoctorModel(
    id: '6',
    name: 'د محمد الامام',
    specialty: 'دكتوراة في الطب النفسي',
    rating: 4.7,
    price: 350,
    isTopRated: false,
    isFavorite: false,
    experience: 4,
    reviewCount: 6,
    sessionDuration: 30,
  ),
];

List<DoctorModel> sampleFavorites() {
  return [
    DoctorModel(
      id: 'f1',
      name: 'د محمد الامام',
      specialty: 'دكتوراة في الطب النفسي',
      rating: 4.9,
      price: 400,
      isTopRated: true,
      isFavorite: true,
    ),
    DoctorModel(
      id: 'f2',
      name: 'د محمد الامام',
      specialty: 'دكتوراة في الطب النفسي',
      rating: 4.9,
      price: 400,
      isTopRated: true,
      isFavorite: true,
    ),
    DoctorModel(
      id: 'f3',
      name: 'د محمد الامام',
      specialty: 'دكتوراة في الطب النفسي',
      rating: 4.8,
      price: 400,
      isTopRated: false,
      isFavorite: true,
    ),
    DoctorModel(
      id: 'f4',
      name: 'د محمد الامام',
      specialty: 'دكتوراة في الطب النفسي',
      rating: 4.8,
      price: 400,
      isTopRated: false,
      isFavorite: true,
    ),
  ];
}