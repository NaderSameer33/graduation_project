import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

// A simple local model for demonstrating tracked moods.
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

  // Mock data for mood history
  final Map<DateTime, TrackedMood> _moods = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _generateMockData();
  }

  void _generateMockData() {
    final now = DateTime.now();
    final List<TrackedMood> availableMoods = [
      const TrackedMood('😌', 'هادئ', AppColors.primiryColor),
      const TrackedMood('😁', 'سعيد', Colors.green),
      const TrackedMood('😔', 'متعب', Colors.orange),
      const TrackedMood('🤔', 'غاضب', Colors.red),
      const TrackedMood('😎', 'واثق', Colors.blue),
    ];

    // Populate the last 15 days with some random moods
    for (int i = 0; i < 15; i++) {
      final date = now.subtract(Duration(days: i));
      // Normalize date to ignore time
      final normalizedDate = DateTime(date.year, date.month, date.day);
      // Pick a semi-random mood based on the day
      _moods[normalizedDate] = availableMoods[(i * 3) % availableMoods.length];
    }
  }

  TrackedMood? _getMoodForDay(DateTime day) {
    final normalizedDate = DateTime(day.year, day.month, day.day);
    return _moods[normalizedDate];
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
                  // Custom marker builder to show a color dot if a mood exists
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
                  child: Row(
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
                )
              else
                Container(
                  padding: EdgeInsets.all(32.r),
                  decoration: BoxDecoration(
                    color: AppColors.inputColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Center(
                    child: Text(
                      'لم يتم تسجيل أي شعور في هذا اليوم',
                      style: AppStyle.regular16.copyWith(
                        color: AppColors.greyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
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