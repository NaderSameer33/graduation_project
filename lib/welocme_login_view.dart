import 'package:etmaen/core/ui/app_image.dart';
import 'package:flutter/material.dart';

class WelcomeLoginView extends StatelessWidget {
  const WelcomeLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppImage(
            image: 'logo.png',
            height: 100,
          ),
        ],
      ),
    );
  }
}
