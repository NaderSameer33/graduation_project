import '../../../core/logic/app_routes.dart';
import '../../../core/ui/app_color.dart';
import '../../../core/ui/app_style.dart';
import '../../../core/logic/user_prefs.dart';
import '../home/widgets/therapeutic_content_header.dart';
import 'widgets/profiel_today_tasks.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_track_point_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<bool> _taskStatus = [false, false, false];
  int _points = 120;
  Map<String, Map<String, String>> _moodsMap = {};
  late List<DateTime> _pastDays;

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    _pastDays = List.generate(7, (i) => today.subtract(Duration(days: 6 - i)));
    _loadData();
  }

  Future<void> _loadData() async {
    final completedIndices = await UserPrefs.getCompletedTasks();
    final points = await UserPrefs.getPoints();
    final moods = await UserPrefs.getMoodsMap();

    final statuses =
        List.generate(3, (i) => completedIndices.contains(i.toString()));

    if (mounted) {
      setState(() {
        _taskStatus = statuses;
        _points = points;
        _moodsMap = moods;
      });
    }
  }

  Future<void> _onToggleTask(int index) async {
    final updatedList = List<bool>.from(_taskStatus);
    updatedList[index] = !updatedList[index];

    final pointsChange = updatedList[index] ? 50 : -50;
    final currentPoints = await UserPrefs.getPoints();
    final newPoints = (currentPoints + pointsChange).clamp(0, 1000);

    await UserPrefs.savePoints(newPoints);

    final List<String> completedIndices = [];
    for (int i = 0; i < updatedList.length; i++) {
      if (updatedList[i]) {
        completedIndices.add(i.toString());
      }
    }
    await UserPrefs.saveCompletedTasks(completedIndices);

    setState(() {
      _taskStatus = updatedList;
      _points = newPoints;
    });
  }

  String _formatDateKey(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  String _getArabicDayLetter(DateTime date) {
    switch (date.weekday) {
      case DateTime.monday:
        return 'ن';
      case DateTime.tuesday:
        return 'ث';
      case DateTime.wednesday:
        return 'ر';
      case DateTime.thursday:
        return 'خ';
      case DateTime.friday:
        return 'ج';
      case DateTime.saturday:
        return 'س';
      case DateTime.sunday:
        return 'ح';
      default:
        return '';
    }
  }

  Color _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) return AppColors.primiryColor;
    try {
      final cleanHex = hex.replaceAll('#', '');
      return Color(int.parse('FF$cleanHex', radix: 16));
    } catch (_) {
      return AppColors.primiryColor;
    }
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
                        final dateKey = _formatDateKey(day);
                        final hasLoggedBefore = _moodsMap.containsKey(dateKey);

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
                        _loadData();
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
                              style: AppStyle.bold12
                                  .copyWith(color: Colors.white70),
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

  Widget _buildMoodItem(DateTime day, Map<String, String>? mood) {
    final today = DateTime.now();
    final isToday = DateUtils.isSameDay(day, today);
    final hasMood = mood != null;

    return GestureDetector(
      onTap: () => _showMoodSelectorBottomSheet(day),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _getArabicDayLetter(day),
              style: AppStyle.regular14.copyWith(
                color: isToday ? AppColors.primiryColor : Colors.white70,
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(height: 10.h),
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment.center,
              height: 46.h,
              // No fixed width — fills the Expanded slot in the Row
              // to prevent right-side overflow on any screen size
              width: double.infinity,
              decoration: BoxDecoration(
                color: hasMood
                    ? _parseColor(mood['color']).withOpacity(0.15)
                    : AppColors.blackColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: hasMood
                      ? _parseColor(mood['color'])
                      : (isToday
                          ? AppColors.primiryColor.withOpacity(0.5)
                          : Colors.white12),
                  width: hasMood || isToday ? 1.5 : 1,
                ),
              ),
              child: Text(
                hasMood ? mood['emoji']! : '＋',
                style: TextStyle(
                  fontSize: hasMood ? 18.sp : 12.sp,
                  color: hasMood ? null : Colors.white30,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              const ProfileHeader(),
              SizedBox(height: 32.h),
              ProfileTrackPointItem(points: _points),
              SizedBox(height: 16.h),
              Text(
                'مهام الاسبوع',
                style: AppStyle.bold16,
              ),
              SizedBox(height: 16.h),
              ProfileTodayTasks(
                taskStatus: _taskStatus,
                onToggleTask: _onToggleTask,
              ),
              SizedBox(height: 16.h),
              TherapeuticContentHeader(
                title: 'متتبع حالتك المزاجية ',
                isProfile: true,
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.trackMode).then((_) {
                    _loadData();
                  });
                },
              ),
              SizedBox(height: 10.h),
              Container(
                height: 106.h,
                decoration: BoxDecoration(
                  color: AppColors.inputColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    children: _pastDays.map((day) {
                      final key = _formatDateKey(day);
                      final mood = _moodsMap[key];
                      // Expanded: each of the 7 days takes equal width —
                      // prevents right-side overflow on any screen size
                      return Expanded(child: _buildMoodItem(day, mood));
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(height: 100.h),
            ],
          ),
        ),
      ),
    );
  }
}
