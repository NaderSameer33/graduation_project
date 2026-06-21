import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'models/content_model.dart';
import 'models/content_repository.dart';
import '../doctors/models/doctor_model.dart';

class VideoListView extends StatefulWidget {
  final String categoryTitle;
  const VideoListView({super.key, required this.categoryTitle});

  @override
  State<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  ContentItem? _selectedVideo;
  List<ContentItem> _playlist = [];

  @override
  void initState() {
    super.initState();
    _loadPlaylist();
  }

  void _loadPlaylist() {
    final allVideos = ContentRepository.getAll().where((e) => e.isVideo).toList();
    // Search for matching video by title
    final selected = allVideos.firstWhere(
      (e) => e.title == widget.categoryTitle,
      orElse: () => allVideos.first,
    );
    _selectedVideo = selected;
    // Load other videos from same condition
    _playlist = ContentRepository.getByConditionAndType(selected.conditionId, 'فيديو');
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedVideo == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final doctorIndex = (_selectedVideo!.id) % sampleDoctors.length;
    final doctor = sampleDoctors[doctorIndex];

    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      'علاج ${_selectedVideo!.categoryLabel}',
                      style: AppStyle.bold24.copyWith(color: Colors.white),
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  const AppBack(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _selectedVideo!.description,
                          style: AppStyle.regular16.copyWith(color: Colors.white, height: 1.8),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                        SizedBox(height: 24.h),
                        _buildProgressBar(),
                        SizedBox(height: 24.h),
                        _buildDoctorInfo(doctor.name, doctor.image),
                        SizedBox(height: 24.h),
                        // Video List
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _playlist.length,
                          itemBuilder: (context, index) {
                            final video = _playlist[index];
                            final isCurrent = video.id == _selectedVideo!.id;
                            final cardDoctorImage = ContentRepository.getDoctorImage(video.id);

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedVideo = video;
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 16.h),
                                height: 100.h,
                                decoration: BoxDecoration(
                                  color: AppColors.card,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: isCurrent
                                      ? Border.all(color: AppColors.primiryColor, width: 2.r)
                                      : null,
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.avatarColor,
                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                                        child: Image.asset(
                                          cardDoctorImage,
                                          fit: BoxFit.cover,
                                          errorBuilder: (c, e, s) => const SizedBox(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            isCurrent ? 'يشتغل الآن • فيديو ${index + 1}' : 'جلسة ${index + 1} • فيديو • 20 دقيقة',
                                            style: AppStyle.regular12.copyWith(
                                              color: isCurrent ? AppColors.primiryColor : AppColors.greyColor,
                                              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                                            ),
                                            textAlign: TextAlign.right,
                                            textDirection: TextDirection.rtl,
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            video.title,
                                            style: AppStyle.bold16.copyWith(
                                              color: isCurrent ? AppColors.primiryColor : Colors.white,
                                            ),
                                            textAlign: TextAlign.right,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 16.w),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 100.h), // space for mini player
                      ],
                    ),
                  ),
                  // Mini Player
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.cinemaVideo);
                      },
                      child: Container(
                        height: 80.h,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(128),
                              blurRadius: 10,
                              offset: const Offset(0, -5),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Play Button
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.play_arrow, color: Colors.black, size: 28.r),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      _selectedVideo!.title,
                                      style: AppStyle.bold12.copyWith(color: Colors.white),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      doctor.name,
                                      style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // Thumbnail
                            Container(
                              height: 48.r,
                              width: 48.r,
                              decoration: BoxDecoration(
                                color: AppColors.avatarColor,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                ContentRepository.getDoctorImage(_selectedVideo!.id),
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '10% مكتمل',
              style: AppStyle.regular12.copyWith(color: Colors.white),
            ),
            Text(
              '${_playlist.length} جلسة',
              style: AppStyle.regular12.copyWith(color: Colors.white),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: 0.1,
            backgroundColor: AppColors.card,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primiryColor),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInfo(String name, String imageAsset) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          name,
          style: AppStyle.regular16.copyWith(color: Colors.white),
        ),
        SizedBox(width: 12.w),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(
            imageAsset.startsWith('assets/') ? imageAsset : 'assets/images/$imageAsset',
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Icon(Icons.person, color: Colors.black, size: 24.r),
          ),
        ),
      ],
    );
  }
}
