import '../../../../core/logic/app_routes.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/audio_relaxing_model.dart';

class TherapeuticTraningGridView extends StatefulWidget {
  const TherapeuticTraningGridView({super.key});

  @override
  State<TherapeuticTraningGridView> createState() =>
      _TherapeuticTraningGridViewState();
}

class _TherapeuticTraningGridViewState
    extends State<TherapeuticTraningGridView> {
  late final List<AudioRelaxing> exercises;

  @override
  void initState() {
    super.initState();
    exercises = AudioRelaxing.getAll();
  }

  @override
  Widget build(BuildContext context) {
    if (exercises.isEmpty) return const SizedBox.shrink();

    final columnCount = (exercises.length / 2).ceil();

    return SizedBox(
      height: 200.h,
      child: ListView.builder(
        itemCount: columnCount,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final firstItemIndex = index * 2;
          final secondItemIndex = firstItemIndex + 1;

          final firstItem = exercises[firstItemIndex];
          final secondItem = secondItemIndex < exercises.length
              ? exercises[secondItemIndex]
              : null;

          return Padding(
            padding: EdgeInsets.only(left: 16.r, right: index == 0 ? 16.r : 0),
            child: Column(
              children: [
                TheraputicTraningItemBody(exercise: firstItem),
                if (secondItem != null) ...[
                  SizedBox(height: 20.h),
                  TheraputicTraningItemBody(exercise: secondItem),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class TheraputicTraningItemBody extends StatelessWidget {
  const TheraputicTraningItemBody({
    super.key,
    required this.exercise,
  });

  final AudioRelaxing exercise;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.audioPlayer, arguments: {
          'title': exercise.titleAr,
          'subtitle': 'تمرين صوتي',
          'fileName': exercise.fileName,
        });
      },
      child: Container(
        height: 86.h,
        width: 308.w,
        decoration: BoxDecoration(
          color: AppColors.inputColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
              color: Colors.black.withValues(alpha: .2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.audioPlayer, arguments: {
                    'title': exercise.titleAr,
                    'subtitle': 'تمرين صوتي',
                    'fileName': exercise.fileName,
                  });
                },
                icon: const AppImage(image: 'music.svg'),
              ),
              SizedBox(
                width: 10.w,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'تمرين صوتي  \t\t\t\t',
                            style: AppStyle.regular12,
                          ),
                          TextSpan(
                            text: '10 دقائق',
                            style: AppStyle.regular12,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      exercise.titleAr,
                      style: AppStyle.regular16.copyWith(
                        color: AppColors.whiteColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
