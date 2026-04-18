import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

class AppImage extends StatelessWidget {
  const AppImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.color,
    this.fit = BoxFit.scaleDown,
    this.isCircle = false,
    this.topSpacing = 0,
    this.bottomSpacing = 0,
  });
  final String image;
  final double? height, width;
  final Color? color;
  final BoxFit fit;
  final bool isCircle;
  final double topSpacing, bottomSpacing;

  @override
  Widget build(BuildContext context) {
    final myFit = isCircle ? BoxFit.cover : fit;
    Widget child;
    if (image.isEmpty) {
      return const SizedBox.shrink();
    }

    if (image.toLowerCase().endsWith('svg')) {
      child = SvgPicture.asset(
        'assets/icons/$image',
        color: color,
        height: height,
        width: width,
        fit: myFit,
      );
    } else if (image.startsWith('http')) {
      child = CachedNetworkImage(
        placeholder: (context, urel) => Center(
          child: SizedBox(
            height: 20.h,
            width: 20.w,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
        errorWidget: (context, url, error) => AppImage(
          image: 'error.png',
          fit: fit,
          height: height,
          width: width,
        ),
        fit: myFit,
        imageUrl: image,
        color: color,
        height: height,
        width: width,
      );
    } else if (image.endsWith('json')) {
      child = Lottie.asset(
        'assets/lotties/$image',
        height: height,
        width: width,
        fit: myFit,
      );
    } else {
      child = Image.asset(
        'assets/images/$image',
        fit: myFit,

        color: color,
        height: height,
        width: width,
      );
    }
    if (isCircle) {
      return ClipOval(
        child: child,
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: topSpacing, bottom: bottomSpacing),
      child: child,
    );
  }
}
