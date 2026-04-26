import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';

// ─────────────────────────────────────────────
//  All Settings-screen Dialogs
//
//  • RateAppDialog      (rate.png)
//  • LeaveMessageDialog (message.png)
//  • ProblemDialog      (probllem.png)
//  • DeleteAccountDialog
// ─────────────────────────────────────────────

// ── Shared gradient button ────────────────────
class _GradientButton extends StatelessWidget {
  const _GradientButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.primaryTop, AppColors.primaryBot],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Shared outlined button ────────────────────
class _OutlinedButton extends StatelessWidget {
  const _OutlinedButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.stroke, width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Rate App Dialog  (rate.png)
// ─────────────────────────────────────────────
class RateAppDialog extends StatelessWidget {
  const RateAppDialog({
    super.key,
    required this.onLeaveMessage,
    required this.onRate,
  });

  final VoidCallback onLeaveMessage;
  final VoidCallback onRate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close ×
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded,
                      color: AppColors.textSecondary, size: 22),
                ),
              ),
              // Heart icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryTop.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.favorite_rounded,
                    color: AppColors.primaryTop, size: 32),
              ),
              const SizedBox(height: 16),
              const Text(
                'هل اعجبك التطبيق؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'رأيك يهمنا ويساعدنا على التطوير',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 24),
              _OutlinedButton(label: 'اترك لنا رسالة', onTap: onLeaveMessage),
              const SizedBox(height: 10),
              _GradientButton(label: 'قم بتقييم التطبيق', onTap: onRate),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Leave Message Dialog  (message.png)
// ─────────────────────────────────────────────
class LeaveMessageDialog extends StatefulWidget {
  const LeaveMessageDialog({super.key});

  @override
  State<LeaveMessageDialog> createState() => _LeaveMessageDialogState();
}

class _LeaveMessageDialogState extends State<LeaveMessageDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded,
                      color: AppColors.textSecondary, size: 22),
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryTop.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.check_rounded,
                    color: AppColors.primaryTop, size: 30),
              ),
              const SizedBox(height: 14),
              const Text(
                'اترك لنا رسالة\nتساعدنا على التطوير',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _ctrl,
                  textAlign: TextAlign.right,
                  maxLines: 4,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Cairo', fontSize: 13),
                  decoration: const InputDecoration(
                    hintText:
                        'هل هناك شيء تود تحسينه أو ميزة تود إضافتها؟ شاركنا أفكارك',
                    hintStyle: TextStyle(
                        color: AppColors.textDisabled,
                        fontFamily: 'Cairo',
                        fontSize: 12),
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _GradientButton(
                label: 'ارسال',
                onTap: () {
                  if (_ctrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء كتابة رسالتك أولاً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم إرسال رسالتك بنجاح',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Cairo')),
                      backgroundColor: AppColors.primaryTop,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Problem Dialog  (probllem.png)
// ─────────────────────────────────────────────
class ProblemDialog extends StatefulWidget {
  const ProblemDialog({super.key});

  @override
  State<ProblemDialog> createState() => _ProblemDialogState();
}

class _ProblemDialogState extends State<ProblemDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close_rounded,
                      color: AppColors.textSecondary, size: 22),
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primaryTop.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.headset_mic_rounded,
                    color: AppColors.primaryTop, size: 28),
              ),
              const SizedBox(height: 14),
              const Text(
                'هل واجهتك مشكلة؟',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _ctrl,
                  textAlign: TextAlign.right,
                  maxLines: 4,
                  style: const TextStyle(
                      color: Colors.white, fontFamily: 'Cairo', fontSize: 13),
                  decoration: const InputDecoration(
                    hintText: 'اكتب سؤالك وسنتواصل معك في أقرب وقت',
                    hintStyle: TextStyle(
                        color: AppColors.textDisabled,
                        fontFamily: 'Cairo',
                        fontSize: 12),
                    contentPadding: EdgeInsets.all(12),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _GradientButton(
                label: 'ارسال',
                onTap: () {
                  if (_ctrl.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('الرجاء وصف المشكلة أولاً',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontFamily: 'Cairo')),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                    return;
                  }
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'تم إرسال استفسارك بنجاح، سنتواصل معك قريباً',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Cairo')),
                      backgroundColor: AppColors.primaryTop,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Delete Account Dialog
// ─────────────────────────────────────────────
class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    super.key,
    required this.onKeep,
    required this.onDelete,
  });

  final VoidCallback onKeep;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppColors.card,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.delete_outline_rounded,
              color: Colors.redAccent, size: 28),
        ),
        title: const Text(
          'حذف الحساب',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontFamily: 'Cairo', fontSize: 18),
        ),
        content: const Text(
          'هل أنت متأكد من حذف حسابك؟ لن تتمكن من استعادته.',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: AppColors.textSecondary,
              fontFamily: 'Cairo',
              fontSize: 13),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: onKeep,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: AppColors.stroke, width: 1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('تراجع',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Cairo')),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text('حذف',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w700)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
