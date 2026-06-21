import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/home/models/content_model.dart';
import 'package:etmaen/home/pages/home/models/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaMostView extends StatelessWidget {
  final String? filter;
  const CinemaMostView({super.key, this.filter});

  int? _filterConditionId() {
    if (filter == null || filter == 'عرض الكل') return null;
    if (filter == 'الاكتئاب') return 1;
    if (filter == 'الاجهاد والقلق') return 2;
    if (filter == 'الاحتراق النفسي') return 3;
    if (filter == 'التفكير الزائد') return 4;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final condId = _filterConditionId();
    final List<ContentItem> videos = condId == null
        ? ContentRepository.getAll().where((e) => e.isVideo).toList()
        : ContentRepository.getByConditionAndType(condId, 'فيديو');

    if (videos.isEmpty) {
      return SizedBox(
        height: 188.h,
        child: Center(
          child: Text(
            'لا توجد فيديوهات لهذه الفئة',
            style: AppStyle.regular16.copyWith(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 188.h,
      child: ListView.builder(
        itemCount: videos.length,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final video = videos[index];
          final img = ContentRepository.getDoctorImage(video.id);
          return GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              AppRoutes.cinemaVideo,
              arguments: video,
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.r),
              width: 152.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: AppColors.card,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    img,
                    fit: BoxFit.cover,
                    errorBuilder: (c, e, s) =>
                        Container(color: AppColors.avatarColor),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(180),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white30, width: 1.5),
                      ),
                      child: Icon(Icons.play_arrow_rounded,
                          color: Colors.white, size: 22.r),
                    ),
                  ),
                  Positioned(
                    bottom: 8.h,
                    left: 6.w,
                    right: 6.w,
                    child: Text(
                      video.title,
                      style:
                          AppStyle.regular12.copyWith(color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
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
