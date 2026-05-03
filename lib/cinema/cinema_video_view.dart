import 'package:etmaen/cinema/widgets/cinema_short_film.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class CinemaVideoView extends StatefulWidget {
  const CinemaVideoView({super.key});

  @override
  State<CinemaVideoView> createState() => _CinemaVideoViewState();
}

class _CinemaVideoViewState extends State<CinemaVideoView> {
  late VideoPlayerController controller;
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    initController();
  }

  void initController() {
    controller =
        VideoPlayerController.networkUrl(
            Uri.parse(
              'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
            ),
          )
          ..initialize().then((_) {
            setState(() {});
          });
    flickManager = FlickManager(videoPlayerController: controller);
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: FlickVideoPlayer(
                    flickManager: flickManager,
                  ),
                ),
                Positioned(
                  right: 16.w, 
                  top: 50.h, 
                  child: const AppBack()
                ),
              ],
            ),
            SizedBox(
              height: 24.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'The Pursuit of Happyness',
                    style: AppStyle.bold24.copyWith(color: AppColors.whiteColor),
                    textDirection: TextDirection.ltr,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    alignment: WrapAlignment.end,
                    children: [
                      'دعم وتحفيز',
                      'تقبل الذات',
                      'الصمود النفسي'
                    ].map((tag) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            tag,
                            style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
                          ),
                        )).toList(),
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'نبذة عن الفيلم',
                    style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  Text(
                    'يروي الفيلم قصة أب يواجه ضغوطًا نفسية واقتصادية قاسية، ويجد نفسه مطالبًا بالصمود من أجل ابنه رغم الفشل المتكرر وقلة الموارد.\n\nيسلّط العمل الضوء على قوة الإصرار، وتقبّل الفشل كجزء من الرحلة، وأهمية الأمل في مواجهة القلق والخوف من المستقبل.\n\nيُعد الفيلم مثالًا ملهمًا على الصمود النفسي وبناء الثقة بالنفس في أصعب الظروف.',
                    style: AppStyle.regular12.copyWith(
                      color: AppColors.greyColor,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  Text(
                    'افلام مشابهة',
                    style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const CinemaShortFilm(),
                  SizedBox(
                    height: 40.h,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
