import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/ui/app_color.dart';
import '../../../../core/ui/app_image.dart';
import '../../../../core/ui/app_style.dart';
import '../../../../core/logic/app_routes.dart';
import '../../../../core/logic/user_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  String _userName = 'نادر سمير';
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final p = await UserPrefs.loadProfile();
    if (!mounted) return;
    setState(() {
      _userName = p['name'] as String;
      _avatarBytes = p['avatarBytes'] as Uint8List?;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _avatarBytes != null
            ? Container(
                width: 49.w,
                height: 49.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: MemoryImage(_avatarBytes!),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : AppImage(
                height: 49.h,
                width: 49.w,
                image: 'person.png',
                isCircle: true,
              ),
        SizedBox(
          width: 10.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _userName,
              style: AppStyle.bold16,
            ),
            Text(
              'المستوي الاول',
            ),
          ],
        ),
        Spacer(),
        CircleAvatar(
          backgroundColor: AppColors.avatarColor,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings).then((_) {
                _loadProfile(); // Reload if settings changed it
              });
            },
            icon: AppImage(image: 'setting.svg'),
          ),
        ),
      ],
    );
  }
}
