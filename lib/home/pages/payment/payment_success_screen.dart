import 'package:confetti/confetti.dart';
import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/app_image.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController();
    startConfitee();
  }

  void startConfitee() async {
    confettiController.play();

    await Future.delayed(Duration(seconds: 10));
    if (!mounted) return;
    Navigator.pushNamed(context, AppRoutes.home);
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage(image: 'card.json'),

                SizedBox(height: 32.h),

                Text(
                  'تم الدفع بنجاح',
                  style: AppStyle.bold24,
                ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              maxBlastForce: 30,
              minBlastForce: 10,

              numberOfParticles: 200,

              gravity: 0.3,

              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
