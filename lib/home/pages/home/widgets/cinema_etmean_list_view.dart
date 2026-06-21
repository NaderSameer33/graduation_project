import '../../../../core/logic/app_routes.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/content_model.dart';
import '../models/content_repository.dart';

class CinemaEtmeanListView extends StatefulWidget {
  const CinemaEtmeanListView({super.key});

  @override
  State<CinemaEtmeanListView> createState() => _CinemaEtmeanListViewState();
}

class _CinemaEtmeanListViewState extends State<CinemaEtmeanListView> {
  List<ContentItem> _videos = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  void _fetchVideos() {
    _videos = ContentRepository.getAll().where((e) => e.isVideo).toList();
    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return SizedBox(
        height: 188.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: _videos.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => CinemaEtmeanLisItem(
          video: _videos[index],
          index: index,
        ),
      ),
    );
  }
}

class CinemaEtmeanLisItem extends StatelessWidget {
  final ContentItem video;
  final int index;
  const CinemaEtmeanLisItem({super.key, required this.video, required this.index});

  @override
  Widget build(BuildContext context) {
    final cardImage = ContentRepository.getDoctorImage(video.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.videoList,
          arguments: video.title,
        );
      },
      child: Container(
        margin: EdgeInsets.only(left: 13.r),
        width: 312.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColors.card,
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image
            Image.asset(
              cardImage,
              fit: BoxFit.cover,
              errorBuilder: (c, e, s) => Container(color: AppColors.avatarColor),
            ),
            // Gradient Overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withAlpha((0.1 * 255).toInt()),
                      Colors.black.withAlpha((0.75 * 255).toInt()),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Play Icon in Center
            Center(
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: Icon(
                  Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 32.r,
                ),
              ),
            ),
            // Video Title
            Positioned(
              bottom: 12.h,
              right: 12.w,
              left: 12.w,
              child: Text(
                video.title,
                style: AppStyle.bold12.copyWith(color: Colors.white),
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textDirection: TextDirection.rtl,
              ),
            ),
            // Category Badge
            Positioned(
              top: 12.h,
              left: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primiryColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  video.categoryLabel,
                  style: AppStyle.regular12.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
