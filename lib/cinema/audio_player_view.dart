import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import '../core/ui/app_color.dart';
import '../core/ui/app_style.dart';

class AudioPlayerView extends StatefulWidget {
  final String title;
  final String subtitle;
  
  const AudioPlayerView({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  State<AudioPlayerView> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      // Load a sample relaxing audio url for functionality
      await _player.setUrl('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
      _player.play(); // Auto-play the audio
      
      _player.positionStream.listen((pos) {
        if (mounted) setState(() => _position = pos);
      });
      _player.durationStream.listen((dur) {
        if (mounted) setState(() => _duration = dur ?? Duration.zero);
      });
      _player.playerStateStream.listen((state) {
        if (mounted) {
          setState(() {
            _isPlaying = state.playing;
          });
        }
      });
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Fallback for missing image)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.avatarColor, AppColors.blackColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          // Back Button
          Positioned(
            top: 50.h,
            left: 16.w,
            child: IconButton(
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 32.r),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Content
          Positioned(
            bottom: 40.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.title,
                  style: AppStyle.bold24.copyWith(color: Colors.white),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 8.h),
                Text(
                  widget.subtitle,
                  style: AppStyle.regular16.copyWith(color: Colors.white70),
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(height: 32.h),
                // Progress Bar
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 2.h,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.r),
                    activeTrackColor: Colors.white,
                    inactiveTrackColor: Colors.white30,
                    thumbColor: Colors.white,
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 14.r),
                  ),
                  child: Slider(
                    value: _position.inMilliseconds.toDouble(),
                    max: _duration.inMilliseconds.toDouble() > 0 ? _duration.inMilliseconds.toDouble() : 1.0,
                    onChanged: (val) {
                      _player.seek(Duration(milliseconds: val.toInt()));
                    },
                  ),
                ),
                // Time
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_position), style: AppStyle.regular12.copyWith(color: Colors.white)),
                      Text('-${_formatDuration(_duration - _position)}', style: AppStyle.regular12.copyWith(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.shuffle, color: Colors.white, size: 24.r),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_previous, color: Colors.white, size: 32.r),
                      onPressed: () {},
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_isPlaying) {
                          _player.pause();
                        } else {
                          _player.play();
                        }
                      },
                      child: Container(
                        height: 70.r,
                        width: 70.r,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                          size: 36.r,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.skip_next, color: Colors.white, size: 32.r),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.loop, color: Colors.white, size: 24.r),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
