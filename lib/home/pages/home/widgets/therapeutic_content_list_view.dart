import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/content_model.dart';
import '../models/content_repository.dart';
import '../../doctors/models/doctor_model.dart';

class TherapeuticContentListView extends StatefulWidget {
  const TherapeuticContentListView({super.key});

  @override
  State<TherapeuticContentListView> createState() => _TherapeuticContentListViewState();
}

class _TherapeuticContentListViewState extends State<TherapeuticContentListView> {
  List<ContentItem> _items = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  void _fetchContent() {
    // Load a subset of items to show on the home page (e.g. first 10 items)
    _items = ContentRepository.getAll().take(10).toList();
    setState(() {
      _loaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const SliverToBoxAdapter(
        child: Center(child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        )),
      );
    }

    return SliverList.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        final doctor = sampleDoctors[index % sampleDoctors.length];
        final cardImage = ContentRepository.getDoctorImage(item.id);

        return GestureDetector(
          onTap: () {
            if (item.isVideo) {
              Navigator.pushNamed(
                context,
                '/videoList',
                arguments: item.title,
              );
            } else if (item.isPodcast) {
              Navigator.pushNamed(
                context,
                '/audioPlayer',
                arguments: {
                  'title': item.title,
                  'subtitle': item.description,
                },
              );
            } else {
              Navigator.pushNamed(
                context,
                '/articleDetail',
                arguments: item,
              );
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.r),
            height: 115.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              gradient: LinearGradient(
                transform: const GradientRotation(0.2),
                stops: const [0, 1],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.avatarColor,
                  AppColors.inputColor,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.asset(
                      cardImage,
                      height: 88.h,
                      width: 88.w,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => const AppImage(
                        image: 'worry.png',
                        height: 88 , 
                        width: 88,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: '${item.type} • ${item.categoryLabel}\t\t\t\t',
                                style: AppStyle.regular12.copyWith(color: AppColors.primiryColor, fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                    text: '20 دقيقة',
                                    style: AppStyle.regular12.copyWith(color: AppColors.greyColor, fontWeight: FontWeight.normal),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          item.title,
                          style: AppStyle.regular16.copyWith(
                            color: AppColors.whiteColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          textAlign: TextAlign.start,
                          doctor.name,
                          style: AppStyle.regular12.copyWith(color: AppColors.greyColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
