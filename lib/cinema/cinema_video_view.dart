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
      body: Column(
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: FlickVideoPlayer(
                  
                  flickManager: flickManager,
                ),
              ),
              Positioned(right: 16.r, top: 35.h, child: AppBack()),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'The Pursuit of Happynes',
                  style: AppStyle.bold16,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Row(
                  children: [
                    ...List.generate(
                      3,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.r),
                        alignment: Alignment.center,
                        height: 38.h,
                        width: 72.w,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'دعم وتحفيز',
                          style: AppStyle.regular12,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),

                Text(
                  'نبذة عن الفيلم',
                  style: AppStyle.bold16,
                ),
                SizedBox(
                  height: 16.h,
                ),

                Text(
                  'يروي الفيلم قصة أب يواجه ضغوطًا نفسية واقتصادية قاسية، ويجد نفسه مطالبًا بالصمود من أجل ابنه رغم الفشل المتكرر وقلة الموارد.',
                  style: AppStyle.regular12,
                ),
                SizedBox(
                  height: 16.h,
                ),

                Text(
                  'يروي الفيلم قصة أب يواجه ضغوطًا نفسية واقتصادية قاسية، ويجد نفسه مطالبًا بالصمود من أجل ابنه رغم الفشل المتكرر وقلة الموارد.',
                  style: AppStyle.regular12,
                ),
                SizedBox(
                  height: 16.h,
                ),

                Text(
                  'يروي الفيلم قصة أب يواجه ضغوطًا نفسية واقتصادية قاسية، ويجد نفسه مطالبًا بالصمود من أجل ابنه رغم الفشل المتكرر وقلة الموارد.',
                  style: AppStyle.regular12,
                ),
                SizedBox(
                  height: 16.h,
                ),

                Text(
                  'افلام مشابهة',
                  style: AppStyle.bold16,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CinemaShortFilm(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
