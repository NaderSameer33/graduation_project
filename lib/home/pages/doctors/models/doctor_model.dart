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
    this.description = '',
    this.location = '',
    this.workingHours = '',
    this.fees = '',
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
  final String description;
  final String location;
  final String workingHours;
  final String fees;

  /// Available doctor images in assets/images/doctors/
  static const List<String> _doctorImages = [
    'doctors/docto1.png',
    'doctors/doctor2.png',
    'doctors/doctor3.png',
    'doctors/doctor4.png',
    'doctors/doctor5.png',
    'doctors/doctor6.png',
    'doctors/doctor8.png',
    'doctors/doctor9.png',
    'doctors/doctor10.png',
    'doctors/doctor11.png',
    'doctors/doctor12.png',
    'doctors/doctor13.png',
  ];

  /// Returns an image path from the doctors folder, cycling through available images.
  String get image {
    final intId = int.tryParse(id) ?? 0;
    return _doctorImages[intId % _doctorImages.length];
  }

  /// Parse a doctor from the API JSON response.
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    int parsedPrice = 0;
    final rawFees = json['fees'] ?? json['sessionPrice'] ?? json['price'];
    if (rawFees != null) {
      if (rawFees is num) {
        parsedPrice = rawFees.toInt();
      } else if (rawFees is String) {
        final match = RegExp(r'\d+').firstMatch(rawFees);
        if (match != null) {
          parsedPrice = int.tryParse(match.group(0)!) ?? 0;
        }
      }
    }

    // Determine ID to ensure unique indexing
    final intId = json['id'] as int? ?? 1;

    return DoctorModel(
      id: (json['id'] ?? json['doctorId'] ?? '').toString(),
      name: json['name'] ?? json['fullName'] ?? json['firstName'] ?? '',
      specialty: json['specialty'] ?? json['specialization'] ?? 'أخصائي الطب النفسي وعلاج الإدمان',
      rating: (json['rating'] ?? (4.0 + (intId % 10) / 10).clamp(4.0, 5.0)).toDouble(),
      price: parsedPrice > 0 ? parsedPrice : 400,
      isTopRated: json['isTopRated'] ?? (intId % 3 == 0),
      isFavorite: json['isFavorite'] ?? false,
      experience: (json['experienceYears'] ?? json['experience'] ?? (5 + (intId % 8))).toInt(),
      reviewCount: (json['reviewCount'] ?? (10 + (intId % 25))).toInt(),
      sessionDuration: (json['sessionDuration'] ?? 45).toInt(),
      description: json['description'] ?? 'أخصائي واستشاري متميز في تقديم الرعاية والدعم النفسي الشامل بأحدث المنهجيات والبرامج العلاجية.',
      location: json['location'] ?? 'المنصورة',
      workingHours: json['working_hours'] ?? json['workingHours'] ?? 'حسب المواعيد المتاحة',
      fees: json['fees'] ?? '${parsedPrice > 0 ? parsedPrice : 400} جنيه',
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Raw Json List containing the 50 Doctors provided by the user
// ─────────────────────────────────────────────────────────────────────────────
final List<Map<String, dynamic>> rawDoctorsJson = [
  {
    "id": 1,
    "name": "دكتور أمير سمير",
    "description": "أخصائي الطب النفسي وعلاج الإدمان، عضو الجمعية الأمريكية للطب النفسي. متخصص في الاكتئاب، القلق، الوسواس القهري، نوبات الهلع والإدمان للبالغين.",
    "location": "المنصورة - شارع الاتوبيس الجديد - مركز ثقة للطب النفسي (بعد سور الكهرباء)",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta (غالباً من 12 ظهراً إلى 10 مساءً)",
    "fees": "400 جنيه"
  },
  {
    "id": 2,
    "name": "دكتور محمد الوصيفي",
    "description": "أستاذ الطب النفسي والإدمان وأمراض النوم - جامعة المنصورة. متخصص في ADHD، الطب النفسي للأطفال والبالغين، والإدمان.",
    "location": "المنصورة - ميت حيدر - خلف مسجد سيدي سعد - برج اللؤلؤة - الدور الثالث",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "500-700 جنيه"
  },
  {
    "id": 3,
    "name": "دكتور علاء صبحي",
    "description": "أخصائي الطب النفسي وعلاج الإدمان. يعالج الاضطرابات النفسية، الفصام، اضطرابات الشيخوخة والإدمان.",
    "location": "المنصورة - شارع أحمد ماهر - مقابل السجل المدني",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "350-400 جنيه"
  },
  {
    "id": 4,
    "name": "دكتور مصطفى أبو الدهب",
    "description": "أخصائي الطب النفسي وعلاج الإدمان. مدير عيادات متخصصة في الصحة النفسية والإدمان.",
    "location": "المنصورة - عيادات د. مصطفى أبو الدهب",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta وEkshef",
    "fees": "400-500 جنيه"
  },
  {
    "id": 5,
    "name": "دكتور محمد شعبان",
    "description": "أخصائي الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة - شارع بنك مصر - برج مكين للأطباء - الدور الثاني",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "450 جنيه"
  },
  {
    "id": 6,
    "name": "دكتور أحمد شحاته",
    "description": "استشاري الطب النفسي. متخصص في الصحة النفسية والعلاج النفسي.",
    "location": "المنصورة - شارع الاتوبيس الجديد",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "400 جنيه"
  },
  {
    "id": 7,
    "name": "دكتور أحمد سعد",
    "description": "استشاري أول وأستاذ مساعد الطب النفسي وعلاج الإدمان - كلية طب المنصورة. متخصص في العلاج الزواجي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "400-500 جنيه"
  },
  {
    "id": 8,
    "name": "دكتور أحمد عبد الفتاح",
    "description": "أخصائي الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة - حي الجامعة - شارع معاذ بن جبل",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "350 جنيه"
  },
  {
    "id": 9,
    "name": "دكتور هيثم البرعي",
    "description": "دكتوراه ومدرس الطب النفسي. متخصص في الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "700 جنيه"
  },
  {
    "id": 10,
    "name": "دكتور وليد عبيد علي",
    "description": "استشاري أمراض المخ والأعصاب والطب النفسي وعلاج الإدمان - جامعة القاهرة.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "500-600 جنيه"
  },
  {
    "id": 11,
    "name": "دكتور أحمد صلاح",
    "description": "أخصائي الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة - حي الجامعة - خلف عوض سراج",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 12,
    "name": "دكتورة سارة وائل",
    "description": "أخصائية الطب النفسي. متخصصة في الصحة النفسية.",
    "location": "المنصورة - ميدان المحطة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "360-400 جنيه"
  },
  {
    "id": 13,
    "name": "دكتور محمود الوصيفي",
    "description": "أستاذ الطب النفسي - جامعة المنصورة. متخصص في الطب النفسي للأطفال والبالغين والإدمان.",
    "location": "المنصورة - ميدان المحطة أو ميت حيدر",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "500-700 جنيه"
  },
  {
    "id": 14,
    "name": "دكتور أحمد حمدى",
    "description": "أخصائي الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "400 جنيه"
  },
  {
    "id": 15,
    "name": "دكتور إبراهيم حمدى راشد القلا",
    "description": "أستاذ مساعد الطب النفسي.",
    "location": "المنصورة - شارع حسين بيه",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "450 جنيه"
  },
  {
    "id": 16,
    "name": "دكتور محمود حامد",
    "description": "استشاري الطب النفسي وعلاج الإدمان والأمراض العصبية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400-500 جنيه"
  },
  {
    "id": 17,
    "name": "دكتورة مها برهام",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "400 جنيه"
  },
  {
    "id": 18,
    "name": "دكتور محمد حمادة",
    "description": "استشاري الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "450 جنيه"
  },
  {
    "id": 19,
    "name": "دكتورة ولاء عبد العزيز",
    "description": "أخصائية الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 20,
    "name": "دكتور محمود جمعة",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "700 جنيه"
  },
  {
    "id": 21,
    "name": "دكتور محمود علي أبو نازل",
    "description": "أخصائي الأمراض العصبية والطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Ekshef",
    "fees": "400 جنيه"
  },
  {
    "id": 22,
    "name": "دكتور رشدي الجمل",
    "description": "أستاذ الطب النفسي - جامعة المنصورة.",
    "location": "المنصورة - ميدان المحطة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "500 جنيه"
  },
  {
    "id": 23,
    "name": "دكتور نعيم نخلة عبد الملك",
    "description": "استشاري الأمراض النفسية والعصبية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "450 جنيه"
  },
  {
    "id": 24,
    "name": "دكتور أحمد عوض حبيب",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Clinido",
    "fees": "400 جنيه"
  },
  {
    "id": 25,
    "name": "دكتورة رضوي عزيز",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 26,
    "name": "دكتور محمد فريد أبو الهدى",
    "description": "استشاري الأمراض النفسية والعصبية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "450 جنيه"
  },
  {
    "id": 27,
    "name": "دكتورة أسماء محمد رفعت",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 28,
    "name": "دكتورة نداء نسيم",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 29,
    "name": "دكتورة علا سامي",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 30,
    "name": "دكتور أحمد ضبيع",
    "description": "أخصائي الطب النفسي وعلاج الإدمان - مركز أجياد.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400-500 جنيه"
  },
  {
    "id": 31,
    "name": "دكتور عبد المنعم محمد",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة على Vezeeta",
    "fees": "400 جنيه"
  },
  {
    "id": 32,
    "name": "دكتور محمود حسن عبد الرحمن",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 33,
    "name": "دكتورة أسماء مجدي",
    "description": "أخصائية الصحة النفسية ومعالجة نفسية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 34,
    "name": "دكتور رحاب محجوب",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "420 جنيه"
  },
  {
    "id": 35,
    "name": "دكتور محمد علي",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "460 جنيه"
  },
  {
    "id": 36,
    "name": "دكتورة ندى عبد العزيز",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "320 جنيه"
  },
  {
    "id": 37,
    "name": "دكتورة إنجي الطويل",
    "description": "أخصائية نفسية إكلينيكية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 38,
    "name": "دكتورة أية عبد الله",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 39,
    "name": "دكتور محمد عصام أمين",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 40,
    "name": "دكتور أحمد عبد المدبر",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 41,
    "name": "دكتور طارق عبد الغني",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 42,
    "name": "دكتور إسماعيل صالح",
    "description": "أخصائي الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 43,
    "name": "دكتور أحمد رضا",
    "description": "أخصائي الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 44,
    "name": "دكتورة منى منير",
    "description": "أخصائية نفسية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 45,
    "name": "دكتورة شيماء صبحي عمر",
    "description": "أخصائية الصحة النفسية والعلاقات الزوجية.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 46,
    "name": "دكتورة مريم كوريش",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 47,
    "name": "دكتورة زينب خالد",
    "description": "أخصائية الطب النفسي للبالغين.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 48,
    "name": "دكتورة إيناس محمود",
    "description": "أخصائية الطب النفسي للأطفال والمراهقين.",
    "location": "المنصورة - شارع سعد زغلول",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 49,
    "name": "دكتورة أسماء طه",
    "description": "أخصائية الطب النفسي وعلاج الإدمان.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  },
  {
    "id": 50,
    "name": "دكتورة رضوى عزيز",
    "description": "أخصائية الطب النفسي.",
    "location": "المنصورة",
    "working_hours": "حسب المواعيد المتاحة",
    "fees": "400 جنيه"
  }
];

final sampleDoctors = rawDoctorsJson.map((e) => DoctorModel.fromJson(e)).toList();

List<DoctorModel> sampleFavorites() {
  return sampleDoctors.where((d) => d.isTopRated).toList();
}