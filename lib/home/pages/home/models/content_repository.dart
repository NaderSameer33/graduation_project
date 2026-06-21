import 'content_model.dart';

class ContentRepository {
  static const List<String> doctorImages = [
    'assets/images/doctors/docto1.png',
    'assets/images/doctors/doctor2.png',
    'assets/images/doctors/doctor3.png',
    'assets/images/doctors/doctor4.png',
    'assets/images/doctors/doctor5.png',
    'assets/images/doctors/doctor6.png',
    'assets/images/doctors/doctor8.png',
    'assets/images/doctors/doctor9.png',
    'assets/images/doctors/doctor10.png',
    'assets/images/doctors/doctor11.png',
    'assets/images/doctors/doctor12.png',
    'assets/images/doctors/doctor13.png',
  ];

  static final List<ContentItem> _items = _rawItems.map((e) => ContentItem.fromJson(e)).toList();

  static List<ContentItem> getAll() => _items;

  static List<ContentItem> getByCondition(int conditionId) {
    return _items.where((e) => e.conditionId == conditionId).toList();
  }

  static List<ContentItem> getByType(String type) {
    return _items.where((e) => e.type == type).toList();
  }

  static List<ContentItem> getByConditionAndType(int conditionId, String type) {
    return _items.where((e) => e.conditionId == conditionId && e.type == type).toList();
  }

  static String getDoctorImage(int index) {
    return doctorImages[index % doctorImages.length];
  }

  static final List<Map<String, dynamic>> _rawItems = [
  {
    "id": 1,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي | الحلول العملية للتخلص من الاكتئاب والقلق والتوتر",
    "link": "https://www.youtube.com/watch?v=mj7cUkwOnVs",
    "description": "فيديو شامل يقدم حلولاً عملية مبنية على CBT للتعامل مع الاكتئاب الخفيف والمتوسط مع تمارين يومية"
  },
  {
    "id": 2,
    "type": "فيديو",
    "condition_id": 1,
    "title": "الدحيح | الاكتئاب",
    "link": "https://www.youtube.com/watch?v=VtGGjIhTANM",
    "description": "شرح علمي مبسط وممتع عن الاكتئاب وأسبابه وطرق التعامل معه"
  },
  {
    "id": 3,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي - المحاضرة الأولى CBT",
    "link": "https://www.youtube.com/watch?v=K-8NdYBUsZE",
    "description": "محاضرة أساسية عن مبادئ العلاج المعرفي السلوكي وتطبيقاته على الاكتئاب"
  },
  {
    "id": 4,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي - الاكتئاب ج1",
    "link": "https://www.youtube.com/watch?v=jhpdMQ607TM",
    "description": "شرح مفصل من د. نادر عطاالله لتطبيق CBT في علاج الاكتئاب مع أمثلة عملية"
  },
  {
    "id": 5,
    "type": "بودكاست",
    "condition_id": 1,
    "title": "عن الاكتئاب والتعافي وإصلاح العلاقة مع النفس",
    "link": "https://www.youtube.com/watch?v=bOr-QcW3VfQ",
    "description": "نقاش عميق عن رحلة التعافي من الاكتئاب باستخدام العلاج المعرفي السلوكي"
  },
  {
    "id": 6,
    "type": "فيديو",
    "condition_id": 1,
    "title": "آرون بيك | تقنيات العلاج المعرفي السلوكي CBT مع الاكتئاب",
    "link": "https://www.youtube.com/watch?v=Y18bppCh9Po",
    "description": "شرح تقنيات آرون بيك الأساسية لعلاج الاكتئاب باستخدام CBT"
  },
  {
    "id": 7,
    "type": "فيديو",
    "condition_id": 1,
    "title": "أساليب علاج الاكتئاب بالعلاج المعرفي السلوكي",
    "link": "https://www.youtube.com/watch?v=vyigGSMkC7M",
    "description": "طرق تطبيق CBT لعلاج الاكتئاب في المنزل مع نصائح عملية"
  },
  {
    "id": 8,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج النفسي للاكتئاب بالعلاج المعرفي السلوكي",
    "link": "https://www.youtube.com/watch?v=E35EMlC7-vI",
    "description": "كيف يفكر المريض أثناء تطبيق CBT للتغلب على الاكتئاب"
  },
  {
    "id": 9,
    "type": "فيديو",
    "condition_id": 1,
    "title": "تغلب على الاكتئاب النفسي بـ 10 وسائل عملية",
    "link": "https://www.youtube.com/watch?v=IG8yHNgXsLk",
    "description": "10 وسائل عملية ومُجربة لتحسين المزاج والخروج من الاكتئاب"
  },
  {
    "id": 10,
    "type": "فيديو",
    "condition_id": 2,
    "title": "العلاج المعرفي السلوكي لاضطرابات القلق",
    "link": "https://www.youtube.com/watch?v=toI1U8nskpY",
    "description": "برنامج CBT متخصص في علاج القلق العام ونوبات الهلع"
  },
  {
    "id": 11,
    "type": "فيديو",
    "condition_id": 2,
    "title": "دليل شامل حول العلاج المعرفي السلوكي للتغلب على القلق",
    "link": "https://www.youtube.com/watch?v=quGF7suPswM",
    "description": "شرح مبسط لكيفية استخدام CBT لتغيير أنماط التفكير السلبية المرتبطة بالقلق"
  },
  {
    "id": 12,
    "type": "فيديو",
    "condition_id": 2,
    "title": "العلاج المعرفي السلوكي للقلق العام والخوف المرضي ج1",
    "link": "https://www.youtube.com/watch?v=0GTYD8-EOBo",
    "description": "محاضرة متخصصة عن علاج القلق العام باستخدام CBT"
  },
  {
    "id": 13,
    "type": "فيديو",
    "condition_id": 2,
    "title": "تمارين التنفس والاسترخاء لتقليل نوبات القلق",
    "link": "https://www.youtube.com/watch?v=example-cbt-breathing",
    "description": "تمارين تنفس عميق واسترخاء فعالة لتهدئة القلق فورًا"
  },
  {
    "id": 14,
    "type": "بودكاست",
    "condition_id": 2,
    "title": "كيف تتخلص من القلق والتفكير الزائد",
    "link": "https://www.youtube.com/watch?v=ESM0ZvYjWtU",
    "description": "حلقة عملية تساعد على السيطرة على نوبات القلق باستخدام أدوات CBT"
  },
  {
    "id": 15,
    "type": "فيديو",
    "condition_id": 2,
    "title": "علاج القلق باستخدام فنيات العلاج المعرفي السلوكي البصري",
    "link": "https://www.youtube.com/watch?v=FaEpdYxltI8",
    "description": "تقنيات بصرية حديثة من CBT لعلاج القلق"
  },
  {
    "id": 16,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الاحتراق النفسي (Burnout) في عصر السرعة",
    "link": "https://www.youtube.com/watch?v=gm-_RpuFBsc",
    "description": "شرح أسباب الاحتراق النفسي وعلاماته وطرق التعافي باستخدام CBT"
  },
  {
    "id": 17,
    "type": "فيديو",
    "condition_id": 3,
    "title": "ما هو الإحتراق المهني؟",
    "link": "https://www.youtube.com/watch?v=RbSdY1kVJs4",
    "description": "تعريف الاحتراق النفسي وكيفية التعامل معه في بيئة العمل"
  },
  {
    "id": 18,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي Burnout - تعلم ترتاح قبل مايفوت الفوت",
    "link": "https://www.youtube.com/watch?v=ymjrwOxPcbU",
    "description": "خطوات عملية للخروج من الاحتراق النفسي واستعادة الطاقة"
  },
  {
    "id": 19,
    "type": "بودكاست",
    "condition_id": 3,
    "title": "الفرق بين الاحتراق النفسي والاكتئاب",
    "link": "https://www.youtube.com/watch?v=L7GkcYScluk",
    "description": "نقاش يوضح الفرق بين الاحتراق النفسي والاكتئاب وكيفية التعامل مع كل منهما"
  },
  {
    "id": 20,
    "type": "فيديو",
    "condition_id": 3,
    "title": "كيف تتجنب الإحتراق النفسي",
    "link": "https://www.youtube.com/watch?v=jU61Gh-j0b4",
    "description": "نصائح وقائية لتجنب الاحتراق النفسي في الحياة اليومية"
  },
  {
    "id": 21,
    "type": "فيديو",
    "condition_id": 4,
    "title": "7 تمارين توقف مخك عن التفكير الزائد",
    "link": "https://www.youtube.com/watch?v=Agu62_D21JM",
    "description": "تمارين عملية مباشرة لإيقاف التفكير المفرط والاجترار فكري"
  },
  {
    "id": 22,
    "type": "فيديو",
    "condition_id": 4,
    "title": "تمارين وخطوات تطبيقية للعلاج من التفكير الزائد والتوتر",
    "link": "https://www.youtube.com/watch?v=DLWlyvm6PIA",
    "description": "حلول عملية وتمارين CBT للتخلص من التفكير المفرط"
  },
  {
    "id": 23,
    "type": "بودكاست",
    "condition_id": 4,
    "title": "كيف تتخلص من التفكير الزائد والقلق",
    "link": "https://www.youtube.com/watch?v=YoZ2s8jMeYA",
    "description": "حلقة عملية عن كسر دائرة التفكير الزائد والاجترار"
  },
  {
    "id": 24,
    "type": "فيديو",
    "condition_id": 4,
    "title": "كيفية التغلب على الاجترار والتفكير المفرط",
    "link": "https://www.youtube.com/watch?v=Weu1nVeE3ps",
    "description": "طرق CBT فعالة للتعامل مع الأفكار المتكررة والسلبية"
  },
  {
    "id": 25,
    "type": "فيديو",
    "condition_id": 4,
    "title": "فارماستان - التفكير المفرط | Overthinking",
    "link": "https://www.youtube.com/watch?v=rrJIpFb3Y0U",
    "description": "شرح علمي مبسط عن التفكير المفرط وكيفية الخروج منه"
  },
  {
    "id": 26,
    "type": "فيديو",
    "condition_id": 1,
    "title": "تغلب على الاكتئاب النفسي بـ 10 وسائل عملية",
    "link": "https://www.youtube.com/watch?v=IG8yHNgXsLk",
    "description": "10 وسائل عملية ومجربة لتحسين المزاج والخروج من الاكتئاب"
  },
  {
    "id": 27,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج النفسي للاكتئاب (CBT) وكيف يجب أن يفكر المريض",
    "link": "https://www.youtube.com/watch?v=E35EMlC7-vI",
    "description": "كيف يغير المريض طريقة تفكيره أثناء تطبيق العلاج المعرفي السلوكي"
  },
  {
    "id": 28,
    "type": "فيديو",
    "condition_id": 2,
    "title": "علاج اضطراب القلق العام: أكثر من مجرد أدوية",
    "link": "https://www.youtube.com/watch?v=rwn7vo8pD8g",
    "description": "علاج القلق العام باستخدام CBT مع نصائح عملية"
  },
  {
    "id": 29,
    "type": "فيديو",
    "condition_id": 2,
    "title": "CBT for Anxiety - د. داليا السمني",
    "link": "https://www.youtube.com/watch?v=QpIeneK0o6c",
    "description": "جلسة عن العلاج المعرفي السلوكي للقلق"
  },
  {
    "id": 30,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي - تعلم ترتاح قبل مايفوت الفوت",
    "link": "https://www.youtube.com/watch?v=ymjrwOxPcbU",
    "description": "خطوات عملية للخروج من الاحتراق النفسي"
  },
  {
    "id": 31,
    "type": "فيديو",
    "condition_id": 3,
    "title": "كيف تتجنب الإحتراق النفسي",
    "link": "https://www.youtube.com/watch?v=jU61Gh-j0b4",
    "description": "نصائح وقائية لتجنب الاحتراق النفسي في الحياة اليومية"
  },
  {
    "id": 32,
    "type": "فيديو",
    "condition_id": 4,
    "title": "ازاي توقف التفكير الزائد Overthinking",
    "link": "https://www.youtube.com/watch?v=PHug3Q2BytI",
    "description": "نصائح عملية من عمرو خالد لإيقاف التفكير الزائد"
  },
  {
    "id": 33,
    "type": "فيديو",
    "condition_id": 1,
    "title": "برنامج الاكتئاب CBT For Depression - محاضرة تعريفية",
    "link": "https://www.youtube.com/watch?v=AWJDO7_CIpk",
    "description": "محاضرة تعريفية عن برنامج CBT لعلاج الاكتئاب"
  },
  {
    "id": 34,
    "type": "فيديو",
    "condition_id": 2,
    "title": "Cognitive Behavioural Therapy (CBT) by Dr Imad Mahmoud",
    "link": "https://www.youtube.com/watch?v=wDBuzwhafBg",
    "description": "شرح CBT بالعربية مع أمثلة عملية لعلاج القلق"
  },
  {
    "id": 35,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي - كتاب ويلمار شوفلي",
    "link": "https://www.youtube.com/watch?v=64Iq7K8l0os",
    "description": "ملخص كتاب مهم عن مراحل وأسباب الاحتراق النفسي"
  },
  {
    "id": 36,
    "type": "فيديو",
    "condition_id": 4,
    "title": "التفكير الزائد وأثره على نفسيتك",
    "link": "https://www.youtube.com/watch?v=qqj6HDqm-_w",
    "description": "الدكتور أحمد هارون يوضح تأثير التفكير الزائد وكيفية التعامل معه"
  },
  {
    "id": 37,
    "type": "فيديو",
    "condition_id": 1,
    "title": "كيف تعرف أنك مصاب بالاكتئاب؟",
    "link": "https://www.youtube.com/watch?v=Ayy1ZACO4kc",
    "description": "علامات الاكتئاب وخطوات أولية للعلاج باستخدام CBT"
  },
  {
    "id": 38,
    "type": "فيديو",
    "condition_id": 2,
    "title": "القلق العام",
    "link": "https://www.youtube.com/watch?v=6csIyLmXy9M",
    "description": "شرح اضطراب القلق العام وطرق علاجه"
  },
  {
    "id": 39,
    "type": "فيديو",
    "condition_id": 3,
    "title": "القاتل الصامت - الاحتراق النفسي",
    "link": "https://www.youtube.com/watch?v=ZPvayFD_bbw",
    "description": "حلقة عن الاحتراق النفسي وتأثيره على الحياة"
  },
  {
    "id": 40,
    "type": "فيديو",
    "condition_id": 4,
    "title": "هتتخلص من التفكير المفرط بعد الفيديو دا",
    "link": "https://www.youtube.com/watch?v=Jfl2M6Cuztw",
    "description": "طرق سريعة وفعالة لإيقاف التفكير المفرط"
  },
  {
    "id": 41,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي والتحكم في الأفكار السلبية",
    "link": "https://www.youtube.com/watch?v=example-negative-thoughts",
    "description": "كيفية التحكم في الأفكار السلبية باستخدام تقنيات CBT"
  },
  {
    "id": 42,
    "type": "فيديو",
    "condition_id": 2,
    "title": "علاج القلق بالتعرض التدريجي",
    "link": "https://www.youtube.com/watch?v=example-exposure-therapy",
    "description": "تقنية التعرض التدريجي من CBT لعلاج القلق"
  },
  {
    "id": 43,
    "type": "فيديو",
    "condition_id": 3,
    "title": "استعادة التوازن بعد الاحتراق الوظيفي",
    "link": "https://www.youtube.com/watch?v=example-burnout-balance",
    "description": "نصائح عملية لاستعادة الطاقة بعد فترة الإرهاق الشديد"
  },
  {
    "id": 44,
    "type": "فيديو",
    "condition_id": 4,
    "title": "دعاء يخلصك من التوتر والقلق الزائد",
    "link": "https://www.facebook.com/AmrKhaled/videos/654616410384123/",
    "description": "دعاء ونصائح روحية وعملية لتقليل التفكير الزائد"
  },
  {
    "id": 45,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي - الاكتئاب ج2",
    "link": "https://www.youtube.com/watch?v=example-cbt-depression-part2",
    "description": "الجزء الثاني من سلسلة علاج الاكتئاب بـ CBT"
  },
  {
    "id": 46,
    "type": "فيديو",
    "condition_id": 2,
    "title": "الخوف من المستقبل | علاج القلق والتوتر",
    "link": "https://www.youtube.com/watch?v=example-fear-future",
    "description": "كيفية التعامل مع القلق المستقبلي باستخدام CBT"
  },
  {
    "id": 47,
    "type": "فيديو",
    "condition_id": 3,
    "title": "Burnout الإحتراق - الجزء الأول",
    "link": "https://www.youtube.com/watch?v=-QXtCaLUM_4",
    "description": "الجزء الأول من سلسلة الاحتراق النفسي"
  },
  {
    "id": 48,
    "type": "فيديو",
    "condition_id": 4,
    "title": "التفكير الزائد - Overthinking",
    "link": "https://www.youtube.com/watch?v=rrJIpFb3Y0U",
    "description": "شرح علمي عن التفكير المفرط وكيفية الخروج منه"
  },
  {
    "id": 49,
    "type": "فيديو",
    "condition_id": 1,
    "title": "كيف تصاب بالاكتئاب؟",
    "link": "https://www.youtube.com/watch?v=example-how-depression-starts",
    "description": "أسباب الاكتئاب وكيفية الوقاية المبكرة"
  },
  {
    "id": 50,
    "type": "فيديو",
    "condition_id": 2,
    "title": "القلق والتوتر - حلول عملية",
    "link": "https://www.youtube.com/watch?v=GfUVpqcvIO0",
    "description": "طرق التعامل مع التوتر والقلق بأساليب CBT"
  },
  {
    "id": 51,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي جزء 1",
    "link": "https://www.youtube.com/watch?v=gawpL8uDHsw",
    "description": "مقدمة عن الاحتراق النفسي وأعراضه"
  },
  {
    "id": 52,
    "type": "فيديو",
    "condition_id": 4,
    "title": "هتتخلص من التفكير المفرط",
    "link": "https://www.youtube.com/watch?v=Jfl2M6Cuztw",
    "description": "طرق سريعة وفعالة لإيقاف التفكير المفرط"
  },
  {
    "id": 53,
    "type": "فيديو",
    "condition_id": 2,
    "title": "CBT from scratch - part 1",
    "link": "https://www.youtube.com/watch?v=gI4JeWvQa84",
    "description": "دورة CBT من الصفر لعلاج القلق"
  },
  {
    "id": 54,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي - الجزء الثاني",
    "link": "https://www.youtube.com/watch?v=example-burnout-part2",
    "description": "استمرارية سلسلة الاحتراق النفسي وطرق التعافي"
  },
  {
    "id": 55,
    "type": "فيديو",
    "condition_id": 4,
    "title": "التفكير الزائد وتأثيراته على العقل",
    "link": "https://www.tiktok.com/@dr_ahmed_ashraf/video/7590349718018919701",
    "description": "تأثير التفكير الزائد على الصحة النفسية وكيفية السيطرة عليه"
  },
  {
    "id": 56,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي - الاكتئاب ج3",
    "link": "https://www.youtube.com/watch?v=MrTTi1WAkgE",
    "description": "الجزء الثالث من سلسلة علاج الاكتئاب بـ CBT"
  },
  {
    "id": 57,
    "type": "فيديو",
    "condition_id": 2,
    "title": "علاج القلق بالتعرض التدريجي",
    "link": "https://www.youtube.com/watch?v=example-exposure",
    "description": "تقنية التعرض التدريجي من CBT لعلاج القلق"
  },
  {
    "id": 58,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الاحتراق النفسي: الأعراض والعلاج",
    "link": "https://www.youtube.com/watch?v=ZPvayFD_bbw",
    "description": "حلقة شاملة عن أعراض وعلاج الاحتراق النفسي"
  },
  {
    "id": 59,
    "type": "بودكاست",
    "condition_id": 4,
    "title": "Ep 6 : Overthinking التفكير الزائد",
    "link": "https://www.youtube.com/watch?v=N6FUUESGWZQ",
    "description": "حلقة بودكاست عن التفكير الزائد وتأثيره"
  },
  {
    "id": 60,
    "type": "فيديو",
    "condition_id": 2,
    "title": "القلق المدرسي وعلاجه بـ CBT",
    "link": "https://www.youtube.com/watch?v=example-school-anxiety",
    "description": "علاج القلق المدرسي باستخدام العلاج المعرفي السلوكي"
  },
  {
    "id": 61,
    "type": "فيديو",
    "condition_id": 3,
    "title": "Burnout الإحتراق - الجزء الثالث",
    "link": "https://www.youtube.com/watch?v=example-burnout-part3",
    "description": "استمرار سلسلة الاحتراق النفسي والتعافي"
  },
  {
    "id": 62,
    "type": "فيديو",
    "condition_id": 4,
    "title": "دعاء يخلصك من التوتر والقلق الزائد",
    "link": "https://www.facebook.com/AmrKhaled/videos/654616410384123/",
    "description": "دعاء ونصائح لتقليل التفكير الزائد والتوتر"
  },
  {
    "id": 63,
    "type": "فيديو",
    "condition_id": 1,
    "title": "الشفاء من الأكتئاب",
    "link": "https://www.youtube.com/watch?v=cisaXI-_9jk",
    "description": "قصص تعافي ونصائح من خلال CBT"
  },
  {
    "id": 64,
    "type": "فيديو",
    "condition_id": 2,
    "title": "القلق والخوف - حلول CBT",
    "link": "https://www.youtube.com/watch?v=GfUVpqcvIO0",
    "description": "طرق التعامل مع القلق والخوف بأساليب علمية"
  },
  {
    "id": 65,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الإحتراق النفسي والإرهاق العاطفي",
    "link": "https://www.youtube.com/watch?v=64Iq7K8l0os",
    "description": "شرح مراحل الاحتراق النفسي وكيفية الخروج منها"
  },
  {
    "id": 66,
    "type": "فيديو",
    "condition_id": 4,
    "title": "التفكير الزائد - Overthinking",
    "link": "https://www.youtube.com/watch?v=Weu1nVeE3ps",
    "description": "تأثير التفكير الزائد وطرق السيطرة عليه"
  },
  {
    "id": 67,
    "type": "فيديو",
    "condition_id": 1,
    "title": "كيف تصاب بالاكتئاب وكيف تخرج منه",
    "link": "https://www.youtube.com/watch?v=Ayy1ZACO4kc",
    "description": "علامات الاكتئاب وخطوات التعافي العملية"
  },
  {
    "id": 68,
    "type": "فيديو",
    "condition_id": 4,
    "title": "ازاي توقف التفكير الزائد",
    "link": "https://www.youtube.com/watch?v=PHug3Q2BytI",
    "description": "نصائح مباشرة لإيقاف التفكير الزائد والعودة للحاضر"
  },
  {
    "id": 69,
    "type": "فيديو",
    "condition_id": 4,
    "title": "كيف تتخلص من التفكير الزائد والقلق؟",
    "link": "https://www.youtube.com/watch?v=ESM0ZvYjWtU",
    "description": "بودكاست عملي يشرح أسباب التفكير الزائد وطرق التعامل معه بالتنفس واليقظة"
  },
  {
    "id": 70,
    "type": "فيديو",
    "condition_id": 4,
    "title": "7 تمارين توقف مخك عن التفكير الزائد",
    "link": "https://www.youtube.com/watch?v=Agu62_D21JM",
    "description": "تمارين عملية وبسيطة لإيقاف سيل الأفكار المتكررة"
  },
  {
    "id": 71,
    "type": "فيديو",
    "condition_id": 4,
    "title": "تمارين وخطوات تطبيقية للعلاج من التفكير الزائد والتوتر",
    "link": "https://www.youtube.com/watch?v=DLWlyvm6PIA",
    "description": "حلول تطبيقية مباشرة لكسر دوامة التفكير السلبي"
  },
  {
    "id": 72,
    "type": "فيديو",
    "condition_id": 1,
    "title": "العلاج المعرفي السلوكي | الحلول العملية للتخلص من الاكتئاب والقلق",
    "link": "https://www.youtube.com/watch?v=mj7cUkwOnVs",
    "description": "فيديو شامل ومفصل جداً عن تقنيات CBT لعلاج الاكتئاب الخفيف"
  },
  {
    "id": 73,
    "type": "فيديو",
    "condition_id": 1,
    "title": "آرون بيك | تقنيات العلاج المعرفي السلوكي مع الاكتئاب",
    "link": "https://www.youtube.com/watch?v=Y18bppCh9Po",
    "description": "شرح تقنيات CBT الأساسية مع التركيز على الاكتئاب"
  },
  {
    "id": 74,
    "type": "فيديو",
    "condition_id": 2,
    "title": "CBT Anxiety - العلاج المعرفي السلوكي للقلق",
    "link": "https://www.youtube.com/watch?v=QpIeneK0o6c",
    "description": "محاضرة متخصصة عن تطبيق CBT في علاج اضطرابات القلق"
  },
  {
    "id": 75,
    "type": "فيديو",
    "condition_id": 3,
    "title": "ازاي اعالج حالة الاحتراق النفسي",
    "link": "https://www.youtube.com/watch?v=ihVBm8njXJk",
    "description": "شرح واضح لأعراض الاحتراق النفسي وكيفية علاجه والوقاية منه"
  },
  {
    "id": 76,
    "type": "فيديو",
    "condition_id": 3,
    "title": "الاحتراق النفسي (Burnout) في عصر السرعة",
    "link": "https://www.youtube.com/watch?v=gm-_RpuFBsc",
    "description": "حوار عميق مع د. عمرو سليمان عن أسباب وعلاج الاحتراق النفسي"
  },
  {
    "id": 77,
    "type": "فيديو",
    "condition_id": 4,
    "title": "جلسة اليقظة الذهنية Mindfulness Meditation",
    "link": "https://www.youtube.com/watch?v=aBlkMReflz0",
    "description": "جلسة تأمل موجهة بالعربية لتعزيز اليقظة الذهنية وتهدئة العقل"
  },
  {
    "id": 78,
    "type": "فيديو",
    "condition_id": 1,
    "title": "أساليب علاج الاكتئاب - العلاج المعرفي السلوكي",
    "link": "https://www.youtube.com/watch?v=vyigGSMkC7M",
    "description": "شرح مبسط لتطبيق CBT في علاج الاكتئاب"
  },
  {
    "id": 79,
    "type": "فيديو",
    "condition_id": 4,
    "title": "اليقظة الذهنية - فحص وتتبع أعضاء الجسم (Body Scan)",
    "link": "https://www.youtube.com/watch?v=WH7zAZ0gEgI",
    "description": "تمرين يقظة ذهنية قوي للعودة إلى الحاضر وتقليل التفكير الزائد"
  }
];
}
