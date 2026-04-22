import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme/app_theme.dart';

class DemoCredentialsWidget extends StatelessWidget {
  final VoidCallback onUseDemoCredentials;

  const DemoCredentialsWidget({super.key, required this.onUseDemoCredentials});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryGreen.withAlpha(15),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppTheme.primaryGreen.withAlpha(51),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppTheme.primaryGreen,
              ),
              const SizedBox(width: 6),
              Text(
                'Demo Account',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _CredentialRow(label: 'Email', value: 'maya.chen@ecobin.app'),
          const SizedBox(height: 6),
          _CredentialRow(
            label: 'Password',
            value: 'EcoGreen2024!',
            obscure: true,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onUseDemoCredentials,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryGreen,
                side: const BorderSide(
                  color: AppTheme.primaryGreen,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
              child: Text(
                'Use Demo Credentials',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CredentialRow extends StatefulWidget {
  final String label;
  final String value;
  final bool obscure;

  const _CredentialRow({
    required this.label,
    required this.value,
    this.obscure = false,
  });

  @override
  State<_CredentialRow> createState() => _CredentialRowState();
}

class _CredentialRowState extends State<_CredentialRow> {
  bool _copied = false;

  void _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.value));
    setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(
            widget.label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppTheme.textMuted,
            ),
          ),
        ),
        Expanded(
          child: Text(
            widget.obscure ? '••••••••••••' : widget.value,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        GestureDetector(
          onTap: _copy,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Icon(
              _copied ? Icons.check_rounded : Icons.copy_rounded,
              key: ValueKey(_copied),
              size: 16,
              color: _copied ? AppTheme.success : AppTheme.textMuted,
            ),
          ),
        ),
      ],
    );
  }
}