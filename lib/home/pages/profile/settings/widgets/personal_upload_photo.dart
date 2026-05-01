import 'dart:typed_data';

import 'package:etmaen/core/logic/helper_method.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:flutter/material.dart';

class PersonalUploadPhoto extends StatelessWidget {
  const PersonalUploadPhoto({super.key, required this.avatarBytes});
  final Uint8List? avatarBytes;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () async {
          await pickImage(context: context);
        },
        child: Stack(
          children: [
            Container(
              width: 96,
              height: 96,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primaryTop.withOpacity(0.4),
                  width: 2,
                ),
              ),
              child: avatarBytes != null
                  ? Image.memory(avatarBytes!, fit: BoxFit.cover)
                  : const Icon(
                      Icons.person_rounded,
                      color: Color(0xFF555555),
                      size: 56,
                    ),
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  gradient: AppGradients.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
