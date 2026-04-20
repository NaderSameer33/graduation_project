import 'package:confetti/confetti.dart';
import 'package:etmaen/ai/quiz_onborading/widget/ai_analysis_item.dart';
import 'package:etmaen/core/logic/app_routes.dart';
import 'package:etmaen/core/ui/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiAnalysisView extends StatefulWidget {
  const AiAnalysisView({super.key});

  @override
  State<AiAnalysisView> createState() => _AiAnalysisViewState();
}

class _AiAnalysisViewState extends State<AiAnalysisView> {
  late ConfettiController confettiController;

  @override
  void initState() {
    super.initState();
    confettiController = ConfettiController(duration: Duration(seconds: 2));
    startAnalysis();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  void startAnalysis() async {
    await Future.delayed(const Duration(seconds: 5));

    confettiController.play();
    if (!mounted) return;
    showDialog(context: context, builder: (context) => SuccessDialog());

    await Future.delayed(
      const Duration(seconds: 5),
    );

    if (!mounted) return;
    Navigator.pop(context);
    Navigator.pushNamed(context, AppRoutes.appPlan);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.r),
          child: Stack(
            children: [
              AiAnialysisItem(),
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
        ),
      ),
    );
  }
}
