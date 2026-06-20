import '../../../../core/logic/api/api_service.dart';
import '../../../../core/ui/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CinemaEtmeanListView extends StatefulWidget {
  const CinemaEtmeanListView({super.key});

  @override
  State<CinemaEtmeanListView> createState() => _CinemaEtmeanListViewState();
}

class _CinemaEtmeanListViewState extends State<CinemaEtmeanListView> {
  List<Map<String, dynamic>> _videos = [];
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    final res = await ApiService.authenticatedGet('videos');
    if (res.success && res.asList.isNotEmpty) {
      setState(() {
        _videos = res.asList;
        _loaded = true;
      });
    } else {
      // Fallback — generate placeholder items
      setState(() {
        _videos = List.generate(10, (i) => {'index': i});
        _loaded = true;
      });
    }
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
        physics: BouncingScrollPhysics(),
        itemBuilder: (contex, index) => CinemaEtmeanLisItem(
          video: _videos[index],
        ),
      ),
    );
  }
}

class CinemaEtmeanLisItem extends StatelessWidget {
  final Map<String, dynamic> video;
  const CinemaEtmeanLisItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 13.r),
      width: 312.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: AppImage(image: 'cinema.png'),
    );
  }
}
