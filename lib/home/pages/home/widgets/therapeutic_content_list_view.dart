import '../../../../core/logic/api/api_service.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TherapeuticContentListView extends StatefulWidget {
  const TherapeuticContentListView({super.key});

  @override
  State<TherapeuticContentListView> createState() => _TherapeuticContentListViewState();
}

class _TherapeuticContentListViewState extends State<TherapeuticContentListView> {
  List<Map<String, dynamic>> _items = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fetchContent();
  }

  Future<void> _fetchContent() async {
    final res = await ApiService.authenticatedGet('articles');
    if (res.success && res.asList.isNotEmpty) {
      setState(() {
        _items = res.asList;
        _loaded = true;
      });
    } else {
      // Fallback to sample data
      setState(() {
        _items = List.generate(7, (i) => {
          'title': i.isEven ? 'ما هو الاكتئاب الخفيف ؟' : 'اساسيات العلاج بال CBT',
          'index': i,
        });
        _loaded = true;
      });
    }
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
        final title = item['title'] as String? ?? 'محتوى علاجي';
        final subtitle = item['subtitle'] as String? ?? 'المستوى الاول - فيديو ${index + 1}';

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/audioPlayer',
              arguments: {
                'title': title,
                'subtitle': subtitle,
              },
            );
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
                  AppImage(
                    image: 'worry.png',
                    height: 88.h,
                    width: 88.w,
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
                                text: 'المستوى الاول\t\t\t\t',
                                style: AppStyle.regular12,
                                children: [
                                  TextSpan(
                                    text: 'فيديو ${index + 1} \t\t\t\t',
                                    style: AppStyle.regular12,
                                  ),
                                  TextSpan(
                                    text: '20 دقيقة',
                                    style: AppStyle.regular12,
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
                          title,
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
                          item['author'] as String? ?? 'د نادر سمير ',
                          style: AppStyle.regular16,
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
