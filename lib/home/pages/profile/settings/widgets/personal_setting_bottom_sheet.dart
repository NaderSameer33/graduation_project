import 'dart:typed_data';

import 'package:etmaen/core/logic/user_prefs.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PersonalSettingBottomSheet extends StatefulWidget {
  const PersonalSettingBottomSheet({
    super.key,
  });

  @override
  State<PersonalSettingBottomSheet> createState() =>
      _PersonalSettingBottomSheetState();
}

class _PersonalSettingBottomSheetState
    extends State<PersonalSettingBottomSheet> {
  final _picker = ImagePicker();
  Uint8List? _avatarBytes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textDisabled,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'اختر الصورة من',
            style: AppStyle.bold16,
          ),
          ListTile(
            leading: const Icon(
              Icons.camera_alt_rounded,
              color: AppColors.primaryTop,
            ),
            title: const Text(
              'الكاميرا',
              style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
            ),
            onTap: () async {
              Navigator.pop(context);
              try {
                final img = await _picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 80,
                );
                if (img != null) {
                  final b = await img.readAsBytes();
                  if (mounted) setState(() => _avatarBytes = b);
                }
              } catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تعذر الوصول للكاميرا. تحقق من الصلاحيات.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.photo_library_rounded,
              color: AppColors.primaryTop,
            ),
            title: const Text(
              'معرض الصور',
              style: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
            ),
            onTap: () async {
              Navigator.pop(context);
              try {
                final img = await _picker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 80,
                );
                if (img != null) {
                  final b = await img.readAsBytes();
                  if (mounted) setState(() => _avatarBytes = b);
                }
              } catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'تعذر الوصول للصور. تحقق من الصلاحيات.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo'),
                      ),
                      backgroundColor: Colors.redAccent,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
          ),
          if (_avatarBytes != null)
            ListTile(
              leading: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
              ),
              title: const Text(
                'حذف الصورة',
                style: TextStyle(
                  color: Colors.redAccent,
                  fontFamily: 'Cairo',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() => _avatarBytes = null);
                UserPrefs.clearAvatar();
              },
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
