import 'package:etmaen/core/ui/app_back.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/home/pages/home/models/content_model.dart';
import 'package:etmaen/home/pages/home/models/content_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CinemaVideoView extends StatefulWidget {
  final ContentItem? item;
  const CinemaVideoView({super.key, this.item});

  @override
  State<CinemaVideoView> createState() => _CinemaVideoViewState();
}

class _CinemaVideoViewState extends State<CinemaVideoView> {
  YoutubePlayerController? _youtubeController;
  bool _isYoutube = false;
  List<ContentItem> _similarVideos = [];
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _loadSimilarVideos();
    _initController();
  }

  void _loadSimilarVideos() {
    if (widget.item != null) {
      _similarVideos = ContentRepository
          .getByConditionAndType(widget.item!.conditionId, 'فيديو')
          .where((v) => v.id != widget.item!.id)
          .take(8)
          .toList();
    } else {
      _similarVideos = ContentRepository.getAll()
          .where((v) => v.isVideo)
          .take(8)
          .toList();
    }
  }

  /// Extract a valid YouTube video ID from the item's link.
  /// Returns null if this is not a valid YouTube URL.
  String? _extractYoutubeId() {
    final link = widget.item?.link ?? '';
    if (link.isEmpty) return null;

    // Reject known non-YouTube links early
    if (link.contains('facebook.com') ||
        link.contains('tiktok.com') ||
        link.contains('example-') ||
        link.contains('mockVideo')) {
      return null;
    }

    final videoId = YoutubePlayer.convertUrlToId(link);
    // YouTube video IDs are strictly 11 characters
    if (videoId != null && videoId.length == 11) {
      return videoId;
    }
    return null;
  }

  void _initController() {
    final videoId = _extractYoutubeId();

    if (videoId != null) {
      _isYoutube = true;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
    } else {
      _isYoutube = false;
      // Non-YouTube content — we'll show an external launch UI instead of
      // a local VideoPlayerController, avoiding any dispose() crashes.
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _youtubeController?.dispose();
    _youtubeController = null;
    super.dispose();
  }

  Future<void> _launchExternal(String link) async {
    final url = Uri.parse(link);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint("Could not launch $link");
      }
    } catch (e) {
      debugPrint("Error launching url: $e");
    }
  }

  Widget _buildExternalWatchButton() {
    final link = widget.item?.link ?? '';
    if (link.isEmpty) return const SizedBox.shrink();

    String label = 'مشاهدة على تطبيق يوتيوب';
    Color btnColor = const Color(0xFFFF0000);
    Color textColor = const Color(0xFFFF4D4D);
    IconData icon = Icons.play_circle_fill_rounded;

    if (link.contains('facebook.com')) {
      label = 'مشاهدة على تطبيق فيسبوك';
      btnColor = const Color(0xFF1877F2);
      textColor = const Color(0xFF75AFFF);
      icon = Icons.facebook;
    } else if (link.contains('tiktok.com')) {
      label = 'مشاهدة على تطبيق تيك توك';
      btnColor = const Color(0xFF00F2FE);
      textColor = const Color(0xFF00F2FE);
      icon = Icons.music_note;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: () => _launchExternal(link),
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
          decoration: BoxDecoration(
            color: btnColor.withAlpha(30),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: btnColor.withAlpha(120), width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppStyle.bold14.copyWith(
                  color: textColor,
                ),
              ),
              SizedBox(width: 10.w),
              Icon(
                icon,
                color: btnColor,
                size: 24.r,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Full-screen placeholder for non-YouTube links (facebook, tiktok, example-*)
  /// Shows a thumbnail + prominent external launch button.
  Widget _buildExternalPlayerPlaceholder() {
    final link = widget.item?.link ?? '';
    final img = ContentRepository.getDoctorImage(widget.item?.id ?? 0);

    String platformName = 'الرابط الخارجي';
    IconData platformIcon = Icons.open_in_new_rounded;
    Color accentColor = AppColors.primiryColor;

    if (link.contains('facebook.com')) {
      platformName = 'فيسبوك';
      platformIcon = Icons.facebook;
      accentColor = const Color(0xFF1877F2);
    } else if (link.contains('tiktok.com')) {
      platformName = 'تيك توك';
      platformIcon = Icons.music_note;
      accentColor = const Color(0xFF00F2FE);
    } else if (link.contains('youtube.com') || link.contains('youtu.be')) {
      platformName = 'يوتيوب';
      platformIcon = Icons.play_circle_fill_rounded;
      accentColor = const Color(0xFFFF0000);
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Thumbnail background
          Image.asset(
            img,
            fit: BoxFit.cover,
            errorBuilder: (c, e, s) => Container(color: AppColors.card),
          ),
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withAlpha(120),
                  Colors.black.withAlpha(200),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Play button in center
          Center(
            child: GestureDetector(
              onTap: () => _launchExternal(link),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(18.r),
                    decoration: BoxDecoration(
                      color: accentColor.withAlpha(40),
                      shape: BoxShape.circle,
                      border: Border.all(color: accentColor, width: 2.5),
                    ),
                    child: Icon(
                      platformIcon,
                      color: accentColor,
                      size: 42.r,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'فتح في $platformName',
                    style: AppStyle.bold14.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(BuildContext context, String title, String description,
      String category, String type) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── Title ────────────────────────────────────────────────
          Text(
            title,
            style: AppStyle.bold20.copyWith(color: AppColors.whiteColor),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 12.h),

          // ── Tags ─────────────────────────────────────────────────
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            alignment: WrapAlignment.end,
            children: [category, type].map((tag) => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColors.primiryColor.withAlpha(80)),
              ),
              child: Text(
                tag,
                style: AppStyle.regular12.copyWith(
                  color: AppColors.primiryColor,
                ),
              ),
            )).toList(),
          ),
          SizedBox(height: 24.h),

          _buildExternalWatchButton(),

          // ── Description ──────────────────────────────────────────
          Text(
            'نبذة عن المحتوى',
            style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
          ),
          SizedBox(height: 12.h),
          Text(
            description,
            style: AppStyle.regular14.copyWith(
              color: AppColors.greyColor,
              height: 1.8,
            ),
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
          ),
          SizedBox(height: 32.h),

          // ── Similar Videos ───────────────────────────────────────
          if (_similarVideos.isNotEmpty) ...[
            Text(
              'فيديوهات مشابهة',
              style: AppStyle.bold16.copyWith(color: AppColors.whiteColor),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 180.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _similarVideos.length,
                itemBuilder: (ctx, index) {
                  final sim = _similarVideos[index];
                  final img = ContentRepository.getDoctorImage(sim.id);
                  return GestureDetector(
                    onTap: () {
                      if (_isDisposed) return;
                      // Navigate to a new CinemaVideoView with this item
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              CinemaVideoView(item: sim),
                          transitionDuration:
                              const Duration(milliseconds: 300),
                          transitionsBuilder: (_, anim, __, child) =>
                              FadeTransition(opacity: anim, child: child),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 12.r),
                      width: 150.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: AppColors.card,
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Thumbnail
                          Image.asset(
                            img,
                            fit: BoxFit.cover,
                            errorBuilder: (c, e, s) =>
                                Container(color: AppColors.avatarColor),
                          ),
                          // Dark overlay
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
                          // Play icon
                          Center(
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white30, width: 1.5),
                              ),
                              child: Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 22.r),
                            ),
                          ),
                          // Title
                          Positioned(
                            bottom: 8.h,
                            left: 6.w,
                            right: 6.w,
                            child: Text(
                              sim.title,
                              style: AppStyle.regular12.copyWith(
                                  color: Colors.white),
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
            ),
            SizedBox(height: 40.h),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final title = item?.title ?? 'محتوى علاجي';
    final description = item?.description ??
        'يروي الفيلم قصة أب يواجه ضغوطًا نفسية واقتصادية قاسية، ويجد نفسه مطالبًا بالصمود من أجل ابنه رغم الفشل المتكرر وقلة الموارد.\n\nيسلّط العمل الضوء على قوة الإصرار، وتقبّل الفشل كجزء من الرحلة، وأهمية الأمل في مواجهة القلق والخوف من المستقبل.';
    final category = item?.categoryLabel ?? 'دعم نفسي';
    final type = item?.type ?? 'فيديو';

    // ── YouTube inline player ──────────────────────────────────────
    if (_isYoutube && _youtubeController != null) {
      return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.primiryColor,
          progressColors: const ProgressBarColors(
            playedColor: AppColors.primiryColor,
            handleColor: AppColors.primiryColor,
          ),
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: AppColors.blackColor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Video Player ──────────────────────────────────
                  Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: player,
                      ),
                      Positioned(
                        right: 16.w,
                        top: 50.h,
                        child: const AppBack(),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  _buildDetails(context, title, description, category, type),
                ],
              ),
            ),
          );
        },
      );
    }

    // ── Non-YouTube: external player placeholder ──────────────────
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── External player placeholder ────────────────────────
            Stack(
              children: [
                _buildExternalPlayerPlaceholder(),
                Positioned(
                  right: 16.w,
                  top: 50.h,
                  child: const AppBack(),
                ),
              ],
            ),

            SizedBox(height: 24.h),

            _buildDetails(context, title, description, category, type),
          ],
        ),
      ),
    );
  }
}
