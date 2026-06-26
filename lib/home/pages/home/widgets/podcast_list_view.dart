import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_style.dart';
import '../../../../cinema/cinema_video_view.dart';
import '../models/content_model.dart';
import '../models/content_repository.dart';

class PodcastListView extends StatefulWidget {
  const PodcastListView({super.key});

  @override
  State<PodcastListView> createState() => _PodcastListViewState();
}

class _PodcastListViewState extends State<PodcastListView> {
  List<ContentItem> _podcasts = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fetchPodcasts();
  }

  void _fetchPodcasts() {
    _podcasts = ContentRepository.getByType('بودكاست');
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

    if (_podcasts.isEmpty) return const SizedBox();

    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: _podcasts.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final podcast = _podcasts[index];
          
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CinemaVideoView(item: podcast),
                ),
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
                  if (podcast.imageUrl != null && podcast.imageUrl!.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: podcast.imageUrl!,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(color: AppColors.avatarColor),
                    )
                  else
                    Image.asset(
                      ContentRepository.getDoctorImage(podcast.id),
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
                  // Title
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    left: 12.w,
                    child: Text(
                      podcast.title,
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
                        podcast.categoryLabel,
                        style: AppStyle.regular12.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
