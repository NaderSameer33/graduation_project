import 'app_color.dart';
import 'app_image.dart';
import 'app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.topSpacing = 0,
    this.bottomSpacing = 0,
    this.controller,
    this.onChanged,
    this.suffixIcon,
    this.maxLines,
    this.isPasswrod = false,
  });
  final String hintText;
  final String? prefixIcon;
  final String? suffixIcon;
  final double topSpacing, bottomSpacing;
  final TextEditingController? controller;
  final int? maxLines;
  final void Function(String)? onChanged;
  final bool isPasswrod;

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.topSpacing,
        bottom: widget.bottomSpacing,
      ),
      child: TextFormField(
        obscureText: widget.isPasswrod && isHidden,
        maxLines: widget.isPasswrod ? 1 : widget.maxLines,
        onChanged: widget.onChanged,
        controller: widget.controller,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        decoration: InputDecoration(
          suffixIcon: widget.isPasswrod
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  icon: Icon(
                    isHidden ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : widget.suffixIcon != null
              ? AppImage(image: widget.suffixIcon!)
              : null,
          prefixIcon: widget.prefixIcon != null
              ? AppImage(image: widget.prefixIcon!)
              : null,
          hintText: widget.hintText,
          hintStyle: AppStyle.bold16.copyWith(color: AppColors.inputHintColor),
          filled: true,
          fillColor: AppColors.inputColor,
          border: buildBorder(),
          focusedBorder: buildBorder(),
          enabledBorder: buildBorder(),
        ),
      ),
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
  );
}
