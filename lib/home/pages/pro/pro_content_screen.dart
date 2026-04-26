import 'package:flutter/material.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import '../payment/add_card_screen.dart';

// ─────────────────────────────────────────────
//  Pro Content Screen
//  Subscription comparison table + pricing.
//  Matches design: "Pro Content.png"
// ─────────────────────────────────────────────

class ProContentScreen extends StatefulWidget {
  const ProContentScreen({super.key});

  @override
  State<ProContentScreen> createState() => _ProContentScreenState();
}

class _ProContentScreenState extends State<ProContentScreen> {
  // 0 = annual, 1 = monthly
  int _selectedPlan = 0;

  // Comparison features: [label, freeIncluded, paidIncluded]
  static const List<Map<String, dynamic>> _features = [
    {
      'label': 'فيديوهات وبرامج دعم نفسي',
      'free': true,
      'paid': true,
    },
    {
      'label': 'تمارين تنهدئة وتنظيم المشاعر',
      'free': true,
      'paid': true,
    },
    {
      'label': 'تحديات يومية لكسر مخاوفك',
      'free': true,
      'paid': true,
    },
    {
      'label': 'مساعد لإعادة صياغة افكارك السلبية',
      'free': true,
      'paid': true,
    },
    {
      'label': 'جلسات الواقع الافتراضي للاسترخاء',
      'free': false,
      'paid': true,
    },
    {
      'label': 'ركن القراءة والدعم المعرفي',
      'free': false,
      'paid': true,
    },
    {
      'label': 'التفاعل الذكي مع المساعد الشخصي',
      'free': false,
      'paid': true,
    },
    {
      'label': 'المزامنة مع خاتم اطمئن',
      'free': false,
      'paid': true,
    },
    {
      'label': 'بناء علاقات صحية صحيحة',
      'free': true,
      'paid': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.chevron_right_rounded,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'اطمئن برو',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Subtitle
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'تمتع بمیزات اضافية من خلال الترقية الى برو',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ── Feature table ────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Table header
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                        ),
                        child: const Row(
                          children: [
                            _ColHeader('مدفوع'),
                            SizedBox(width: 16),
                            _ColHeader('مجاني'),
                            Spacer(),
                            _ColHeader('الميزات'),
                          ],
                        ),
                      ),

                      // Feature rows
                      ...List.generate(_features.length, (i) {
                        final f = _features[i];
                        final isLast = i == _features.length - 1;
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          decoration: BoxDecoration(
                            color: AppColors.card,
                            borderRadius: isLast
                                ? const BorderRadius.vertical(
                                    bottom: Radius.circular(16))
                                : null,
                            border: const Border(
                              top: BorderSide(
                                  color: Color(0xFF2A2A2A), width: 1),
                            ),
                          ),
                          child: Row(
                            children: [
                              // Paid check
                              _CheckIcon(included: f['paid'] as bool),
                              const SizedBox(width: 30),
                              // Free check
                              _CheckIcon(included: f['free'] as bool),
                              const Spacer(),
                              // Feature label
                              Text(
                                f['label'] as String,
                                textAlign: TextAlign.right,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 20),

                      // ── Plan selector ─────────────
                      _PlanOption(
                        title: 'اشتراك لمدة عام',
                        subtitle: '208 ج.م لكل شهر',
                        price: '2500 ج.م',
                        isSelected: _selectedPlan == 0,
                        onTap: () =>
                            setState(() => _selectedPlan = 0),
                      ),
                      const SizedBox(height: 10),
                      _PlanOption(
                        title: 'اشتراك لمدة شهر',
                        subtitle: '',
                        price: '350 ج.م',
                        isSelected: _selectedPlan == 1,
                        onTap: () =>
                            setState(() => _selectedPlan = 1),
                      ),

                      const SizedBox(height: 24),

                      // ── Upgrade button ────────────
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AddCardScreen()),
                        ),
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.primaryTop,
                                AppColors.primaryBot
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text(
                              'الترقية الى Pro',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Table header cell ─────────────────────────
class _ColHeader extends StatelessWidget {
  const _ColHeader(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: 12,
        fontFamily: 'Cairo',
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

// ── Check / X icon ────────────────────────────
class _CheckIcon extends StatelessWidget {
  const _CheckIcon({required this.included});
  final bool included;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: included
            ? const Color(0xFF4CAF50).withOpacity(0.2)
            : Colors.redAccent.withOpacity(0.15),
      ),
      child: Icon(
        included ? Icons.check_rounded : Icons.close_rounded,
        color: included ? const Color(0xFF4CAF50) : Colors.redAccent,
        size: 14,
      ),
    );
  }
}

// ── Plan option card ──────────────────────────
class _PlanOption extends StatelessWidget {
  const _PlanOption({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryTop
                : const Color(0xFF2A2A2A),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            // Price tag
            Text(
              price,
              style: TextStyle(
                color: isSelected
                    ? AppColors.primaryTop
                    : AppColors.textSecondary,
                fontSize: 15,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            // Title + subtitle
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontFamily: 'Cairo',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
