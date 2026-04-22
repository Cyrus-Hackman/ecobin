import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class RegistrationFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController firstNameCtrl;
  final TextEditingController lastNameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController phoneCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmPasswordCtrl;
  final TextEditingController streetCtrl;
  final TextEditingController cityCtrl;
  final TextEditingController postalCtrl;
  final bool termsAccepted;
  final bool isLoading;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onSubmit;
  final bool isTablet;

  const RegistrationFormWidget({
    super.key,
    required this.formKey,
    required this.firstNameCtrl,
    required this.lastNameCtrl,
    required this.emailCtrl,
    required this.phoneCtrl,
    required this.passwordCtrl,
    required this.confirmPasswordCtrl,
    required this.streetCtrl,
    required this.cityCtrl,
    required this.postalCtrl,
    required this.termsAccepted,
    required this.isLoading,
    required this.onTermsChanged,
    required this.onSubmit,
    required this.isTablet,
  });

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border(
          left: BorderSide(color: AppTheme.primaryGreen, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withAlpha(26),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: AppTheme.primaryGreen),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...children,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          _sectionCard(
            title: 'Personal Information',
            icon: Icons.person_outline_rounded,
            children: [
              if (widget.isTablet)
                Row(
                  children: [
                    Expanded(child: _firstNameField()),
                    const SizedBox(width: 12),
                    Expanded(child: _lastNameField()),
                  ],
                )
              else ...[
                _firstNameField(),
                const SizedBox(height: 14),
                _lastNameField(),
              ],
              const SizedBox(height: 14),
              TextFormField(
                controller: widget.emailCtrl,
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'Email address',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Email is required';
                  if (!v.contains('@')) return 'Enter a valid email address';
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: widget.phoneCtrl,
                keyboardType: TextInputType.phone,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'Phone number',
                  hintText: '+1 (555) 000-0000',
                  prefixIcon: Icon(
                    Icons.phone_outlined,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Phone number is required';
                  if (v.length < 8) return 'Enter a valid phone number';
                  return null;
                },
              ),
            ],
          ),
          _sectionCard(
            title: 'Account Security',
            icon: Icons.security_rounded,
            children: [
              TextFormField(
                controller: widget.passwordCtrl,
                obscureText: _obscurePassword,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: AppTheme.textMuted,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: widget.confirmPasswordCtrl,
                obscureText: _obscureConfirm,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
                decoration: InputDecoration(
                  labelText: 'Confirm password',
                  prefixIcon: const Icon(
                    Icons.lock_outline_rounded,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirm
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: 20,
                      color: AppTheme.textMuted,
                    ),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (v != widget.passwordCtrl.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ],
          ),
          _sectionCard(
            title: 'Default Home Address',
            icon: Icons.home_outlined,
            children: [
              TextFormField(
                controller: widget.streetCtrl,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  color: AppTheme.textPrimary,
                ),
                decoration: const InputDecoration(
                  labelText: 'Street address',
                  hintText: '123 Maple Street',
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    size: 20,
                    color: AppTheme.textMuted,
                  ),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Street address is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              if (widget.isTablet)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: widget.cityCtrl,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                        ),
                        decoration: const InputDecoration(labelText: 'City'),
                        validator: (v) => (v == null || v.isEmpty)
                            ? 'City is required'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: widget.postalCtrl,
                        keyboardType: TextInputType.number,
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          color: AppTheme.textPrimary,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Postal code',
                        ),
                        validator: (v) =>
                            (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                    ),
                  ],
                )
              else ...[
                TextFormField(
                  controller: widget.cityCtrl,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'City',
                    prefixIcon: Icon(
                      Icons.location_city_outlined,
                      size: 20,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  validator: (v) =>
                      (v == null || v.isEmpty) ? 'City is required' : null,
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: widget.postalCtrl,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    color: AppTheme.textPrimary,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Postal / ZIP code',
                    prefixIcon: Icon(
                      Icons.markunread_mailbox_outlined,
                      size: 20,
                      color: AppTheme.textMuted,
                    ),
                  ),
                  validator: (v) => (v == null || v.isEmpty)
                      ? 'Postal code is required'
                      : null,
                ),
              ],
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: widget.termsAccepted,
                onChanged: widget.onTermsChanged,
                activeColor: AppTheme.primaryGreen,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        color: AppTheme.textMuted,
                      ),
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B5E20), AppTheme.primaryGreen],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withAlpha(77),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: widget.isLoading ? null : widget.onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: widget.isLoading
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Create My Account',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _firstNameField() {
    return TextFormField(
      controller: widget.firstNameCtrl,
      textCapitalization: TextCapitalization.words,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        color: AppTheme.textPrimary,
      ),
      decoration: const InputDecoration(
        labelText: 'First name',
        prefixIcon: Icon(
          Icons.badge_outlined,
          size: 20,
          color: AppTheme.textMuted,
        ),
      ),
      validator: (v) =>
          (v == null || v.isEmpty) ? 'First name is required' : null,
    );
  }

  Widget _lastNameField() {
    return TextFormField(
      controller: widget.lastNameCtrl,
      textCapitalization: TextCapitalization.words,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 15,
        color: AppTheme.textPrimary,
      ),
      decoration: const InputDecoration(
        labelText: 'Last name',
        prefixIcon: Icon(
          Icons.badge_outlined,
          size: 20,
          color: AppTheme.textMuted,
        ),
      ),
      validator: (v) =>
          (v == null || v.isEmpty) ? 'Last name is required' : null,
    );
  }
}
