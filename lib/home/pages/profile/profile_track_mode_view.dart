import 'dart:convert';
import '../../../core/logic/user_prefs.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

class TrackedMood {
  final String emoji;
  final String title;
  final Color color;

  const TrackedMood(this.emoji, this.title, this.color);
}

class ProfileTrackModeView extends StatefulWidget {
  const ProfileTrackModeView({super.key});

  @override
  State<ProfileTrackModeView> createState() => _ProfileTrackModeViewState();
}

class _ProfileTrackModeViewState extends State<ProfileTrackModeView> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, TrackedMood> _moods = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _loadMoods();
  }

  Future<void> _loadMoods() async {
    final userMoods = await UserPrefs.getMoodsMap();
    final Map<DateTime, TrackedMood> loadedMoods = {};

    final now = DateTime.now();
    final List<TrackedMood> availableMoods = [
      const TrackedMood('😌', 'هادئ', AppColors.primiryColor),
      const TrackedMood('😁', 'سعيد', Colors.green),
      const TrackedMood('😔', 'متعب', Colors.orange),
      const TrackedMood('🤔', 'غاضب', Colors.red),
      const TrackedMood('😎', 'واثق', Colors.blue),
    ];

    for (int i = 1; i <= 15; i++) {
      final date = now.subtract(Duration(days: i));
      final normalizedDate = DateTime(date.year, date.month, date.day);
      loadedMoods[normalizedDate] = availableMoods[(i * 3) % availableMoods.length];
    }

    userMoods.forEach((dateKey, value) {
      try {
        final parts = dateKey.split('-');
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        final date = DateTime(year, month, day);

        final cleanHex = value['color']!.replaceAll('#', '');
        final color = Color(int.parse('FF$cleanHex', radix: 16));

        loadedMoods[date] = TrackedMood(
          value['emoji']!,
          value['title']!,
          color,
        );
      } catch (_) {}
    });

    if (mounted) {
      setState(() {
        _moods.clear();
        _moods.addAll(loadedMoods);
      });
    }
  }

  TrackedMood? _getMoodForDay(DateTime day) {
    final normalizedDate = DateTime(day.year, day.month, day.day);
    return _moods[normalizedDate];
  }

  void _showMoodSelectorBottomSheet(DateTime day) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        final List<Map<String, String>> moods = [
          {'emoji': '😌', 'title': 'هادئ', 'color': '5F59F7'},
          {'emoji': '😁', 'title': 'سعيد', 'color': '4CAF50'},
          {'emoji': '😔', 'title': 'متعب', 'color': 'FF9800'},
          {'emoji': '🤔', 'title': 'غاضب', 'color': 'F44336'},
          {'emoji': '😎', 'title': 'واثق', 'color': '2196F3'},
          {'emoji': '😢', 'title': 'حزين', 'color': '9C27B0'},
        ];

        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'كيف تشعر في هذا اليوم؟',
                  style: AppStyle.bold16.copyWith(color: Colors.white),
                ),
                SizedBox(height: 20.h),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: moods.length,
                  itemBuilder: (context, index) {
                    final mood = moods[index];
                    return GestureDetector(
                      onTap: () async {
                        final String dateKey = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
                        final moodsMap = await UserPrefs.getMoodsMap();
                        final hasLoggedBefore = moodsMap.containsKey(dateKey);

                        await UserPrefs.saveMoodForDay(
                          day,
                          mood['emoji']!,
                          mood['title']!,
                          mood['color']!,
                        );

                        if (!hasLoggedBefore) {
                          final currentPoints = await UserPrefs.getPoints();
                          await UserPrefs.savePoints(currentPoints + 10);
                        }

                        Navigator.pop(context);
                        _loadMoods();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.white12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              mood['emoji']!,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              mood['title']!,
                              style: AppStyle.bold12.copyWith(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentMood =
        _selectedDay != null ? _getMoodForDay(_selectedDay!) : null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'متتبع حالتك المزاجية',
          style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: AppColors.whiteColor, size: 20.r),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.all(16.r),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  calendarFormat: CalendarFormat.month,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextStyle:
                        AppStyle.bold16.copyWith(color: AppColors.whiteColor),
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: AppColors.whiteColor),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: AppColors.whiteColor),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: AppStyle.regular16.copyWith(
                        color: AppColors.greyColor, fontSize: 14.sp),
                    weekendStyle: AppStyle.regular16.copyWith(
                        color: AppColors.primiryColor, fontSize: 14.sp),
                  ),
                  calendarStyle: CalendarStyle(
                    defaultTextStyle:
                        AppStyle.regular16.copyWith(color: AppColors.whiteColor),
                    weekendTextStyle:
                        AppStyle.regular16.copyWith(color: AppColors.whiteColor),
                    outsideTextStyle:
                        AppStyle.regular16.copyWith(color: AppColors.greyColor),
                    selectedDecoration: BoxDecoration(
                      color: AppColors.primiryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: AppColors.primiryColor.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders(
                    markerBuilder: (context, day, events) {
                      final mood = _getMoodForDay(day);
                      if (mood != null) {
                        return Positioned(
                          bottom: 4,
                          child: Container(
                            width: 6.r,
                            height: 6.r,
                            decoration: BoxDecoration(
                              color: mood.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'تفاصيل اليوم',
                style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 16.h),
              if (currentMood != null)
                Container(
                  padding: EdgeInsets.all(20.r),
                  decoration: BoxDecoration(
                    color: AppColors.inputColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: AppColors.avatarColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              currentMood.emoji,
                              style: TextStyle(fontSize: 24.sp),
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'الشعور الغالب',
                                  style: AppStyle.regular16.copyWith(
                                    color: AppColors.greyColor,
                                    fontSize: 12.sp,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  currentMood.title,
                                  style: AppStyle.bold16.copyWith(
                                    color: AppColors.whiteColor,
                                  ),
                                  textDirection: TextDirection.rtl,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      TextButton.icon(
                        onPressed: () => _showMoodSelectorBottomSheet(_selectedDay!),
                        icon: const Icon(Icons.edit, color: AppColors.primiryColor, size: 16),
                        label: Text(
                          'تعديل الشعور',
                          style: AppStyle.bold12.copyWith(color: AppColors.primiryColor),
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: EdgeInsets.all(24.r),
                  decoration: BoxDecoration(
                    color: AppColors.inputColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'لم يتم تسجيل أي شعور في هذا اليوم',
                        style: AppStyle.regular16.copyWith(
                          color: AppColors.greyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: () => _showMoodSelectorBottomSheet(_selectedDay!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primiryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          'سجل شعورك الآن',
                          style: AppStyle.bold12.copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}