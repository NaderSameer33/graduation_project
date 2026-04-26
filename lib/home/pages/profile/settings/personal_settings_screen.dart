import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:etmaen/core/ui/app_color.dart';
import 'package:etmaen/core/ui/app_style.dart';
import 'package:etmaen/core/logic/user_prefs.dart';

class PersonalSettingsScreen extends StatefulWidget {
  const PersonalSettingsScreen({super.key});
  @override
  State<PersonalSettingsScreen> createState() => _PersonalSettingsScreenState();
}

class _PersonalSettingsScreenState extends State<PersonalSettingsScreen> {
  final _formKey  = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl= TextEditingController();
  final _passCtrl = TextEditingController();
  final _picker   = ImagePicker();

  bool       _showPass  = false;
  bool       _isSaving  = false;
  bool       _isLoading = true;
  Uint8List? _avatarBytes;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _nameCtrl.dispose(); _emailCtrl.dispose(); _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final p = await UserPrefs.loadProfile();
    if (!mounted) return;
    setState(() {
      _nameCtrl.text  = p['name']  as String;
      _emailCtrl.text = p['email'] as String;
      _avatarBytes    = p['avatarBytes'] as Uint8List?;
      _isLoading      = false;
    });
  }

  Future<void> _pickImage() async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.card,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const SizedBox(height: 12),
          Container(width: 40, height: 4,
              decoration: BoxDecoration(color: AppColors.textDisabled,
                  borderRadius: BorderRadius.circular(4))),
          const SizedBox(height: 12),
          const Text('اختر الصورة من',
              style: TextStyle(color: Colors.white, fontSize: 16,
                  fontFamily: 'Cairo', fontWeight: FontWeight.w700)),
          ListTile(
            leading: const Icon(Icons.camera_alt_rounded, color: AppColors.primaryTop),
            title: const Text('الكاميرا',
                style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
            onTap: () async {
              Navigator.pop(context);
              try {
                final img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
                if (img != null) {
                  final b = await img.readAsBytes();
                  if (mounted) setState(() => _avatarBytes = b);
                }
              } catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('تعذر الوصول للكاميرا. تحقق من الصلاحيات.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo')),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library_rounded, color: AppColors.primaryTop),
            title: const Text('معرض الصور',
                style: TextStyle(color: Colors.white, fontFamily: 'Cairo')),
            onTap: () async {
              Navigator.pop(context);
              try {
                final img = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
                if (img != null) {
                  final b = await img.readAsBytes();
                  if (mounted) setState(() => _avatarBytes = b);
                }
              } catch (_) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('تعذر الوصول للصور. تحقق من الصلاحيات.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontFamily: 'Cairo')),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ));
                }
              }
            },
          ),
          if (_avatarBytes != null)
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
              title: const Text('حذف الصورة',
                  style: TextStyle(color: Colors.redAccent, fontFamily: 'Cairo')),
              onTap: () {
                Navigator.pop(context);
                setState(() => _avatarBytes = null);
                UserPrefs.clearAvatar();
              },
            ),
          const SizedBox(height: 8),
        ]),
      ),
    );
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await UserPrefs.saveName(_nameCtrl.text.trim());
    await UserPrefs.saveEmail(_emailCtrl.text.trim());
    if (_avatarBytes != null) await UserPrefs.saveAvatarBytes(_avatarBytes!);
    if (!mounted) return;
    setState(() => _isSaving = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('تم تحديث البيانات بنجاح ✓',
          textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Cairo')),
      backgroundColor: AppColors.primaryBot,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: AppColors.primaryTop))
            : SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(16, 16, 16, bottom + 40),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    // Header
                    Row(children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(width: 36, height: 36,
                          decoration: BoxDecoration(color: AppColors.card,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.chevron_right_rounded,
                              color: Colors.white, size: 22)),
                      ),
                      const Spacer(),
                      const Flexible(child: Text('تعديل بياناتك الشخصية',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 17,
                            fontFamily: 'Cairo', fontWeight: FontWeight.w700))),
                    ]),
                    const SizedBox(height: 32),

                    // Avatar
                    Center(child: GestureDetector(
                      onTap: _pickImage,
                      child: Stack(children: [
                        Container(
                          width: 96, height: 96, clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: const Color(0xFF2A2A2A), shape: BoxShape.circle,
                            border: Border.all(
                                color: AppColors.primaryTop.withOpacity(0.4), width: 2)),
                          // ✅ Image.memory — no crash on web/mobile
                          child: _avatarBytes != null
                            ? Image.memory(_avatarBytes!, fit: BoxFit.cover)
                            : const Icon(Icons.person_rounded,
                                color: Color(0xFF555555), size: 56),
                        ),
                        Positioned(bottom: 2, right: 2,
                          child: Container(width: 30, height: 30,
                            decoration: const BoxDecoration(
                                gradient: AppGradients.primary, shape: BoxShape.circle),
                            child: const Icon(Icons.camera_alt_rounded,
                                color: Colors.white, size: 16))),
                      ]),
                    )),
                    const SizedBox(height: 8),
                    const Center(child: Text('اضغط لتغيير الصورة',
                        style: TextStyle(color: AppColors.textDisabled,
                            fontSize: 11, fontFamily: 'Cairo'))),
                    const SizedBox(height: 28),

                    // Name
                    _lbl('الاسم'),
                    _field(_nameCtrl, Icons.person_outline_rounded, 'اسمك الكامل',
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'الاسم مطلوب' : null),
                    const SizedBox(height: 20),

                    // Email
                    _lbl('البريد الإلكتروني'),
                    _field(_emailCtrl, Icons.email_outlined, 'بريدك الإلكتروني',
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.left,
                        validator: (v) => (v == null || !v.contains('@'))
                            ? 'بريد إلكتروني غير صحيح' : null),
                    const SizedBox(height: 20),

                    // Password
                    _lbl('كلمة المرور'),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.card, borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        controller: _passCtrl, obscureText: !_showPass,
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.white,
                            fontFamily: 'Cairo', fontSize: 15),
                        decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () => setState(() => _showPass = !_showPass),
                            child: Icon(
                              _showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              color: AppColors.textDisabled, size: 20)),
                          suffixIcon: const Icon(Icons.lock_outline_rounded,
                              color: AppColors.textDisabled, size: 20),
                          hintText: '••••••••',
                          hintStyle: const TextStyle(
                              color: AppColors.textDisabled, fontFamily: 'Cairo'),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16)),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Save button
                    GestureDetector(
                      onTap: _isSaving ? null : _save,
                      child: Container(
                        width: double.infinity, height: 56,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColors.primaryTop, AppColors.primaryBot],
                            begin: Alignment.topCenter, end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.circular(30)),
                        child: Center(child: _isSaving
                          ? const SizedBox(width: 24, height: 24,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2))
                          : const Text('تعديل البيانات',
                              style: TextStyle(color: Colors.white, fontSize: 16,
                                  fontFamily: 'Cairo', fontWeight: FontWeight.w700))),
                      ),
                    ),
                  ]),
                ),
              ),
        ),
      ),
    );
  }

  Widget _lbl(String t) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Text(t, style: const TextStyle(color: AppColors.textSecondary,
        fontSize: 12, fontFamily: 'Cairo')));

  Widget _field(TextEditingController ctrl, IconData icon, String hint,
      {TextInputType? keyboardType,
       TextAlign textAlign = TextAlign.right,
       FormFieldValidator<String>? validator}) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.card, borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: ctrl, validator: validator,
        keyboardType: keyboardType, textAlign: textAlign,
        style: const TextStyle(color: Colors.white, fontFamily: 'Cairo', fontSize: 15),
        decoration: InputDecoration(
          suffixIcon: Icon(icon, color: AppColors.textDisabled, size: 20),
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.textDisabled, fontFamily: 'Cairo'),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          errorStyle: const TextStyle(fontFamily: 'Cairo', fontSize: 11)),
      ),
    );
  }
}
