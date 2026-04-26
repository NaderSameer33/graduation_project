import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'payment_success_screen.dart';

// ─────────────────────────────────────────────
//  Add Card / Payment Screen
//  Credit card form with real-time card preview.
//  Supports multiple saved cards.
// ─────────────────────────────────────────────

// ── Saved card data model ─────────────────────
class _SavedCard {
  _SavedCard({
    required this.name,
    required this.last4,
    required this.expiry,
  });
  final String name;
  final String last4;
  final String expiry;
}

// ─────────────────────────────────────────────
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl   = TextEditingController(text: 'Habiba Elemam');
  final _cardCtrl   = TextEditingController();
  final _expiryCtrl = TextEditingController(text: '02/24');
  final _cvvCtrl    = TextEditingController();

  bool _saveCard   = true;
  bool _showCvv    = false;
  bool _isLoading  = false;

  // Currently selected card index (-1 = new form card)
  int _selectedIndex = -1;

  // Saved cards list
  final List<_SavedCard> _savedCards = [];

  // Formatted card display (shows dots + last 4 digits)
  String get _displayCard {
    final raw = _cardCtrl.text.replaceAll(' ', '');
    if (raw.length >= 4) {
      final last4 = raw.substring(raw.length - 4);
      return '•••• •••• •••• $last4';
    }
    return '•••• •••• •••• ••••';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _cardCtrl.dispose();
    _expiryCtrl.dispose();
    _cvvCtrl.dispose();
    super.dispose();
  }

  // ── Validators ────────────────────────────
  String? _validateName(String? v) {
    if (v == null || v.trim().isEmpty) return 'أدخل الاسم على البطاقة';
    return null;
  }

  String? _validateCard(String? v) {
    if (v == null || v.replaceAll(' ', '').length < 16) {
      return 'رقم البطاقة يجب أن يكون 16 رقم';
    }
    return null;
  }

  String? _validateExpiry(String? v) {
    if (v == null || !RegExp(r'^\d{2}/\d{2}$').hasMatch(v)) {
      return 'صيغة غير صحيحة (مثال: 02/24)';
    }
    return null;
  }

  String? _validateCvv(String? v) {
    if (v == null || v.length < 3) return 'أدخل CVV صحيح';
    return null;
  }

  // ── Save card to list ─────────────────────
  void _saveToList() {
    if (!_formKey.currentState!.validate()) return;
    final raw = _cardCtrl.text.replaceAll(' ', '');
    final last4 = raw.length >= 4 ? raw.substring(raw.length - 4) : '••••';
    setState(() {
      _savedCards.add(_SavedCard(
        name: _nameCtrl.text.trim(),
        last4: last4,
        expiry: _expiryCtrl.text,
      ));
      _selectedIndex = _savedCards.length - 1;
      // Clear form for next potential card
      _cardCtrl.clear();
      _cvvCtrl.clear();
      _nameCtrl.text = '';
      _expiryCtrl.text = '';
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('تم إضافة البطاقة بنجاح ✓',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: 'Cairo')),
      backgroundColor: AppColors.primaryBot,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
  }

  // ── Pay ───────────────────────────────────
  void _pay() async {
    // If paying with new card form
    if (_selectedIndex == -1 && !_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const PaymentSuccessScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
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
                        'اضافة بطاقة جديدة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // ── Card preview scroll ──────────────
                LayoutBuilder(
                  builder: (context, constraints) {
                    final cardW = (constraints.maxWidth - 32).clamp(200.0, 320.0);
                    return SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        children: [
                          // New card preview (the form card)
                          GestureDetector(
                            onTap: () => setState(() => _selectedIndex = -1),
                            child: _CardPreview(
                              name: _nameCtrl.text.isEmpty ? 'Card Holder' : _nameCtrl.text,
                              cardDisplay: _displayCard,
                              expiry: _expiryCtrl.text,
                              isSelected: _selectedIndex == -1,
                              width: cardW,
                            ),
                          ),
                          // Saved cards
                          ..._savedCards.asMap().entries.map((e) {
                            final i = e.key;
                            final c = e.value;
                            return Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: GestureDetector(
                                onTap: () => setState(() => _selectedIndex = i),
                                child: _CardPreview(
                                  name: c.name,
                                  cardDisplay: '•••• •••• •••• ${c.last4}',
                                  expiry: c.expiry,
                                  isSelected: _selectedIndex == i,
                                  width: cardW,
                                ),
                              ),
                            );
                          }),
                          // "Add new card" slot
                          Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = -1;
                                  _cardCtrl.clear();
                                  _cvvCtrl.clear();
                                  _nameCtrl.text = '';
                                  _expiryCtrl.text = '';
                                });
                              },
                              child: Container(
                                width: cardW,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5B1FA3).withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                      color: AppColors.primaryTop.withOpacity(0.4),
                                      width: 1.5,
                                      style: BorderStyle.solid),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_card_rounded,
                                        color: AppColors.primaryTop, size: 36),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'إضافة بطاقة',
                                      style: TextStyle(
                                        color: AppColors.primaryTop,
                                        fontFamily: 'Cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // ── Card info hint (when a saved card is selected) ──
                if (_selectedIndex >= 0 && _selectedIndex < _savedCards.length)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.credit_card_rounded,
                              color: AppColors.primaryTop, size: 22),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'البطاقة المحددة: •••• ${_savedCards[_selectedIndex].last4}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'Cairo',
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // ── Form (shown when adding new card) ──
                if (_selectedIndex == -1)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // Name on card
                            const _FormLabel('Name on card'),
                            _StyledTextFormField(
                              controller: _nameCtrl,
                              hint: 'Habiba Elemam',
                              validator: _validateName,
                              onChanged: (_) => setState(() {}),
                              textAlign: TextAlign.left,
                            ),

                            const SizedBox(height: 16),

                            // Card number — 16 digits, single space separator = 19 chars
                            const _FormLabel('Card number'),
                            _StyledTextFormField(
                              controller: _cardCtrl,
                              hint: '1234 5678 9012 3456',
                              validator: _validateCard,
                              keyboardType: TextInputType.number,
                              maxLength: 19, // 16 digits + 3 spaces
                              onChanged: (_) => setState(() {}),
                              textAlign: TextAlign.left,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                _CardNumberFormatter(),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Expiry and CVV row
                            Row(
                              children: [
                                // CVV
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: _FormLabel('CVV'),
                                      ),
                                      TextFormField(
                                        controller: _cvvCtrl,
                                        obscureText: !_showCvv,
                                        keyboardType: TextInputType.number,
                                        maxLength: 4,
                                        validator: _validateCvv,
                                        textAlign: TextAlign.left,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                        ],
                                        decoration: InputDecoration(
                                          hintText: '• • •',
                                          hintStyle: const TextStyle(
                                            color: AppColors.textDisabled,
                                            letterSpacing: 4,
                                          ),
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.stroke, width: 1),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.primaryTop, width: 1.5),
                                          ),
                                          counterText: '',
                                          suffixIcon: GestureDetector(
                                            onTap: () => setState(
                                                () => _showCvv = !_showCvv),
                                            child: Icon(
                                              _showCvv
                                                  ? Icons.visibility_off_rounded
                                                  : Icons.visibility_rounded,
                                              color: AppColors.textDisabled,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 20),
                                // Expiry date
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: _FormLabel('Expiry date'),
                                      ),
                                      TextFormField(
                                        controller: _expiryCtrl,
                                        keyboardType: TextInputType.datetime,
                                        maxLength: 5,
                                        validator: _validateExpiry,
                                        textAlign: TextAlign.right,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[\d/]')),
                                          _ExpiryFormatter(),
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: '02/24',
                                          hintStyle: TextStyle(
                                              color: AppColors.textDisabled),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.stroke, width: 1),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.primaryTop,
                                                width: 1.5),
                                          ),
                                          counterText: '',
                                        ),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Cairo',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Save card checkbox
                            Row(
                              children: [
                                const Text(
                                  'حفظ بيانات البطاقة',
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () =>
                                      setState(() => _saveCard = !_saveCard),
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: _saveCard
                                          ? AppColors.primaryTop
                                          : AppColors.card,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: AppColors.primaryTop,
                                        width: 1.5,
                                      ),
                                    ),
                                    child: _saveCard
                                        ? const Icon(Icons.check_rounded,
                                            color: Colors.white, size: 16)
                                        : null,
                                  ),
                                ),
                              ],
                            ),

                            // "Save card to list" button
                            if (_saveCard) ...[
                              const SizedBox(height: 16),
                              GestureDetector(
                                onTap: _saveToList,
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryTop, width: 1.5),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'حفظ البطاقة',
                                      style: TextStyle(
                                        color: AppColors.primaryTop,
                                        fontSize: 15,
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                const SizedBox(height: 24),

                // ── Pay button ───────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GestureDetector(
                    onTap: _isLoading ? null : _pay,
                    child: Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            AppColors.primaryTop,
                            AppColors.primaryBot,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'دفع',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Card Preview Widget ─────────────────────────────
class _CardPreview extends StatelessWidget {
  const _CardPreview({
    required this.name,
    required this.cardDisplay,
    required this.expiry,
    this.isSelected = false,
    this.width = 300,
  });

  final String name;
  final String cardDisplay;
  final String expiry;
  final bool isSelected;
  final double width;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: 190,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF9B5FCC), Color(0xFF4A2D6E)],
        ),
        borderRadius: BorderRadius.circular(20),
        border: isSelected
            ? Border.all(color: Colors.white.withOpacity(0.6), width: 2)
            : null,
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primaryTop.withOpacity(0.5),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                )
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Visa logo area
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'VISA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                ),
              ),
              if (isSelected)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'محددة',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          // Card number display
          Text(
            cardDisplay,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Cairo',
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          // Name + expiry row
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Expires',
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    expiry.isEmpty ? '12/23' : expiry,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Card Holder',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      name.isEmpty ? 'Card Holder' : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ────────────────────────────
class _FormLabel extends StatelessWidget {
  const _FormLabel(this.label);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _StyledTextFormField extends StatelessWidget {
  const _StyledTextFormField({
    required this.controller,
    required this.hint,
    required this.validator,
    this.onChanged,
    this.keyboardType,
    this.maxLength,
    this.textAlign = TextAlign.right,
    this.inputFormatters = const [],
  });

  final TextEditingController controller;
  final String hint;
  final FormFieldValidator<String> validator;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextAlign textAlign;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLength: maxLength,
      textAlign: textAlign,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: 'Cairo',
        fontSize: 15,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textDisabled),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.stroke, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryTop, width: 1.5),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
        ),
        counterText: '',
        errorStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 11),
      ),
    );
  }
}

// ── Card Number Formatter (single space separator) ──
// Output: "1234 5678 9012 3456" = 19 chars (16 digits + 3 spaces)
class _CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Strip all non-digit characters first
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    // Cap at 16 digits
    final capped = digits.length > 16 ? digits.substring(0, 16) : digits;
    // Insert a single space every 4 digits
    final buffer = StringBuffer();
    for (int i = 0; i < capped.length; i++) {
      if (i > 0 && i % 4 == 0) buffer.write(' ');
      buffer.write(capped[i]);
    }
    final newText = buffer.toString();
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

// ── Expiry Date Formatter ─────────────────────
class _ExpiryFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text.replaceAll('/', '');
    if (text.length > 2) {
      text = '${text.substring(0, 2)}/${text.substring(2)}';
    }
    if (text.length > 5) text = text.substring(0, 5);
    return newValue.copyWith(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
