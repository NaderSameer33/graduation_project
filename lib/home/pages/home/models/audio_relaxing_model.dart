import 'dart:convert';

class AudioRelaxing {
  final String id;
  final String fileName;
  final String titleAr;
  final String category;

  AudioRelaxing({
    required this.id,
    required this.fileName,
    required this.titleAr,
    required this.category,
  });

  factory AudioRelaxing.fromJson(Map<String, dynamic> json) {
    return AudioRelaxing(
      id: json['id'],
      fileName: json['file_name'],
      titleAr: json['title_ar'],
      category: json['category'],
    );
  }

  static List<AudioRelaxing> getAll() {
    final List<dynamic> data = json.decode(_audioRelaxingJson);
    return data.map((e) => AudioRelaxing.fromJson(e)).toList();
  }
}

const String _audioRelaxingJson = r'''
[
  {
    "id": "1",
    "file_name": "twowolvesreiki-rain-drum-sound-327761.mp3",
    "title_ar": "صوت المطر لتهدئة الأعصاب",
    "category": "nature"
  },
  {
    "id": "2",
    "file_name": "zehendrew-birds-chirping-meditation-calm-forest-528410.mp3",
    "title_ar": "صوت عصافير الغابة للاسترخاء",
    "category": "nature"
  },
  {
    "id": "3",
    "file_name": "fronbondi_skegs_pad_in_a_dream_state_calm_soothing_ambient_background.mp3",
    "title_ar": "أجواء ساكنة للمساعدة على النوم",
    "category": "sleep"
  },
  {
    "id": "4",
    "file_name": "samuelfjohanns-celestial-atmo-padsound-120664.mp3",
    "title_ar": "الضوضاء البيضاء للتفريغ الانفعالي",
    "category": "sleep"
  },
  {
    "id": "5",
    "file_name": "masterandmargarita-summer-rain-407441.mp3",
    "title_ar": "صوت مطر الصيف الهادئ",
    "category": "nature"
  },
  {
    "id": "6",
    "file_name": "sayakulov_relax_relaxation_meditation_rain_raindrops_medium_water.mp3",
    "title_ar": "تساقط قطرات المطر على الماء",
    "category": "nature"
  },
  {
    "id": "7",
    "file_name": "prem_adhikary-mountain-forest-high-quality-sound-176826.mp3",
    "title_ar": "أجواء غابات الجبال الطبيعية للتركيز",
    "category": "nature"
  },
  {
    "id": "8",
    "file_name": "gingerleegalaxy_1_asmr_anxiety_stress_relief_sleep_sounds_331045.mp3",
    "title_ar": "أصوات هادئة للتخلص من القلق",
    "category": "relaxation"
  },
  {
    "id": "9",
    "file_name": "samuelfjohanns-celloscape-113846.mp3",
    "title_ar": "أصوات دافئة لعزل الأفكار السلبية",
    "category": "relaxation"
  },
  {
    "id": "10",
    "file_name": "h-beats-meditation-effect-417525.mp3",
    "title_ar": "صوت هادئ لإيقاف التفكير الزائد",
    "category": "meditation"
  },
  {
    "id": "11",
    "file_name": "samuelfjohanns-beautiful-random-minor-arp-119378.mp3",
    "title_ar": "نغمات هادئة لراحة البال",
    "category": "relaxation"
  },
  {
    "id": "12",
    "file_name": "darren_hirst-gregorian-100-bpm-a-minor-399638.mp3",
    "title_ar": "أجواء مريحة للتخلص من قلق الليل",
    "category": "meditation"
  },
  {
    "id": "13",
    "file_name": "idoberg-relaxing-guitar-loop-v5-245859.mp3",
    "title_ar": "أصوات ناعمة لتقليل التوتر والاسترخاء",
    "category": "relaxation"
  },
  {
    "id": "14",
    "file_name": "freesound_community-meditation-pad-61609.mp3",
    "title_ar": "خلفية ساكنة لجلسات التنفس",
    "category": "meditation"
  },
  {
    "id": "15",
    "file_name": "freesound_community-flute-recorder-18816.mp3",
    "title_ar": "أصوات مهدئة لتصفية الذهن",
    "category": "relaxation"
  },
  {
    "id": "16",
    "file_name": "freesound_community-relaxation-music-30-50749.mp3",
    "title_ar": "صندوق الأصوات المهدئة للأرق",
    "category": "relaxation"
  },
  {
    "id": "17",
    "file_name": "samuelfjohanns-uplifting-pad-texture-113842.mp3",
    "title_ar": "أصوات تصاعدية لبث السكينة والارتياح",
    "category": "meditation"
  }
]
''';
