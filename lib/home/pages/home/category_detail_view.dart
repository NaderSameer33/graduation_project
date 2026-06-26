import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'models/content_model.dart';
import 'models/content_repository.dart';

class CategoryDetailView extends StatefulWidget {
  final String categoryTitle;
  const CategoryDetailView({super.key, required this.categoryTitle});

  @override
  State<CategoryDetailView> createState() => _CategoryDetailViewState();
}

class _CategoryDetailViewState extends State<CategoryDetailView> {
  int currentTab = 0;
  // Ordered from Right to Left in RTL: Videos, Podcasts, Articles
  final List<String> tabs = ['فيديوهات', 'بودكاست', 'مقالات'];

  List<ContentItem> _apiArticles = [];
  bool _isLoadingArticles = false;

  @override
  void initState() {
    super.initState();
    _loadApiArticles();
  }

  Future<void> _loadApiArticles() async {
    setState(() {
      _isLoadingArticles = true;
    });
    final conditionId = _getConditionId();
    final articles = await ContentRepository.fetchArticlesFromApi(conditionId);
    if (mounted) {
      setState(() {
        _apiArticles = articles;
        _isLoadingArticles = false;
      });
    }
  }

  int _getConditionId() {
    final title = widget.categoryTitle;
    if (title.contains('اكتئاب') || title == 'الاكتئاب') return 1;
    if (title.contains('اجهاد') || title.contains('قلق') || title == 'الاجهاد والقلق') return 2;
    if (title.contains('احتراق') || title == 'الاحتراق النفسي') return 3;
    if (title.contains('تفكير') || title == 'التفكير الزائد') return 4;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(
                    'علاج ${widget.categoryTitle}',
                    style: AppStyle.bold24.copyWith(color: Colors.white),
                  ),
                  SizedBox(width: 16.w),
                  const AppBack(),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            // Tabs
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(tabs.length, (index) {
                  final isSelected = currentTab == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentTab = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 105.w,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primiryColor : AppColors.card,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: isSelected ? Colors.transparent : Colors.white12,
                        ),
                      ),
                      child: Text(
                        tabs[index],
                        style: AppStyle.bold12.copyWith(
                          color: isSelected ? Colors.white : AppColors.greyColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 24.h),
            // Dynamic Content
            Expanded(
              child: _buildDynamicContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDynamicContent() {
    final conditionId = _getConditionId();
    final String targetType = currentTab == 0 ? 'فيديو' : (currentTab == 1 ? 'بودكاست' : 'مقالة');

    List<ContentItem> items = [];
    if (targetType == 'مقالة') {
      if (_isLoadingArticles) {
        return const Center(child: CircularProgressIndicator());
      }
      items = _apiArticles.isNotEmpty
          ? _apiArticles
          : ContentRepository.getByConditionAndType(conditionId, 'مقالة');
    } else {
      items = ContentRepository.getByConditionAndType(conditionId, targetType);
    }

    if (items.isEmpty) {
      return Center(
        child: Text(
          'لا يوجد محتوى متوفر حالياً',
          style: AppStyle.regular16.copyWith(color: AppColors.greyColor),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final doctorImage = item.doctorId != null
            ? ContentRepository.getDoctorImage(item.doctorId!)
            : ContentRepository.getDoctorImage(index);
        return GestureDetector(
          onTap: () {
            if (currentTab == 0) { // Videos
              Navigator.pushNamed(context, AppRoutes.videoList, arguments: item.title);
            } else if (currentTab == 1) { // Podcasts
              Navigator.pushNamed(context, AppRoutes.cinemaVideo, arguments: item);
            } else if (currentTab == 2) { // Articles
              Navigator.pushNamed(context, AppRoutes.articleDetail, arguments: item);
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h),
            height: 140.h,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Stack(
              children: [
                Row(
                  children: [
                    Container(
                      width: 120.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                        color: AppColors.avatarColor,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(12.r)),
                        child: item.imageUrl != null && item.imageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: item.imageUrl!,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => Image.asset(
                                  doctorImage,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Image.asset(
                                doctorImage,
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
                            item.title,
                            style: AppStyle.bold12.copyWith(color: Colors.white),
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.rtl,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            item.description,
                            style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
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
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha((0.6 * 255).toInt()),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Text(
                      targetType,
                      style: AppStyle.regular12.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
